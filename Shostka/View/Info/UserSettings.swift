//
//  userSettings.swift
//  Shostka
//
//  Created by Aleksandr Andrusenko on 30.03.2020.
//  Copyright © 2020 Aleksandr Andrusenko. All rights reserved.
//

import Foundation
import UIKit

struct UserSettingsGet: Codable {
    var arrUserResp: [String?]
  //  var points: Int
  //  var description: String?
}

/**
 All cities controller to show all available cities as a collection.
 */
class UserSettings: UIViewController {
    
    
    @IBOutlet weak var userTelTextLbl: UILabel!
    @IBOutlet weak var userTelText: UITextField!
    @IBOutlet weak var userPswdLbl: UILabel!
    @IBOutlet weak var userPswdField: UILabel!
    @IBOutlet weak var useGPSLbl: UILabel!
    @IBOutlet weak var useGPSbtn: UISwitch!
    @IBOutlet weak var saveBTN: UIButton!
    @IBOutlet var tapRecognizer: UITapGestureRecognizer!
    @IBOutlet weak var topBarTextColor: UILabel!
    
    @IBOutlet weak var userAgreeTextBtn: UIButton!
    @IBOutlet weak var userLicenceText: UILabel!
    
    
    
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
        
   // UserDefaults.standard.set("0675555555", forKey: "userTel")
   // UserDefaults.standard.set("3333", forKey: "userPswd")
   // UserDefaults.standard.set(true, forKey: "useGPS")
         

        
       userTelText.text = UserDefaults.standard.string(forKey: "userTel") ?? ""
       userPswdField.text = UserDefaults.standard.string(forKey: "userPswd") ?? ""
       useGPSbtn.isOn = UserDefaults.standard.bool(forKey: "useGPS")
        
