//
//  LunchCollectionViewCell.swift
//  BottleRocketAssignement
//
//  Created by Hassan Baraka on 4/14/21.
//

import UIKit

class LunchCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lunchImage: UIImageView!
    
    @IBOutlet weak var resturantNameLabel: UILabel!
    
    @IBOutlet weak var categoryTypeLabel: UILabel!
    
    static let reuseId = String(describing: LunchCollectionViewCell.self)
    var viewModel:LunchViewModel?
    
    func configure(with viewModel:LunchViewModel){
        let urlString = viewModel.backgroundImageURL
        print(urlString)
        self.layer.insertSublayer(gradient(frame: self.bounds), at:0)
        let url = URL(string: urlString)
        print(url as Any)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async { [self] in
                lunchImage.image = UIImage(data: data!)
                lunchImage.alpha = 0.8
               
            }
        }
        
       
        self.viewModel = viewModel
        resturantNameLabel.text = viewModel.name
        categoryTypeLabel.text = viewModel.category
    }
    
    func gradient(frame:CGRect) -> CAGradientLayer {
            let layer = CAGradientLayer()
            layer.frame = frame
            layer.startPoint = CGPoint(x: 0, y: 0.5)
            layer.endPoint = CGPoint(x: 1, y: 0.5)
            layer.colors = [
                UIColor.white.cgColor,UIColor.black.cgColor]
            return layer
        }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
