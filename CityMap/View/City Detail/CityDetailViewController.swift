import UIKit
import Kingfisher
import Charts

private enum Constants {
    // Placeholder image for the cities that don't have photo (has the same name as appropriate image in assets folder).
     static let cityImagePlaceholder = "CityPlaceholder"
}

/**
 City detail controller to show information about specific city.
 */
final class CityDetailViewController: UIViewController {
    @IBOutlet private weak var cityImage: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var chartView: LineChartView!
    
   // var months: [String]!
    
    /**
     Get currently represented city or set the new city to update detail page information.
     If you set nil value, city information will be cleared from page.
     */
    var city: City?
    var sensorStationNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
          setupData()
        
        // Do any additional setup after loading the view.
   //     self.title = "Time Line Chart"
        
        //chartView.delegate = self
        
        self.title = city?.name
        
        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = true
        
        // x-axis limit line
        let llXAxis = ChartLimitLine(limit: 10, label: "Index 10")
        llXAxis.lineWidth = 4
        llXAxis.lineDashLengths = [10, 10, 0]
        llXAxis.labelPosition = .rightBottom
        llXAxis.valueFont = .systemFont(ofSize: 10)
        
        chartView.xAxis.gridLineDashLengths = [10, 10]
        chartView.xAxis.gridLineDashPhase = 0
        
        let ll1 = ChartLimitLine(limit: 150, label: "Верхня межа")
        ll1.lineWidth = 4
        ll1.lineDashLengths = [5, 5]
        ll1.labelPosition = .rightTop
        ll1.valueFont = .systemFont(ofSize: 10)
        
      /*  let ll2 = ChartLimitLine(limit: -30, label: "Нижня межа")
        ll2.lineWidth = 4
        ll2.lineDashLengths = [5,5]
        ll2.labelPosition = .rightBottom
        ll2.valueFont = .systemFont(ofSize: 10)
        ll2.lineColor = ChartColorTemplates.colorFromString("#0000ff") */
        
        let leftAxis = chartView.leftAxis
        leftAxis.removeAllLimitLines()
        leftAxis.addLimitLine(ll1)
      //  leftAxis.addLimitLine(ll2)
        leftAxis.axisMaximum = 200
        leftAxis.axisMinimum = -50
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
        self.setDataCount(5, range: 5)
    }
    
    
    
    
  private func setupData() {
     guard let city = city else {
     return
     }
     title = city.name
     descriptionLabel.text = city.description
    
     // Set image using url to the image view using kingfisher extension.
     //cityImage.kf.setImage(with: city.imageUrl, placeholder: UIImage(named: Constants.cityImagePlaceholder))
     }
    
    
    
    func setDataCount(_ count: Int, range: UInt32) {
       /* let values = (0..<count).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(range) + 3)
            return ChartDataEntry(x: Double(i), y: val, icon: #imageLiteral(resourceName: "icon"))
        }*/
        
        let now = Date().timeIntervalSince1970
        let hourSeconds: TimeInterval = 3600
        
        let from = now - (Double(count) / 2) * hourSeconds
        let to = now + (Double(count) / 2) * hourSeconds
        
        let values = stride(from: from, to: to, by: hourSeconds).map { (x) -> ChartDataEntry in
            let y = arc4random_uniform(range) + 50
            print("ChartDataEntry(x: x, y: Double(y)): \(ChartDataEntry(x: x, y: Double(y)))")
           // print("value: \(values)")
             return ChartDataEntry(x: x, y: Double(y))
        }
        
        
       // let set1 = LineChartDataSet(values: values, label: "Графік 1")
        let set1 = LineChartDataSet(values: values, label: "Графік 1")
        print("set: \(set1)")
        
       // let set2 = LineChartDataSet(values: values, label: "Графік 2")
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
       // let
        let chartTest = ChartDataEntry(x: 1551797984, y: 55)
        data.addEntry(chartTest, dataSetIndex: 5)
        print("data: \(data)")
        chartView.data = data
    }
}
