import UIKit
import Kingfisher

struct UserStatusGet: Codable {
    var arrUserResp: [String?]
  //  var points: Int
  //  var description: String?
}

private enum Constants {
    // Placeholder image for the cities that don't have photo (has the same name as appropriate image in assets folder).
    static let cityImagePlaceholder = "CityPlaceholder"
    static let cityLogo = "Logo"
}

/**
    Custom collection view cell to show brief information about the city it contains.
 */
class CityViewCell: UICollectionViewCell {

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
        
     /*
        
            if (city?.id ?? 0 < 10) {
                guard let gitUrl = URL(string:
                          "http://api.shostka.in/cam/cam.php/?&allinfo=allinfo"
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
        
        
        
      
        
        if ((Int(UserDefaults.standard.string(forKey: "userPswd") ?? "") ?? 0) > 5) {
        guard let gitUrl = URL(string:
                  "http://api.shostka.in/cam/cam.php/?&userstatus=userstatus&userPswd=\(UserDefaults.standard.string(forKey: "userPswd") ?? "1")"
                   ) else { return }
               print ("gitUrl \(gitUrl)")
               
               URLSession.shared.dataTask(with: gitUrl) { (data, response
                   , error) in
               guard let data = data else { return }
                             do {
                                 let decoder = JSONDecoder()
                                 let gitData = try decoder.decode(UserStatusGet.self, from: data)
                                 //print("gitData: \(gitData)")
                                 DispatchQueue.main.sync {
                                     
                                   guard let arrUserResp: Array<String> = gitData.arrUserResp as? Array<String> else { return }
                                     _ = (0..<(arrUserResp.count)).map { (i) -> String in
             
                                       UserDefaults.standard.set(arrUserResp[1], forKey: "warningLow")
                                       UserDefaults.standard.set(arrUserResp[2], forKey: "warningHigh")
                                      // print("arrUserResp[i] \(arrUserResp[i]), \(i)")
                                         return "5"
                                             }
                                 }
                               
                
                             } catch let err {
                                 print("Err", err)
                             }
                   //self.saveBTN.sendActions(for: .touchUpInside)
                   
                   }.resume()
        
        }
        
     */
        
    //    let textLabel = String.mentionedUsernames("1@2")
        
        let cityNameFiltered = city?.name.components(separatedBy: "#")
      //  print("City namber parameter \(String(describing: cityNameFiltered?[1]))")
        //print(UserDefaults.standard.string(forKey: "warningHigh") ?? "55555")
        cityLabel.text = cityNameFiltered?[0]
        cityLabel.backgroundColor = UIColor(red: 135/255, green: 135/255, blue: 135/255, alpha: 0.5)
       // if (cityNameFiltered?[1] == "1") {
        if (UserDefaults.standard.string(forKey: "warningHigh") == "1") {
            cityLabel.backgroundColor = UIColor(red: 67/255, green: 227/255, blue: 27/255, alpha: 0.5)
        }
       // if (cityNameFiltered?[1] == UserDefaults.standard.string(forKey: "warningHigh") ?? "1") {
        if (UserDefaults.standard.string(forKey: "warningHigh") == "2") {
            cityLabel.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 12/255, alpha: 0.4) 
        }
       // if (cityNameFiltered?[1] == UserDefaults.standard.string(forKey: "warningHigh") ?? "1") {
        if (UserDefaults.standard.string(forKey: "warningHigh") == "3") {
            cityLabel.backgroundColor = UIColor(red: 245/255, green: 63/255, blue: 12/255, alpha: 0.5)
        }

       // var testLbl = city?.id
       // cityLabel.text = "Shostka"

        // Set image using url to the image view using kingfisher extension.
        // https://github.com/onevcat/Kingfisher/wiki/Cheat-Sheet
        let cache = ImageCache.default
        // Remove all.
        cache.clearMemoryCache()
        cache.clearDiskCache { print("Done") }
        
        if ((city?.id)! < 10000){
            //cityImage.image = UIImage(named: (city?.imageUrl?.absoluteString)!)
            cityImage.kf.setImage(with: city?.imageUrl, placeholder: UIImage(named: Constants.cityImagePlaceholder))
        }
        else {
            cityImage.kf.setImage(with: city?.imageUrl, placeholder: UIImage(named: Constants.cityImagePlaceholder))
        }
        //let dID = CFUUIDCreate(kCFAllocatorDefault)
        //let deviceID = CFUUIDCreateString(kCFAllocatorDefault, dID) as NSString
        //print("City namber parameter \(String(describing: dID)), two \(deviceID)")
        
        

        //
    }

    override func prepareForReuse() {
        // Before reuse the cell - clear it ...
        cityLabel.text = nil
        // ... and cancel image loading using Kingfisher extension.
        cityImage.kf.cancelDownloadTask()
    }
}
