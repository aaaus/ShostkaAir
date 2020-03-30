//
//  userSettings.swift
//  Shostka
//
//  Created by Aleksandr Andrusenko on 30.03.2020.
//  Copyright © 2020 Aleksandr Andrusenko. All rights reserved.
//

import Foundation
import UIKit

/**
 All cities controller to show all available cities as a collection.
 */
class UserSettings: UIViewController {
    
    
    @IBOutlet weak var userTelText: UITextField!
    @IBOutlet weak var userPswdText: UITextField!
    @IBOutlet weak var useGPSbtn: UISwitch!
    @IBOutlet weak var cancelBTN: UIButton!
    @IBOutlet weak var saveBTN: UIButton!
    
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
        
   // UserDefaults.standard.set("0675555555", forKey: "userTel")
   // UserDefaults.standard.set("3333", forKey: "userPswd")
   // UserDefaults.standard.set(true, forKey: "useGPS")
         
    let userTel: String = UserDefaults.standard.string(forKey: "userTel") ?? ""
    let userPswd: String = UserDefaults.standard.string(forKey: "userPswd") ?? ""
    let statusGPS = UserDefaults.standard.bool(forKey: "useGPS")
    print("userTel \(userTel), userPswd \(userPswd), \(statusGPS)")
        
       userTelText.text = UserDefaults.standard.string(forKey: "userTel") ?? ""
       userPswdText.text = UserDefaults.standard.string(forKey: "userPswd") ?? ""
       useGPSbtn.isOn = UserDefaults.standard.bool(forKey: "useGPS")
        
        
        

   }
    
    
    @IBAction func useGPSaction(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func cancelBTNaction(_ sender: Any) {
        view.endEditing(true)
        userTelText.text = UserDefaults.standard.string(forKey: "userTel") ?? ""
        userPswdText.text = UserDefaults.standard.string(forKey: "userPswd") ?? ""
        useGPSbtn.isOn = UserDefaults.standard.bool(forKey: "useGPS")
    }
    
    @IBAction func saveBTNaction(_ sender: Any) {
        view.endEditing(true)
        
        if (UserDefaults.standard.bool(forKey: "useGPS") != useGPSbtn.isOn) {
            UserDefaults.standard.set(true, forKey: "setNewGPSmode")
        }
        
        UserDefaults.standard.set(userTelText.text, forKey: "userTel")
        UserDefaults.standard.set(userPswdText.text, forKey: "userPswd")
        UserDefaults.standard.set(useGPSbtn.isOn, forKey: "useGPS")
    }
    
    
    
}

