//
//  LocalInfoController.swift
//  CityMap
//
//  Created by aaaus on 3/30/19.
//  Copyright © 2019 it-shark. All rights reserved.
//

import UIKit
import WebKit


class LocalInfoController: UIViewController {
    
    
    @IBOutlet weak var WebViewInfo: WKWebView!
    
    var city: City?
   // var id: Int = 0
    
    var id: Int! {
        didSet {
            //update()
            print(id as Any)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadHtmlCode()
    }
    
    func loadHtmlCode() {
        
        let sensorID = String(id)
        let url = URL (string: "https://shostka.in/shostka/info/\(sensorID).html")
        print("url: \(String(describing: url))")
        let requestObj = URLRequest(url: url!)
        WebViewInfo.load(requestObj)
    }
    

}
