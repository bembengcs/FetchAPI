//
//  DetailViewController.swift
//  FetchAPI
//
//  Created by Tommy on 15/04/23.
//

import UIKit
import Alamofire
import Kingfisher

class DetailViewController: UIViewController {
    
    struct Meals: Codable {
        let meals: [[String: String?]]
    }
    
    var idMeal = ""

    @IBOutlet weak var labelStrMeal: UILabel!
    @IBOutlet weak var labelStrInstructions: UILabel!
    @IBOutlet weak var imageDetail: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        debugPrint(idMeal)

        let url = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(idMeal)"
        
        AF.request(url).responseData { response in
            let decoder = JSONDecoder()
            let mealDetail: Meals = try!
            decoder.decode(Meals.self, from: response.value!)
            
            let itemDetail = mealDetail.self.meals[0]
            
            let strMealThumb = itemDetail["strMealThumb"] ?? "nil"
            let strMeal = itemDetail["strMeal"] ?? "nil"
            let strInstructions = itemDetail["strInstructions"] ?? nil
            
            DispatchQueue.main.async {
                self.imageDetail.kf.setImage(with: URL(string: strMealThumb!))
                self.labelStrMeal.text = strMeal
                self.labelStrInstructions.text = strInstructions
            }
        }
    }
}
