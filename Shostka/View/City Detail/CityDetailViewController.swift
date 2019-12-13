import UIKit
import Kingfisher
import Charts

private enum Segues: String {
    case showInfo = "showInfo"
}

struct MyGitHub: Codable {
    
    let arrXAxis: [Double?]
    let arrValue: [Double?]
    let arrValueName: [String?]
    let four: Int?
    
    
    private enum CodingKeys: String, CodingKey {
        case arrXAxis
        case arrValue
        case arrValueName
        case four
    }
}

private enum Constants {
    // Placeholder image for the cities that don't have photo (has the same name as appropriate image in assets folder).
     static let cityImagePlaceholder = "CityPlaceholder"
}

/**
 City detail controller to show information about specific city.
 */
final class CityDetailViewController: UIViewController {
    @IBOutlet private weak var cityImage: UIImageView!
   // @IBOutlet private weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var chartView: LineChartView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    // var months: [String]!
    
    /**
     Get currently represented city or set the new city to update detail page information.
     If you set nil value, city information will be cleared from page.
     */
    var city: City?
    var sensorStationNumber: Int = 0
    var xAxisDotsCountToGet: Int = 8
    var timeFormat: String = "HH:mm"
    
    var getParametrID: Int = 0
    
    /// Timer Area
    
    override func viewWillAppear(_ animated: Bool) {
//        print("Load")
        myDataChart()
        startTimer()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        print("UnLoad")
        stopTimer()
        
    }
    
    
    weak var timer: Timer?
    
    deinit {
        timer?.invalidate()
    }
    
    func timerHandler(_ timer: Timer) {
//        let hola = "myDataChartTimer"
//        print(">>>> \(hola)")
        myDataChart()
    }
    
    func startTimer() {
        timer?.invalidate()   // stops previous timer, if any
        
        let seconds = 30.0
        timer = Timer.scheduledTimer(withTimeInterval: seconds, repeats: true) { [weak self] timer in
            self?.timerHandler(timer)
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getParametrID = city!.id

        
        while getParametrID > 99 {
            getParametrID -= 100
        }
        
        
//        if (getParametrID == 9) || (getParametrID == 10) {
//            performSegue(withIdentifier: "showInfo", sender: nil)
//        }
//
        
          setupData()
          setupChartFromJSON()
        }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else {
            return
        }
        
        switch segueIdentifier {
        case Segues.showInfo.rawValue:
          guard let infoController = segue.destination as? LocalInfoController else {
                return
            }
            
           // detailsController.city = cityCell.city
            infoController.id = city?.id
    /*    //detailsController.sensorStationNumber = sensorStationNumber
        case Segues.showMap.rawValue:
            guard let mapController = segue.destination as? MapViewController else {
                return
            }
            
            mapController.cities = cities*/
        default:
            break
        }
    }
    
    
    
