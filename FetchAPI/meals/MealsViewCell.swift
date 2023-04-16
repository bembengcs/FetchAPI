//
//  MealsViewCell.swift
//  FetchAPI
//
//  Created by Tommy on 15/04/23.
//

import UIKit

class MealsViewCell: UICollectionViewCell {

    @IBOutlet weak var imgMeal: UIImageView!
    @IBOutlet weak var labelMealName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
    }

}
