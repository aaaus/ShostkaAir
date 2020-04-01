//
//  cityNews.swift
//  CityMap
//
//  Created by Aleksandr Andrusenko on 01.03.2019.
//  Copyright © 2019 it-shark. All rights reserved.
//

import UIKit
import WebKit
//import WordPress

class DetailNewsViewController: UIViewController {
    
    private let locationManager = CLLocationManager()

    @IBOutlet weak var newsWebView: WKWebView!

    
    //var city: City?
    var urlFromCityDiscription: String = ""
    var flagFirstStartForSartGPS = true
    
    
      
        /// Timer Area
        override func viewWillAppear(_ animated: Bool) {
           // startTimer()
        }
        
        override func viewWillDisappear(_ animated: Bool) {
           // stopTimer()
        }
        
        
        weak var timer: Timer?
        
        deinit {
            timer?.invalidate()
        }
        
        func timerHandler(_ timer: Timer) {
            if (Network.reachability.isReachable){
             getUserLocation()
            }else{
                print("No server connection!")
            }
        }
        
        func startTimer() {
            timer?.invalidate()   // stops previous timer, if any
            
            let seconds = 10.0
            timer = Timer.scheduledTimer(withTimeInterval: seconds, repeats: true) { [weak self] timer in
                self?.timerHandler(timer)
            }
        }
        
        func stopTimer() {
            timer?.invalidate()
        }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (UserDefaults.standard.bool(forKey: "useGPS")) {
           locationManager.startUpdatingLocation()
           }
        
        locationManager.delegate = self as? CLLocationManagerDelegate
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.showsBackgroundLocationIndicator = false
        
        
        
        
        //  guard let city = city else {
        // return
       //  }
      //  urlFromCityDiscription = city.description
        //self.navigationItem.title = city.name
        
        
        //self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
 
        self.navigationItem.title = "Інтернет Ринок"
        loadHtmlCode()
        
        getUserLocation()
        
        startTimer()
        
    }
    
    func loadHtmlCode() {
        //let url = URL (string: urlFromCityDiscription)
        let url = URL (string: "https://shostka.in")
        let requestObj = URLRequest(url: url!)
        newsWebView.load(requestObj)
    }
    
    
    func getUserLocation() {
        
        if (UserDefaults.standard.bool(forKey: "setNewGPSmode")) {
            UserDefaults.standard.set(false, forKey: "setNewGPSmode")
            if (UserDefaults.standard.bool(forKey: "useGPS")) {
                locationManager.startUpdatingLocation()
            } else {
                locationManager.stopUpdatingLocation()
            }
            
        }
        
        if (UserDefaults.standard.bool(forKey: "useGPS")) {
        let userTel: String = UserDefaults.standard.string(forKey: "userTel") ?? ""
        let userPswd: String = UserDefaults.standard.string(forKey: "userPswd") ?? ""
        let userLocationLatitude = self.locationManager.location?.coordinate.latitude
        let userLocationLongitude = self.locationManager.location?.coordinate.longitude
        print("You Location is: \(String(describing: userLocationLatitude)), \(String(describing: userLocationLongitude))")
   
          guard let gitUrl = URL(string: "http://sun.shostka.in/gps.php/?&getFromApp=google&xAxis=10&userTel=\(userTel)&userPswd=\(userPswd)&userLat=\(userLocationLatitude ?? 10)&userLong=\(userLocationLongitude ?? 10)") else { return }
          
          URLSession.shared.dataTask(with: gitUrl) { (data, response
              , error) in
          guard data != nil else { return }

              }.resume()
        }
          
      }
    
    
    
    
    @IBAction func backUrlWebView(_ sender: UIBarButtonItem) {
        if(newsWebView.canGoBack) {
            newsWebView.goBack()
        } else {
            self.navigationController?.popViewController(animated:true)
        }
    }
    

}