    func setupChartFromJSON() {
        
        // Do any additional setup after loading the view.
        //     self.title = "Time Line Chart"
        
        //chartView.delegate = self
        
        // self.title = city?.name
        
        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = true
        
        // llXAxis.granularity = 3600
        // xAxis.valueFormatter = DateValueFormatter()
        
        chartView.xAxis.gridLineDashLengths = [10, 10]
        chartView.xAxis.gridLineDashPhase = 0
        // chartView.xAxis.valueFormatter = DateValueFormatter()
        //  chartView.xAxis.labelTextColor = UIColor(red: 255/255, green: 192/255, blue: 56/255, alpha: 1)
        // xAxis.granularity = 3600
        let testDateFormater = DateValueFormatter()
        testDateFormater.dateFormatter.dateFormat = timeFormat
        
        
        chartView.xAxis.valueFormatter = testDateFormater as IAxisValueFormatter
        // chartView.xAxis.avoidFirstLastClippingEnabled = true
        // chartView.xAxis.spaceMax = 100
        
        

        
        /*  let ll2 = ChartLimitLine(limit: -30, label: "Нижня межа")
         ll2.lineWidth = 4
         ll2.lineDashLengths = [5,5]
         ll2.labelPosition = .rightBottom
         ll2.valueFont = .systemFont(ofSize: 10)
         ll2.lineColor = ChartColorTemplates.colorFromString("#0000ff") */
        
        let leftAxis = chartView.leftAxis
        leftAxis.removeAllLimitLines()
        
        //  leftAxis.addLimitLine(ll2)
        
        leftAxis.axisMaximum = 200
        leftAxis.axisMinimum = 0
        
        if getParametrID == 0 { //Температура
            leftAxis.axisMaximum = 80
            leftAxis.axisMinimum = -40
            let ll1 = ChartLimitLine(limit: 0, label: "")
            ll1.lineWidth = 4
            ll1.lineDashLengths = [5, 5]
            ll1.labelPosition = .topRight
            ll1.valueFont = .systemFont(ofSize: 14)
            ll1.lineColor = .black
            leftAxis.addLimitLine(ll1)
        }
        if getParametrID == 1 { //Влажность
            leftAxis.axisMaximum = 100
        }
        if getParametrID == 2 { //Атмосферное давление
            leftAxis.axisMaximum = 1000
        }
        if getParametrID == 3 { //TVOC
            leftAxis.axisMaximum = 1200
            let ll1 = ChartLimitLine(limit: 600, label: "Задовільно")
            ll1.lineWidth = 4
            ll1.lineDashLengths = [5, 5]
            ll1.labelPosition = .topRight
            ll1.valueFont = .systemFont(ofSize: 14)
            ll1.lineColor = .orange
            leftAxis.addLimitLine(ll1)
            let ll2 = ChartLimitLine(limit: 1100, label: "Верхня межа")
            ll2.lineWidth = 4
            ll2.lineDashLengths = [5, 5]
            ll2.labelPosition = .topRight
            ll2.valueFont = .systemFont(ofSize: 14)
            ll2.lineColor = .red
            leftAxis.addLimitLine(ll2)
        }
        
        if getParametrID == 4 { //Формальдегид
            leftAxis.axisMaximum = 2
            let ll1 = ChartLimitLine(limit: 0.4, label: "Задовільно")
            ll1.lineWidth = 4
            ll1.lineDashLengths = [5, 5]
            ll1.labelPosition = .topRight
            ll1.valueFont = .systemFont(ofSize: 14)
            ll1.lineColor = .orange
            leftAxis.addLimitLine(ll1)
            let ll2 = ChartLimitLine(limit: 0.8, label: "Верхня межа")
            ll2.lineWidth = 4
            ll2.lineDashLengths = [5, 5]
            ll2.labelPosition = .topRight
            ll2.valueFont = .systemFont(ofSize: 14)
            ll2.lineColor = .red
            leftAxis.addLimitLine(ll2)
        }
        
        if getParametrID == 5 { //ECO2
            leftAxis.axisMaximum = 500
            let ll1 = ChartLimitLine(limit: 150, label: "Задовільно")
            ll1.lineWidth = 4
            ll1.lineDashLengths = [5, 5]
            ll1.labelPosition = .topRight
            ll1.valueFont = .systemFont(ofSize: 14)
            ll1.lineColor = .orange
            leftAxis.addLimitLine(ll1)
            let ll2 = ChartLimitLine(limit: 300, label: "Верхня межа")
            ll2.lineWidth = 4
            ll2.lineDashLengths = [5, 5]
            ll2.labelPosition = .topRight
            ll2.valueFont = .systemFont(ofSize: 14)
            ll2.lineColor = .red
            leftAxis.addLimitLine(ll2)
        }
        
        if getParametrID == 6 { //PM1
            leftAxis.axisMaximum = 400
            let ll1 = ChartLimitLine(limit: 150, label: "Задовільно")
            ll1.lineWidth = 4
            ll1.lineDashLengths = [5, 5]
            ll1.labelPosition = .topRight
            ll1.valueFont = .systemFont(ofSize: 14)
            ll1.lineColor = .orange
            leftAxis.addLimitLine(ll1)
            let ll2 = ChartLimitLine(limit: 300, label: "Верхня межа")
            ll2.lineWidth = 4
            ll2.lineDashLengths = [5, 5]
            ll2.labelPosition = .topRight
            ll2.valueFont = .systemFont(ofSize: 14)
            ll2.lineColor = .red
            leftAxis.addLimitLine(ll2)
        }
        
        if getParametrID == 7 { //PM2
            leftAxis.axisMaximum = 400
            let ll1 = ChartLimitLine(limit: 150, label: "Задовільно")
            ll1.lineWidth = 4
            ll1.lineDashLengths = [5, 5]
            ll1.labelPosition = .topRight
            ll1.valueFont = .systemFont(ofSize: 14)
            ll1.lineColor = .orange
            leftAxis.addLimitLine(ll1)
            let ll2 = ChartLimitLine(limit: 300, label: "Верхня межа")
            ll2.lineWidth = 4
            ll2.lineDashLengths = [5, 5]
            ll2.labelPosition = .topRight
            ll2.valueFont = .systemFont(ofSize: 14)
            ll2.lineColor = .red
            leftAxis.addLimitLine(ll2)
        }
        
        if getParametrID == 8 { //PM10
            leftAxis.axisMaximum = 400
            let ll1 = ChartLimitLine(limit: 150, label: "Задовільно")
            ll1.lineWidth = 4
            ll1.lineDashLengths = [5, 5]
            ll1.labelPosition = .topRight
            ll1.valueFont = .systemFont(ofSize: 14)
            ll1.lineColor = .orange
            leftAxis.addLimitLine(ll1)
            let ll2 = ChartLimitLine(limit: 300, label: "Верхня межа")
            ll2.lineWidth = 4
            ll2.lineDashLengths = [5, 5]
            ll2.labelPosition = .topRight
            ll2.valueFont = .systemFont(ofSize: 14)
            ll2.lineColor = .red
            leftAxis.addLimitLine(ll2)
        }
        
        if getParametrID == 9 { //Дождь
            leftAxis.axisMaximum = 1
        }
        
        if getParametrID == 10 { //Напрвление ветра
            leftAxis.axisMaximum = 3
            leftAxis.axisMinimum = -3
            let ll1 = ChartLimitLine(limit: 0, label: "")
            ll1.lineWidth = 4
            ll1.lineDashLengths = [5, 5]
            ll1.labelPosition = .topRight
            ll1.valueFont = .systemFont(ofSize: 14)
            ll1.lineColor = .black
            leftAxis.addLimitLine(ll1)
        }
        
        if getParametrID == 11 { //Скорость ветра
            leftAxis.axisMaximum = 30
            let ll1 = ChartLimitLine(limit: 15, label: "Задовільно")
            ll1.lineWidth = 4
            ll1.lineDashLengths = [5, 5]
            ll1.labelPosition = .topRight
            ll1.valueFont = .systemFont(ofSize: 14)
            ll1.lineColor = .orange
            leftAxis.addLimitLine(ll1)
            let ll2 = ChartLimitLine(limit: 25, label: "Верхня межа")
            ll2.lineWidth = 4
            ll2.lineDashLengths = [5, 5]
            ll2.labelPosition = .topRight
            ll2.valueFont = .systemFont(ofSize: 14)
            ll2.lineColor = .red
            leftAxis.addLimitLine(ll2)
        }
        

        
        
       /* let ll1 = ChartLimitLine(limit: 150, label: "Верхня межа")
        ll1.lineWidth = 4
        ll1.lineDashLengths = [5, 5]
        ll1.labelPosition = .rightTop
        ll1.valueFont = .systemFont(ofSize: 10)
        leftAxis.addLimitLine(ll1)*/
        
        
        leftAxis.gridLineDashLengths = [5, 5]
        leftAxis.drawLimitLinesBehindDataEnabled = true
        
        chartView.rightAxis.enabled = false
        
        //[_chartView.viewPortHandler setMaximumScaleY: 2.f];
        //[_chartView.viewPortHandler setMaximumScaleX: 2.f];
        
        /* let marker = BalloonMarker(color: UIColor(white: 180/255, alpha: 1),
         font: .systemFont(ofSize: 12),
         textColor: .white,
         insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
         marker.chartView = chartView
         marker.minimumSize = CGSize(width: 80, height: 40)
         chartView.marker = marker*/
        chartView.legend.form = .line
        /* sliderX.value = 45
         sliderY.value = 100
         slidersValueChanged(nil)*/
        chartView.animate(xAxisDuration: 2.5)
        //self.setDataCount(5, range: 5, curentPoint: 5)
        myDataChart()
        
    }
    
