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
    var secondsCounter = 120
    
    
      
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
            
            let seconds = 1.0
            timer = Timer.scheduledTimer(withTimeInterval: seconds, repeats: true) { [weak self] timer in
                self?.timerHandler(timer)
            }
        }
        
        func stopTimer() {
            timer?.invalidate()
        }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     //   Privacy - Location When In Use Usage Description

     //   Визначення геопозіціі пристрою для особистого моніторингу
     //   Будь ласка, виберіть: "Дозволити за використання"  / "Разрешить при использовании”
   /*
        locationManager.delegate = self as? CLLocationManagerDelegate
        locationManager.requestWhenInUseAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.showsBackgroundLocationIndicator = false
        
        
        if (UserDefaults.standard.bool(forKey: "useGPS")) {
           locationManager.startUpdatingLocation()
           }
*/
 
        self.navigationItem.title = "Каталог підприємств"
        loadHtmlCode()
        
    //    getUserLocation()
        
    //    startTimer()
        
    }
    
    func loadHtmlCode() {
        //let url = URL (string: urlFromCityDiscription)
        let url = URL (string: "https://shostka.in")
        let requestObj = URLRequest(url: url!)
        newsWebView.load(requestObj)
    }
    
    
    func getUserLocation() {
        
        secondsCounter -= 1
        
        if ((UserDefaults.standard.bool(forKey: "setNewGPSmode")) || (secondsCounter<0)) {
            
            secondsCounter = 120
        
        if (UserDefaults.standard.bool(forKey: "setNewGPSmode")) {
            UserDefaults.standard.set(false, forKey: "setNewGPSmode")
            if (UserDefaults.standard.bool(forKey: "useGPS")) {
                locationManager.startUpdatingLocation()
            } else {
                locationManager.stopUpdatingLocation()
            }
            
        }
        
        if (UserDefaults.standard.bool(forKey: "useGPS")) {
        var userTel: String = UserDefaults.standard.string(forKey: "userTel") ?? "1"
        let userPswd: String = UserDefaults.standard.string(forKey: "userPswd") ?? "1"
        let userLocationLatitude = self.locationManager.location?.coordinate.latitude
        let userLocationLongitude = self.locationManager.location?.coordinate.longitude
            
            if (userTel == ""){
                userTel = "1"
            }
            
        print("You Location is: \(String(describing: userLocationLatitude)), \(String(describing: userLocationLongitude))")
   
          guard let gitUrl = URL(string: "http://api.shostka.in/cam/cam.php/?&getFromApp=google&xAxis=10&userTel=\(userTel)&userPswd=\(userPswd)&userLat=\(userLocationLatitude ?? 10)&userLong=\(userLocationLongitude ?? 10)") else { return }
          print ("gitUrl \(gitUrl)")
          URLSession.shared.dataTask(with: gitUrl) { (data, response
              , error) in
          guard data != nil else { return }

              }.resume()
        }
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
