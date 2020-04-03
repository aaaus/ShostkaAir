//
//  SensorsViewCell.swift
//  CityMap
//
//  Created by Aleksandr Andrusenko on 25.02.2019.
//  Copyright © 2019 it-shark. All rights reserved.
//

import UIKit
import Kingfisher

struct AllInfoGet: Codable {
    var arrUserResp: [String?]
  //  var points: Int
  //  var description: String?
}

private enum Constants {
    // Placeholder image for the cities that don't have photo (has the same name as appropriate image in assets folder).
    static let cityImagePlaceholder = "CityPlaceholder"
}

class SensorsViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var cityImage: UIImageView!
    @IBOutlet private weak var cityLabel: UILabel!
    
    /**
     Get currently represented city from cell or set the new city to update cell information.
     If you set nil value, city information will be cleared from cell.
     */
    var city: City? {
        didSet {
            update()
        }
    }
    
    private func update() {
      
        
        if (city?.id ?? 50 > 150) {
            guard let gitUrl = URL(string:
                      "http://sun.shostka.in/gps.php/?&allinfo=allinfo"
                       ) else { return }
                   print ("gitUrl \(gitUrl)")
                   
                   URLSession.shared.dataTask(with: gitUrl) { (data, response
                       , error) in
                   guard let data = data else { return }
                                 do {
                                     let decoder = JSONDecoder()
                                     let gitData = try decoder.decode(AllInfoGet.self, from: data)
                                     //print("gitData: \(gitData)")
                                     DispatchQueue.main.sync {
                                         
                                       guard let arrUserResp: Array<String> = gitData.arrUserResp as? Array<String> else { return }
                                         _ = (0..<(arrUserResp.count)).map { (i) -> String in
                 
                                           UserDefaults.standard.set(arrUserResp[1], forKey: "confirmedInfo")
                                           UserDefaults.standard.set(arrUserResp[2], forKey: "suspicionInfo")
                                           UserDefaults.standard.set(arrUserResp[3], forKey: "diedInfo")
                                           UserDefaults.standard.set(arrUserResp[4], forKey: "recoveredInfo")
                                           print("arrUserResp[i] \(arrUserResp[i]), \(i)")
                                             return "5"
                                                 }
                                     }
                                   
                    
                                 } catch let err {
                                     print("Err", err)
                                 }
                       //self.saveBTN.sendActions(for: .touchUpInside)
                       
                       }.resume()
        
        
    }
        
        
        // let parametrStatus = city?.location.latitude
        cityLabel.text = city?.name
        print("city?.name  \(String(describing: city?.name))")
        print("city?.name  \(String(describing: city?.id))")
        //cityLabel.text = "123"
 /*
        cityLabel.backgroundColor = UIColor(red: 135/255, green: 135/255, blue: 135/255, alpha: 0.5)
        if (parametrStatus == 1) {
            cityLabel.backgroundColor = UIColor(red: 67/255, green: 227/255, blue: 27/255, alpha: 0.5)
        }
        if (parametrStatus == 2) {
            cityLabel.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 12/255, alpha: 0.4)
        }
        if (parametrStatus == 3) {
            cityLabel.backgroundColor = UIColor(red: 245/255, green: 63/255, blue: 12/255, alpha: 0.5)
        }
*/
        
        
        //  let cityNameFiltered = city?.name.components(separatedBy: "#")
         if (city?.id ?? 50 < 150) {
          cityLabel.text = "Зареєструйтесь"
          cityLabel.backgroundColor = UIColor(red: 135/255, green: 135/255, blue: 135/255, alpha: 0.5)
          if (UserDefaults.standard.string(forKey: "warningHigh") == "1") {
              cityLabel.backgroundColor = UIColor(red: 67/255, green: 227/255, blue: 27/255, alpha: 0.5)
              cityLabel.text = "Не виявлено"
          }
          if (UserDefaults.standard.string(forKey: "warningHigh") == "2") {
              cityLabel.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 12/255, alpha: 0.4)
              cityLabel.text = "Є підозра"
          }
          if (UserDefaults.standard.string(forKey: "warningHigh") == "3") {
              cityLabel.backgroundColor = UIColor(red: 245/255, green: 63/255, blue: 12/255, alpha: 0.5)
              cityLabel.text = "Великий ризик"
          }
         } else {
            cityLabel.text = "Info"
            if (city?.name == "Info_1") {
                cityLabel.text = "Підтверджено: \((Int(UserDefaults.standard.string(forKey: "confirmedInfo") ?? "") ?? 0))"
            }
            if (city?.name == "Info_2") {
              cityLabel.text = "Підозра: \((Int(UserDefaults.standard.string(forKey: "suspicionInfo") ?? "") ?? 0))"
            }
            if (city?.name == "Info_3") {
              cityLabel.text = "Померло: \((Int(UserDefaults.standard.string(forKey: "diedInfo") ?? "") ?? 0))"
            }
            if (city?.name == "Info_4") {
              cityLabel.text = "Видужало: \((Int(UserDefaults.standard.string(forKey: "recoveredInfo") ?? "") ?? 0))"
            }
         }
    //    if (UserDefaults.standard.string(forKey: "warningHigh") == "") {
     //       cityLabel.text = "Зареєструйте пристрій"
     //   }
        
        
        
        
       // var imgName: String = (city?.imageUrl?.absoluteString)!
        
        // Set image using url to the image view using kingfisher extension.
        if ((city?.id)! < 10000){
          //  cityImage.image = UIImage(named: (city?.imageUrl?.absoluteString)! )
            cityImage.kf.setImage(with: city?.imageUrl, placeholder: UIImage(named: Constants.cityImagePlaceholder))
        }
        else {
            cityImage.kf.setImage(with: city?.imageUrl, placeholder: UIImage(named: Constants.cityImagePlaceholder))
        }
    }
    
    override func prepareForReuse() {
        // Before reuse the cell - clear it ...
        cityLabel.text = nil
        // ... and cancel image loading using Kingfisher extension.
        cityImage.kf.cancelDownloadTask()
    }

}
