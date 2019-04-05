//
//  InfoWebView.swift
//  CityMap
//
//  Created by aaaus on 3/30/19.
//  Copyright © 2019 it-shark. All rights reserved.
//

import UIKit
import WebKit

class InfoWebView: UIViewController {
    
    
    @IBOutlet weak var cityInfoButton: UIBarButtonItem!
    
    @IBOutlet weak var infoWebLink: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL (string: "https://shostka.in/shostka/info/99.html")
       // print("url: \(String(describing: url))")
        let requestObj = URLRequest(url: url!)
        infoWebLink.load(requestObj)
    
//        self.cityInfoButton.isEnabled = true

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func ShostkaCityWebViewAction(_ sender: UIBarButtonItem) {
        if(infoWebLink.canGoBack) {
//            self.cityInfoButton.isEnabled = true
            infoWebLink.goBack()
        } else {
//            self.cityInfoButton.isEnabled = false
          //  self.navigationController?.popViewController(animated:true)
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
