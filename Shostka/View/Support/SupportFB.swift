//
//  SupportFB.swift
//  CityMap
//
//  Created by Aleksandr Andrusenko on 4/5/19.
//  Copyright © 2019 it-shark. All rights reserved.
//

import UIKit
import WebKit

class SupportFB: UIViewController {

    @IBOutlet weak var supportWebView: WKWebView!
    let url = URL (string: "https://shostka.in/shostka/info/info.html")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let requestObj = URLRequest(url: url!)
        supportWebView.load(requestObj)
    }
    
    
    @IBAction func homeSupprortAction(_ sender: UIBarButtonItem) {
        
        let requestObj = URLRequest(url: url!)
        supportWebView.load(requestObj)
        
//        if(supportWebView.canGoBack) {
//            supportWebView.goBack()
//        } else {
//
//        }
        
    }
    
    
    

//        if(infoWebLink.canGoBack) {
//            infoWebLink.goBack()
//        } else {
//            self.navigationController?.popViewController(animated:true)
//        }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
