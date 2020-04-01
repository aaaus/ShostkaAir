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
    
    
    @IBOutlet weak var userTelTextLbl: UILabel!
    @IBOutlet weak var userTelText: UITextField!
    @IBOutlet weak var userPswdField: UILabel!
    @IBOutlet weak var useGPSLbl: UILabel!
    @IBOutlet weak var useGPSbtn: UISwitch!
    @IBOutlet weak var saveBTN: UIButton!
    @IBOutlet var tapRecognizer: UITapGestureRecognizer!

    @IBOutlet weak var userAgreeTextBtn: UIButton!
    @IBOutlet weak var userLicenceText: UILabel!
    
    
    
    
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
        //   userPswdText.text = UserDefaults.standard.string(forKey: "userPswd") ?? ""
       useGPSbtn.isOn = UserDefaults.standard.bool(forKey: "useGPS")

   }
    
    func userRegisterGet () {
        print ("userRegisterGet")
        userLicenceText.isHidden = true
        userAgreeTextBtn.isHidden = true
        
        userTelText.isHidden = false
        userPswdField.isHidden = false
        useGPSbtn.isHidden = false
        userTelTextLbl.isHidden = false
        useGPSLbl.isHidden = false
        
        
        if (UserDefaults.standard.bool(forKey: "useGPS") != useGPSbtn.isOn) {
            UserDefaults.standard.set(true, forKey: "setNewGPSmode")
        }
        UserDefaults.standard.set(userTelText.text, forKey: "userTel")
        UserDefaults.standard.set(useGPSbtn.isOn, forKey: "useGPS")
        
        
        
        
    }
    
    @IBAction func useGPSaction(_ sender: Any) {
        view.endEditing(true)
    }
  /*
    @IBAction func cancelBTNaction(_ sender: Any) {
        view.endEditing(true)
        userTelText.text = UserDefaults.standard.string(forKey: "userTel") ?? ""
      //  userPswdText.text = UserDefaults.standard.string(forKey: "userPswd") ?? ""
        useGPSbtn.isOn = UserDefaults.standard.bool(forKey: "useGPS")
    }
 */
    @IBAction func saveBTNaction(_ sender: Any) {
        view.endEditing(true)
        let alert = UIAlertController(title: "Ви приймаєте Угоду користувача?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ні", style: .cancel, handler: nil))

        alert.addAction(UIAlertAction(title: "Так", style: .default, handler: { action in
            print ("OK")
            self.userRegisterGet ()
        }))

        self.present(alert, animated: true)
    }
    
    
    
    
    @IBAction func tapRecognizerAction(_ sender: Any) {
        view.endEditing(true)
        
    }
    
    
    
    @IBAction func userAgreeLicenceBtn(_ sender: Any) {
        openUrl(urlStr: "https://shostka.in")
    }
    
    
    
    func openUrl(urlStr:String!) {

        if let url = NSURL(string:urlStr) {
             UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }

    }
    
    
    
}