  private func setupData() {
   /*  guard let city = city else {
     return
     }*/
     title = "..."
     //descriptionLabel.text = city.description
    
     // Set image using url to the image view using kingfisher extension.
     //cityImage.kf.setImage(with: city.imageUrl, placeholder: UIImage(named: Constants.cityImagePlaceholder))
     }
    
     func updateChartData(_ set3: LineChartDataSet) {

        //    chartView.data = nil
        
        //self.setDataCount(10, range: 1, set3: LineChartDataSet)
    }
    
    
    func setDataCount(_ count: Int, range: UInt32, set1: LineChartDataSet) {
        
        set1.drawIconsEnabled = false
        set1.lineDashLengths = [5, 2.5]
        set1.highlightLineDashLengths = [5, 2.5]
        set1.setColor(.black)
        set1.setCircleColor(.black)
        set1.lineWidth = 1
        set1.circleRadius = 3
        set1.drawCircleHoleEnabled = false
        set1.valueFont = .systemFont(ofSize: 9)
        set1.formLineDashLengths = [5, 2.5]
        set1.formLineWidth = 1
        set1.formSize = 15
        
        let gradientColors = [ChartColorTemplates.colorFromString("#0000ff00").cgColor,
                              ChartColorTemplates.colorFromString("#63e552").cgColor]
      //  let gradientColors = [ChartColorTemplates.colorFromString("#00ff0000").cgColor,
      //                        ChartColorTemplates.colorFromString("#ffff0000").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        set1.fillAlpha = 1
        set1.fill = Fill(linearGradient: gradient, angle: 90) //.linearGradient(gradient, angle: 90)
        set1.drawFilledEnabled = true
  
       // LineChartData(dataSets: set1.ad)
        
        let data = LineChartData(dataSet: set1)
        chartView.data = data
    }
    
