import UIKit
import Kingfisher


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
    //    let textLabel = String.mentionedUsernames("1@2")
        
        let cityNameFiltered = city?.name.components(separatedBy: "#")
        print("City namber parameter \(String(describing: cityNameFiltered?[1]))")
        
        cityLabel.text = cityNameFiltered?[0]
        cityLabel.backgroundColor = UIColor(red: 135/255, green: 135/255, blue: 135/255, alpha: 0.5)
        if (cityNameFiltered?[1] == "1") {
        cityLabel.backgroundColor = UIColor(red: 67/255, green: 227/255, blue: 27/255, alpha: 0.5)
        }
        if (cityNameFiltered?[1] == "2") {
            cityLabel.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 12/255, alpha: 0.4)
        }
        if (cityNameFiltered?[1] == "3") {
            cityLabel.backgroundColor = UIColor(red: 245/255, green: 63/255, blue: 12/255, alpha: 0.5)
        }

       // var testLbl = city?.id
       // cityLabel.text = "Shostka"

        // Set image using url to the image view using kingfisher extension.
        
        if ((city?.id)! < 10000){
            cityImage.image = UIImage(named: (city?.imageUrl?.absoluteString)!)
        }
        else {
            cityImage.kf.setImage(with: city?.imageUrl, placeholder: UIImage(named: Constants.cityImagePlaceholder))
        }
        

        //
    }

    override func prepareForReuse() {
        // Before reuse the cell - clear it ...
        cityLabel.text = nil
        // ... and cancel image loading using Kingfisher extension.
        cityImage.kf.cancelDownloadTask()
    }
}
