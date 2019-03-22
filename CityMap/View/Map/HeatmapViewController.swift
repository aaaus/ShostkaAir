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

class HeatmapViewController: UIViewController, GMSMapViewDelegate {
    private var mapView: GMSMapView!
    private var heatmapLayer: GMUHeatmapTileLayer!
    private var button: UIButton!
    
    private var gradientColors = [UIColor.green, UIColor.red]
    private var gradientStartPoints = [0.2, 1.0] as [NSNumber]
    
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: 51.868849, longitude: 33.473487, zoom: 14)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        //mapView.accessibilityElementsHidden = false
        //mapView.isMyLocationEnabled = true
        mapView.setMinZoom(13, maxZoom: 14)
        mapView.delegate = self
        self.view = mapView
       // makeButton()
        
        let position = CLLocationCoordinate2D(latitude: 51.869846, longitude: 33.461001)
        let london = GMSMarker(position: position)
        london.title = "Лаборатория 1"
        london.snippet = "Измерение базовых параметров"
        //london.tracksInfoWindowChanges = true
        //london.tracksViewChanges = true
        
        london.map = mapView
    }
    
    override func viewDidLoad() {
        // Set heatmap options.
        heatmapLayer = GMUHeatmapTileLayer()
        heatmapLayer.radius = 120
        heatmapLayer.opacity = 0.7
        heatmapLayer.gradient = GMUGradient(colors: gradientColors,
                                            startPoints: gradientStartPoints,
                                            colorMapSize: 256)
        addHeatmap()
        print("addHeatmap")
        
        // Set the heatmap to the mapview.
        heatmapLayer.map = mapView
    }
    
    // Parse JSON data and add it to the heatmap layer.
    func addHeatmap()  {
        var list = [GMUWeightedLatLng]()
        do {
            // Get the data: latitude/longitude positions of police stations.
            if let path = Bundle.main.url(forResource: "stations", withExtension: "json") {
                let data = try Data(contentsOf: path)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [[String: Any]] {
                    for item in object {
                        let lat = item["lat"]
                        let lng = item["lng"]
                        let coords = GMUWeightedLatLng(coordinate: CLLocationCoordinate2DMake(lat as! CLLocationDegrees, lng as! CLLocationDegrees), intensity: 1.0)
                        list.append(coords)
                    }
                } else {
                    print("Could not read the JSON.")
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        // Add the latlngs to the heatmap layer.
        heatmapLayer.weightedData = list
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
    
    // Add a button to the view.
   /* func makeButton() {
        // A button to test removing the heatmap.
        button = UIButton(frame: CGRect(x: 5, y: 150, width: 200, height: 35))
        button.backgroundColor = .blue
        button.alpha = 0.5
        button.setTitle("Очистити карту", for: .normal)
        button.addTarget(self, action: #selector(removeHeatmap), for: .touchUpInside)
        self.mapView.addSubview(button)
 
    }*/
}
