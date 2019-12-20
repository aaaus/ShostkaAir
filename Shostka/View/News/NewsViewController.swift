import UIKit

private enum Segues: String {
    // Segue name that navigates to city detail page (has the same value as the segue in storyboard).
    case showNews = "showNews"
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
class NewsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var collectionView: UICollectionView!

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
    
    var city: City?
    var sensorStationNumber: Int = 0
    // var laboratoryCount: Int = 0
    
    var sensorsArrayCountBeforeCurentSensors: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        case Segues.showNews.rawValue:
            guard let cityCell = sender as? NewsViewCell,
                let detailsController = segue.destination as? DetailNewsViewController else {
                    return
            }
            
            
          //  detailsController.city = cityCell.city

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
            
            if (city.id >= 10000 && city.id < 10100){  // Сколько плиток сайтов
                citiesCount += 1
//                print(city.id)
            }
            if city.id < 10000 {  // Сколько объектов в массиве до сайтов
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
        guard let cityCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cityCellIdentifier, for: indexPath) as? NewsViewCell else {
            return UICollectionViewCell()
        }
        
        let capitalToDisplay = cities[indexPath.row + sensorsArrayCountBeforeCurentSensors]
        cityCell.city = capitalToDisplay
//        print("cityCell\(cityCell)")
        return cityCell
    }
}