    var values3: [ChartDataEntry]?
  
    
    
    func myDataChart() {
    
        var getParametr = "data"
        if getParametrID == 0 {
            getParametr = "tempDS"
        }
        if getParametrID == 1 {
            getParametr = "humidity"
        }
        if getParametrID == 2 {
            getParametr = "pressure"
        }
        if getParametrID == 3 {
            getParametr = "tvoc"
        }
        if getParametrID == 4 {
            getParametr = "ch2o"
        }
        if getParametrID == 5 {
            getParametr = "oaq"
        }
        if getParametrID == 6 {
            getParametr = "pm1"
        }
        if getParametrID == 7 {
            getParametr = "pm2"
        }
        if getParametrID == 8 {
            getParametr = "pm10"
        }
        if getParametrID == 9 {
            getParametr = "rain"
        }
        if getParametrID == 10 {
            getParametr = "winddirect"
        }
        if getParametrID == 11 {
            getParametr = "windspeed"
          // getParametr = "uvlevel"
        }
        
        
        //".$_GET[$co2].", ".$_GET[$tvoc].", ".$_GET[$pm1].", ".$_GET[$pm2].", ".$_GET[$pm10]
        let labNamberFromID: Int = city!.id / 100

        guard let gitUrl = URL(string: "http://sun.shostka.in/gps.php/?&labNamberFromID=\(labNamberFromID)&getFromApp=\(getParametr)&xAxis=\(xAxisDotsCountToGet)") else { return }
       // print(gitUrl)
        
        URLSession.shared.dataTask(with: gitUrl) { (data, response
            , error) in
            
            guard let data = data else { return }
            do {
                
                let decoder = JSONDecoder()
                let gitData = try decoder.decode(MyGitHub.self, from: data)
                
              //  print("gitData: \(gitData)")
                
                
                
                DispatchQueue.main.sync {
                    
                    
                    guard var gname1: Array<Double> = gitData.arrXAxis as? Array<Double> else { return }
                       // print(gname1 as Any)
                        // self.name.text = gname
                    
                    guard var gname2: Array<Double> = gitData.arrValue as? Array<Double>  else { return }
                      //  print(gname2 as Any)
                        // self.name.text = gname

                    guard let gname3: Array<String> = gitData.arrValueName as? Array<String>  else { return }
                    
                    if ((gname2[0] < 1) && (gname2[0] > -1)) { //Если меньше 1 показывать дробное число в шапке
                    self.title = gname3[0] + String(Float(gname2[0])) + gname3[1]
                    } else {
                    self.title = gname3[0] + String(Int(gname2[0])) + gname3[1]
                    }
                      //  print(gname3)
                        // self.name.text = gname
    
//                    if let gname4 = gitData.four {
//                         print(gname4)
//                        // self.name.text = gname
//                    }
                    

                    gname1 = gname1.reversed()
                    gname2 = gname2.reversed()
                    
                  //  print(gname1 as Any)
    
                    self.values3 = (0..<(gname1.count)).map { (i) -> ChartDataEntry in
                   // print("((gname2[i])*100).rounded()/100: \(((gname2[i])*100).rounded()/100)")
                        return ChartDataEntry(x: gname1[i], y: gname2[i])

                        
                    }
//                    print("values3_12345: \(String(describing: self.values3))")

                   // self.dataChartUpdate()
                   // let set3 = LineChartDataSet(values: self.values3, label: gname3[2])
                    let set3 = LineChartDataSet(entries: self.values3, label: gname3[2])
                    // print("values3_11111: \(String(describing: self.values3))")
                    // print("set3_11111: \(set3))")
                    self.setDataCount(10, range: 1, set1: set3)
                    
                }
                
                
                
            } catch let err {
                print("Err", err)
            }
            }.resume()

        

    }
    
    
    
    

