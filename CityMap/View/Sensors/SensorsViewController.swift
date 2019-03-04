import UIKit

private enum Segues: String {
    // Segue name that navigates to city detail page (has the same value as the segue in storyboard).
    case showCityDetail = "ShowCityDetail"
    // Segue name that navigates to the map page (has the same value as the segue in storyboard).
    case showMap = "ShowMap"
}

private enum Constants {
    // City cell reuse identifier (has the same value as city cell in storyboard) to use table view cell recycling mechanism.
    static let cityCellIdentifier = "CityCellIdentifier"
}

/**
 All cities controller to show all available cities as a collection.
 */
class SensorsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var city: City? {
        didSet {
          //  update()
        }
    }
    var sensorStationNumber: Int = 0
   // var laboratoryCount: Int = 0
    
    var sensorsArrayCountBeforeCurentSensors: Int = 0
    
    private let cityService = CityService.shared
    private var cities: [City] = [] {
        didSet {
            // Marshal cities to the main thread using GCD.
            DispatchQueue.main.async { [weak self] in
                // Update collection as data source has changed.
                self?.collectionView.reloadData()
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let city = city else {
            return
        }
        print("city.id: \(city.id)")
        sensorStationNumber = city.id
        setupData()
    }
    
    private func setupData() {
        activityIndicator.startAnimating()
        
        cityService.cities { [weak self] cities in
            self?.cities = cities
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else {
            return
        }
        
        switch segueIdentifier {
        case Segues.showCityDetail.rawValue:
            guard let cityCell = sender as? SensorsViewCell,
                let detailsController = segue.destination as? CityDetailViewController else {
                    return
            }
            
            detailsController.city = cityCell.city
            detailsController.sensorStationNumber = sensorStationNumber
        case Segues.showMap.rawValue:
            guard let mapController = segue.destination as? MapViewController else {
                return
            }
            
            mapController.cities = cities
        default:
            break
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var citiesCount = 0
        sensorsArrayCountBeforeCurentSensors = 0
        
        for city in cities {
            
            if (city.id >= (sensorStationNumber + 1) * 100) && (city.id < (sensorStationNumber + 2) * 100){  // Сколько датчиков у лаборатории
                citiesCount += 1
                print(city.id)
            }
            if city.id < (sensorStationNumber + 1) * 100{  // Сколько объектов в массиве до текущей лаборатории
                sensorsArrayCountBeforeCurentSensors += 1
            }
        }
        
        if cities.count == 0 {  // проверем если 0, бывает первый раз, возвращаем 0
            return 0
        }
        
        return citiesCount    // Нужное количество лабараторий
        
        
       // return cities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cityCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cityCellIdentifier, for: indexPath) as? SensorsViewCell else {
            return UICollectionViewCell()
        }
        
        let capitalToDisplay = cities[indexPath.row + sensorsArrayCountBeforeCurentSensors]
        cityCell.city = capitalToDisplay
        //print("indexPath.row \(indexPath.row)")
        return cityCell
    }
}

