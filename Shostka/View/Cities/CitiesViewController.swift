import UIKit

//var testtt: Int = 0

private enum Segues: String {
    // Segue name that navigates to city detail page (has the same value as the segue in storyboard).
    case ShowParameters = "ShowParameters"
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
class CitiesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var topMenu: UISegmentedControl!
    

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
    var laboratoryCount: Int = 0
    

    
    
    /// Timer Area
    override func viewWillAppear(_ animated: Bool) {
        updateUserInterface()
//        print("Load")
        startTimer()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        updateUserInterface()
//        print("UnLoad")
        stopTimer()
        
    }
    
    
    weak var timer: Timer?
    
    deinit {
        timer?.invalidate()
    }
    
    func timerHandler(_ timer: Timer) {
//        let hola = "CitiesViewController"
//        print(">>>> \(hola)")
        if (Network.reachability.isReachable){
        setupData()
        self.collectionView.reloadData()
        }else{
            print("No server connection!")
            updateUserInterface()
        }
        
        
        // SensorsViewCell
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
        
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(statusManager),
                         name: .flagsChanged,
                         object: nil)
        updateUserInterface()
 
        
     //  setupData()
    }
    
    
    func updateUserInterface() {
        
       /* switch Network.reachability.status {
        case .unreachable:
            view.backgroundColor = .red
        case .wwan:
            view.backgroundColor = .yellow
        case .wifi:
            view.backgroundColor = .green
        }*/
//        print("Reachability Summary")
//        print("Status:", Network.reachability.status)
//        print("HostName:", Network.reachability.hostname ?? "nil")
//        print("Reachable:", Network.reachability.isReachable)
//        print("Wifi:", Network.reachability.isReachableViaWiFi)
        
        if (!Network.reachability.isReachable){
            // create the alert
            let alert = UIAlertController(title: "Помилка підключення!", message: "Не можу підключиться до сервера.", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }else{
            setupData()
        }
    }
    
    
    @objc func statusManager(_ notification: Notification) {
        updateUserInterface()
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
        case Segues.ShowParameters.rawValue:
            guard let cityCell = sender as? CityViewCell,
                let detailsController = segue.destination as? SensorsViewController else {
                return
            }

            //detailsController.city = cityCell.city
           // print("cityCell.city: \(cityCell.city)")
            detailsController.city = cityCell.city
          //  detailsController.laboratoryCount = laboratoryCount
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
       // let testSString: String = String(describing: cities.description)
        var citiesCount = 0
        
        for city in cities {
            if city.id < 100{
            citiesCount += 1
//            print(city.id)
            }
        laboratoryCount = citiesCount
        }
        
        
        if cities.count == 0 {  // проверем если 0, бывает первый раз, возвращаем 0
            return 0
        }
        
        return citiesCount    // Нужное количество лабараторий
       //return cities.count
       // _ = cities.count
       // return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cityCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cityCellIdentifier, for: indexPath) as? CityViewCell else {
            return UICollectionViewCell()
        }

        
        let capitalToDisplay = cities[indexPath.row]
        cityCell.city = capitalToDisplay
        //print("capitalToDisplay: \(capitalToDisplay)")
        
        return cityCell
    }
    
    @IBAction func topMenuSegmentControl(_ sender: UISegmentedControl) {
        
        switch topMenu.selectedSegmentIndex
        {
        case 0:
            print("1")
        case 1:
            print("2")
            performSegue(withIdentifier: "heatMap", sender: nil)
            topMenu.selectedSegmentIndex = 0
        default:
            break
        }   
    }
    
    
}

