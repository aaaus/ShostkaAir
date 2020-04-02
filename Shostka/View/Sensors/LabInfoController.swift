//
//  LabInfoController.swift
//  CityMap
//
//  Created by aaaus on 3/30/19.
//  Copyright © 2019 it-shark. All rights reserved.
//

import UIKit
import WebKit

class LabInfoController: UIViewController {
    
    @IBOutlet weak var WebViewLabInfo: WKWebView!
    
    var id: Int! {
        didSet {
//            print(id as Any)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHtmlCode()
    }
    
    func loadHtmlCode() {
        
        let sensorID = String(id)
        //let url = URL (string: "https://shostka.in/shostka/info/\(sensorID).html")
        let url = URL (string: "https://api.shostka.in/app/info/\(sensorID).html")
        
        
//        print("url: \(String(describing: url))")
        let requestObj = URLRequest(url: url!)
        WebViewLabInfo.load(requestObj)
    }
    


}
