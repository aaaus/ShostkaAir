//
//  HeatmapViewController.swift
//  CityMap
//
//  Created by Aleksandr Andrusenko on 20.03.2019.
//  Copyright © 2019 it-shark. All rights reserved.
//

import Foundation
import GoogleMaps
import UIKit

struct HeatMapPositions: Codable {
    
    let arrXAxis2: [Double?]
    let arrValue2: [Double?]
    let arrValueName2: [String?]
    let four2: Int?
    let markerString1: [String?]
    let markerString2: [String?]
    let markerDouble1: [Double?]
    let markerDouble2: [Double?]
    
    
    private enum CodingKeys: String, CodingKey {
        case arrXAxis2
        case arrValue2
        case arrValueName2
        case four2
        case markerString1
        case markerString2
        case markerDouble1
        case markerDouble2
    }
}

class HeatmapViewController: UIViewController, GMSMapViewDelegate {
    
    @IBOutlet weak var topMenuMap: UISegmentedControl!
    
    var startStatus: Bool = true
    private var mapView: GMSMapView!
    private var heatmapLayer: GMUHeatmapTileLayer!
    private var button: UIButton!
    
    private var gradientColors = [UIColor.green, UIColor.red]
    private var gradientStartPoints = [0.8, 1.0] as [NSNumber]
    
    private let locationManager = CLLocationManager()

    
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: 51.868849, longitude: 33.473487, zoom: 14)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
      //  locationManager.startUpdatingLocation()
                  
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        mapView.accessibilityElementsHidden = false
        mapView.isMyLocationEnabled = true
        mapView.setMinZoom(10, maxZoom: 18)
        mapView.delegate = self
        self.view = mapView
        //makeButton()
        
    }
    
    
    /// Timer Area
    override func viewWillAppear(_ animated: Bool) {
        startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stopTimer()
    }
    
    
    weak var timer: Timer?
    
    deinit {
        timer?.invalidate()
    }
    
    func timerHandler(_ timer: Timer) {
        if (Network.reachability.isReachable){
//            heatmapLayer.map = nil
         //locationManager.startUpdatingLocation()
         myDataChart()
        }else{
            print("No server connection!")
        }
    }
    
    func startTimer() {
        timer?.invalidate()   // stops previous timer, if any
        
        let seconds = 120.0
        timer = Timer.scheduledTimer(withTimeInterval: seconds, repeats: true) { [weak self] timer in
            self?.timerHandler(timer)
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        topMenuMap.selectedSegmentIndex = 1
        
//        myDataChart()
   
        // Set heatmap options.
        heatmapLayer = GMUHeatmapTileLayer()
        heatmapLayer.radius = 120
        heatmapLayer.opacity = 0.7
        heatmapLayer.gradient = GMUGradient(colors: gradientColors,
                                            startPoints: gradientStartPoints,
                                            colorMapSize: 256)

        myDataChart()
        
       // locationManager.delegate = self as? CLLocationManagerDelegate
       // locationManager.requestWhenInUseAuthorization()
        
       // locationManager.allowsBackgroundLocationUpdates = true
       // locationManager.pausesLocationUpdatesAutomatically = false
       // locationManager.showsBackgroundLocationIndicator = false
        
        startTimer()
    }
   
    @objc func removeHeatmap() {
        heatmapLayer.map = nil
        heatmapLayer = nil
        // Disable the button to prevent subsequent calls, since heatmapLayer is now nil.
        button.isEnabled = false
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
    }
    
    
    
    
    func myDataChart() {
       // mapView.clear()
        // print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
        let userTel: String = UserDefaults.standard.string(forKey: "userTel") ?? ""
        let userPswd: String = UserDefaults.standard.string(forKey: "userPswd") ?? ""
        
    //     let userTel: String = "0671234567"
    //     let userPswd: String = "2222"
        
         let userLocationLatitude = self.locationManager.location?.coordinate.latitude
         let userLocationLongitude = self.locationManager.location?.coordinate.longitude
         print("You Location is: \(String(describing: userLocationLatitude)), \(String(describing: userLocationLongitude))")
         //locationManager.stopUpdatingLocation()
        
        var list = [GMUWeightedLatLng]()
        guard let gitUrl = URL(string: "http://api.shostka.in/cam/cam.php/?&getFromApp=google&xAxis=10&userTel=\(userTel)&userPswd=\(userPswd)&userLat=\(userLocationLatitude ?? 10)&userLong=\(userLocationLongitude ?? 10)") else { return }
        
        URLSession.shared.dataTask(with: gitUrl) { (data, response
            , error) in
            
            guard let data = data else { return }
            do {
                
                let decoder = JSONDecoder()
                let gitData = try decoder.decode(HeatMapPositions.self, from: data)
                
                //print("gitData: \(gitData)")
                
               
                DispatchQueue.main.sync {
                    
                    guard var gname1: Array<Double> = gitData.arrXAxis2 as? Array<Double> else { return }
                    guard var gname2: Array<Double> = gitData.arrValue2 as? Array<Double>  else { return }
                    guard var mString1: Array<String> = gitData.markerString1 as? Array<String>  else { return }
                    guard var mString2: Array<String> = gitData.markerString2 as? Array<String>  else { return }
                    guard var mDouble1: Array<Double> = gitData.markerDouble1 as? Array<Double>  else { return }
                    guard var mDouble2: Array<Double> = gitData.markerDouble2 as? Array<Double>  else { return }
                    
                    //   print(mString1, mString2, mDouble1, mDouble2)
                    _ = (0..<(gname1.count)).map { (i) -> Double in
                      //  let lat = item["lat"]
                      //  let lng = item["lng"]
                        let coords = GMUWeightedLatLng(coordinate: CLLocationCoordinate2DMake(gname1[i] , gname2[i] ), intensity: 1.0)
                        list.append(coords)
                       // print(gname1[i])
                        return 5
                            }
                    
                    if self.startStatus {
                        self.startStatus = false
                    _ = (0..<(mDouble1.count)).map { (i) -> Double in
                        let position = CLLocationCoordinate2D(latitude: mDouble1[i], longitude: mDouble2[i])
                        let shostka = GMSMarker(position: position)
                        shostka.title = mString1[i]
                        shostka.snippet = mString2[i]
                        shostka.map = self.mapView
                        return 10
                    }
                    }
            

                    self.heatmapLayer.map = nil
                    self.heatmapLayer.weightedData = list
                    self.heatmapLayer.map = self.mapView
                    

                }
  
            } catch let err {
                print("Err", err)
            }
            }.resume()
        
    }
    
    @IBAction func topMuneMapSegmentControl(_ sender: UISegmentedControl) {
        
        switch topMenuMap.selectedSegmentIndex
        {
        case 0:
//            print("11")
           // topMenuMap.selectedSegmentIndex = 0
//            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        case 1:
            print("22")
        default:
            break
        }
        
        
    }
    
   
}