        if ((Int(UserDefaults.standard.string(forKey: "userPswd") ?? "") ?? 0) > 5) {
            userLicenceText.isHidden = true
            userAgreeTextBtn.isHidden = true
            
            userPswdLbl.isHidden = false
            userPswdField.isHidden = false
            userTelText.isHidden = false
            userTelTextLbl.isHidden = false
            useGPSbtn.isHidden = false
            useGPSLbl.isHidden = false
            
            if (Network.reachability.isReachable){
                topBarTextColor.text = "Сервіс підключений"
                topBarTextColor.backgroundColor = .green
            }else{
                //print("No server connection!")
                topBarTextColor.text = "Відсутнє підключення!"
                topBarTextColor.backgroundColor = .red
            }
            
            
            saveBTN.setTitle("Зберегти", for: .normal)
        }

   }
    
    func userRegisterGet () {
        print ("userRegisterGet")
        
        userLicenceText.isHidden = true
        userAgreeTextBtn.isHidden = true
        
        userPswdLbl.isHidden = false
        userPswdField.isHidden = false
        userTelText.isHidden = false
        userTelTextLbl.isHidden = false
        useGPSbtn.isHidden = false
        useGPSLbl.isHidden = false
        
        
        if ((Int(UserDefaults.standard.string(forKey: "userPswd") ?? "") ?? 0) < 5) {
            topBarTextColor.text = "Зачекайте...."
            UserDefaults.standard.set(true, forKey: "useGPS")
            UserDefaults.standard.set(true, forKey: "userInstruction_1")
            useGPSbtn.isOn = true
            UserDefaults.standard.set(true, forKey: "setNewGPSmode")
        }
        
 //       var userTel: String = UserDefaults.standard.string(forKey: "userTel") ?? "1"
 //       var userPswd: String = UserDefaults.standard.string(forKey: "userPswd") ?? "1"
 //       var statusGPS = UserDefaults.standard.bool(forKey: "useGPS")
        if (UserDefaults.standard.bool(forKey: "useGPS") != useGPSbtn.isOn) {
            UserDefaults.standard.set(true, forKey: "setNewGPSmode")
        }
        
        
        var userTel: String = userTelText.text ?? "1"
        var userPswd: String = UserDefaults.standard.string(forKey: "userPswd") ?? "1"
        let useGPS = useGPSbtn.isOn
        
        UserDefaults.standard.set(userTel, forKey: "userTel")
        UserDefaults.standard.set(useGPS, forKey: "useGPS")
        
          

        //  UserDefaults.standard.set(userTelText.text, forKey: "userTel")
        //  UserDefaults.standard.set(useGPSbtn.isOn, forKey: "useGPS")
          
        //  userTelText.text = UserDefaults.standard.string(forKey: "userTel") ?? ""
        //  userPswdField.text = UserDefaults.standard.string(forKey: "userPswd") ?? ""
        //  useGPSbtn.isOn = UserDefaults.standard.bool(forKey: "useGPS")
        
        if (userTel == ""){
            userTel = "1"
        }
        if (userPswd == ""){
            userPswd = "1"
        }
        
    //    userTelText.text = UserDefaults.standard.string(forKey: "userTel") ?? ""
    //    userPswdField.text = UserDefaults.standard.string(forKey: "userPswd") ?? ""
     //   useGPSbtn.isOn = UserDefaults.standard.bool(forKey: "useGPS")
        
        
        
  /*      if (userPswd < 5) {
            userTel = 1
            userPswd = 1
            statusGPS = 1
        }
   */
        guard let gitUrl = URL(string:
           "http://sun.shostka.in/gps.php/?&userreg=userreg&userPswd=\(userPswd)&userTel=\(userTel)&gpsStatus=\(useGPS)"
            ) else { return }
        print ("gitUrl \(gitUrl)")
        
        URLSession.shared.dataTask(with: gitUrl) { (data, response
            , error) in
        guard let data = data else { return }
                      do {                       
                          let decoder = JSONDecoder()
                          let gitData = try decoder.decode(UserSettingsGet.self, from: data)
                          //print("gitData: \(gitData)")
                          DispatchQueue.main.sync {
                              
                            guard let arrUserResp: Array<String> = gitData.arrUserResp as? Array<String> else { return }
                              _ = (0..<(arrUserResp.count)).map { (i) -> String in
                                //  let lat = item["lat"]
                                //  let lng = item["lng"]
                               
                                UserDefaults.standard.set(arrUserResp[0], forKey: "userPswd")
                                UserDefaults.standard.set(arrUserResp[1], forKey: "userStatus")
                                print("arrUserResp[i] \(arrUserResp[i]), \(i)")
                                  return "5"
                                      }
                          }
                        
         
                      } catch let err {
                          print("Err", err)
                      }
            //self.saveBTN.sendActions(for: .touchUpInside)
            
            }.resume()
        
        let seconds = 5.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.userPswdField.text = UserDefaults.standard.string(forKey: "userPswd") ?? ""
            self.useGPSbtn.isOn = UserDefaults.standard.bool(forKey: "useGPS")
            self.saveBTN.setTitle("Зберегти", for: .normal)
            if (Network.reachability.isReachable){
                self.topBarTextColor.text = "Сервіс підключений"
                self.topBarTextColor.backgroundColor = .green
            }else{
                print("No server connection!")
                self.topBarTextColor.text = "Відсутнє підключення!"
                self.topBarTextColor.backgroundColor = .red
            }
        }
        
                
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
        
        var msgSettingSave = "Налаштування збережені"
        
        if (Network.reachability.isReachable){
            topBarTextColor.text = "Сервіс підключений"
            topBarTextColor.backgroundColor = .green
            msgSettingSave = "Налаштування збережені"
        }else{
            print("No server connection!")
            topBarTextColor.text = "Відсутнє підключення!"
            topBarTextColor.backgroundColor = .red
            msgSettingSave = "Відсутнє підключення!"
        }
        
        
        if ((Int(UserDefaults.standard.string(forKey: "userPswd") ?? "") ?? 0) > 5) {
            let alert = UIAlertController(title: msgSettingSave, message: nil, preferredStyle: .alert)
            //alert.addAction(UIAlertAction(title: "Ні", style: .cancel, handler: nil))

            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                print ("OK")
                self.userRegisterGet ()
            }))
            self.present(alert, animated: true)
            
            
        } else {
            let alert = UIAlertController(title: "Ви приймаєте Угоду користувача?", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ні", style: .cancel, handler: nil))

            alert.addAction(UIAlertAction(title: "Так", style: .default, handler: { action in
                print ("OK")
                self.userRegisterGet ()
            }))

            self.present(alert, animated: true)
            
        }
        
    }
    
    
    
    
    @IBAction func tapRecognizerAction(_ sender: Any) {
        view.endEditing(true)
        
    }
    
    
    
    @IBAction func userAgreeLicenceBtn(_ sender: Any) {
        openUrl(urlStr: "https://api.shostka.in/app/useragreement.html")
    }
    
    
    
    func openUrl(urlStr:String!) {

        if let url = NSURL(string:urlStr) {
             UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }

    }
    
    
    
}

