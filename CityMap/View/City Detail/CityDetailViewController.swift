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
    
    @IBOutlet weak var barChartView: BarChartView!
    
    var months: [String]!
    
    /**
     Get currently represented city or set the new city to update detail page information.
     If you set nil value, city information will be cleared from page.
     */
    var city: City?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
          setupData()
        
        // barChartView.noDataTextDescription = "Just because" type BarChartView doest have noDataTextDescription
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [50.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        //setChart(months, values: unitsSold) missing argument label dataPoints: in call
        setChart(dataPoints: months, values: unitsSold)
    }
    
      private func setupData() {
     guard let city = city else {
     return
     }
     
     title = city.name
     descriptionLabel.text = city.description
     
     // Set image using url to the image view using kingfisher extension.
     cityImage.kf.setImage(with: city.imageUrl, placeholder: UIImage(named: Constants.cityImagePlaceholder))
     }
    
    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.noDataText = "You need to provide data for the chart."
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            // let dataEntry = BarChartDataEntry(value: values[i], xIndex: i) // argument labeld dont match
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
        
        // let chartData = BarChartData(xVals: months, dataSet: chartDataSet) cannot invoke initializer BarCharData with arg list of (xVals: [String]!, dataSet: BarCharDataSet
        let chartData    = BarChartData(dataSets: [chartDataSet])
        
        barChartView.data = chartData
        //barChartView.xAxis.ent
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        barChartView.xAxis.labelCount = months.count
        barChartView.xAxis.labelPosition = .bottom
        
    }
}
