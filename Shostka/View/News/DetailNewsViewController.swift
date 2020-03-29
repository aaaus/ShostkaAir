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
    

    @IBOutlet weak var newsWebView: WKWebView!

    
    //var city: City?
    var urlFromCityDiscription: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  guard let city = city else {
        // return
       //  }
      //  urlFromCityDiscription = city.description
        //self.navigationItem.title = city.name
        
        
        //self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
 
        self.navigationItem.title = "Ринок"
        loadHtmlCode()
    }
    
    func loadHtmlCode() {
        
        
        //let url = URL (string: urlFromCityDiscription)
        let url = URL (string: "https://shostka.in")
        let requestObj = URLRequest(url: url!)
        newsWebView.load(requestObj)
    }
    
    @IBAction func backUrlWebView(_ sender: UIBarButtonItem) {
        if(newsWebView.canGoBack) {
            newsWebView.goBack()
        } else {
            self.navigationController?.popViewController(animated:true)
        }
    }
    

}
