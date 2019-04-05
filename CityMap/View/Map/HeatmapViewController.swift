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
    
    
    private enum CodingKeys: String, CodingKey {
        case arrXAxis2
        case arrValue2
        case arrValueName2
        case four2
    }
}

class HeatmapViewController: UIViewController, GMSMapViewDelegate {
    
    @IBOutlet weak var topMenuMap: UISegmentedControl!
    
    
    private var mapView: GMSMapView!
    private var heatmapLayer: GMUHeatmapTileLayer!
    private var button: UIButton!
    
    private var gradientColors = [UIColor.green, UIColor.red]
    private var gradientStartPoints = [0.2, 1.0] as [NSNumber]

    
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: 51.868849, longitude: 33.473487, zoom: 14)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.settings.compassButton = true
       // mapView.settings.myLocationButton = true
        //mapView.accessibilityElementsHidden = false
        //mapView.isMyLocationEnabled = true
        mapView.setMinZoom(13, maxZoom: 14)
        mapView.delegate = self
        self.view = mapView
       // makeButton()
        let position = CLLocationCoordinate2D(latitude: 51.872229, longitude: 33.466743)
        let london = GMSMarker(position: position)
        london.title = "Шостка.AIR №1"
        london.snippet = "вул. Щедріна, 1"
        //london.tracksInfoWindowChanges = true
        //london.tracksViewChanges = true
        
        london.map = mapView
    }
    
    override func viewDidLoad() {
        topMenuMap.selectedSegmentIndex = 1
        
        myDataChart()
   
        // Set heatmap options.
        heatmapLayer = GMUHeatmapTileLayer()
        heatmapLayer.radius = 120
        heatmapLayer.opacity = 0.7
        heatmapLayer.gradient = GMUGradient(colors: gradientColors,
                                            startPoints: gradientStartPoints,
                                            colorMapSize: 256)

        myDataChart()
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
        var list = [GMUWeightedLatLng]()
        guard let gitUrl = URL(string: "http://sun.shostka.in/gps.php/?&getFromApp=google&xAxis=10") else { return }
        
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
                    
                    
                    _ = (0..<(gname1.count)).map { (i) -> Double in
                      //  let lat = item["lat"]
                      //  let lng = item["lng"]
                        let coords = GMUWeightedLatLng(coordinate: CLLocationCoordinate2DMake(gname1[i] , gname2[i] ), intensity: 1.0)
                        list.append(coords)
                       // print(gname1[i])
                        return 5
                            }
            
                    self.heatmapLayer.weightedData = list
                    print("addHeatmap")
                    // Set the heatmap to the mapview.
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
            print("11")
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