       let timeFormatLandscape = "HH:mm dd MMM"
       let timeFormatPortrait = "dd MMM"
       let timeFormatPortraitMin = "HH:mm"
       var timeFormatToChart = ""
    

    @IBAction func indexChanged(_ sender: Any) {
        
        if UIDevice.current.orientation.isLandscape {
            //print("Landscape")
            timeFormatToChart = timeFormatLandscape
        } else {
            //print("Portrait")
            timeFormatToChart = timeFormatPortrait
        }
        
        
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
//            print("1")
            xAxisDotsCountToGet = 8
            timeFormat = timeFormatToChart
            if UIDevice.current.orientation.isPortrait {
              timeFormat = "HH:mm"
            }
        case 1:
//            print("2")
            xAxisDotsCountToGet = 100
            timeFormat = timeFormatToChart
        case 2:
//            print("3")
            xAxisDotsCountToGet = 1000
            timeFormat = timeFormatToChart
        case 3:
//            print("4")
            xAxisDotsCountToGet = 2000
            timeFormat = timeFormatToChart
        default:
            break
        }
        setupChartFromJSON()
        myDataChart()
    }
    
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            //print("Landscape")
            timeFormat = timeFormatLandscape
        } else {
            //print("Portrait")
            timeFormat = timeFormatPortrait
            if xAxisDotsCountToGet < 20 {
                timeFormat = "HH:mm"
            }
        }
        
        setupChartFromJSON()
        myDataChart()
        
    }
    

    
    
    
}
