//
//  FilterByCategoryViewController.swift
//  FetchAPI
//
//  Created by Tommy on 12/04/23.
//

import UIKit
import Alamofire
import Kingfisher

class MealsViewController: UIViewController {
    
    struct MealsResponse: Codable {
        let meals: [Meal]
    }
    
    struct Meal: Codable {
        let strMeal: String
        let strMealThumb: String
        let idMeal: String
    }
    
    @IBOutlet weak var collectionMeals: UICollectionView!
    
    var categoryName = ""
    var mealsData: [Meal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(categoryName)"
        
        AF.request(url).responseData { [self] response in
            let decoder = JSONDecoder()
            let listMealsResponse: MealsResponse = try!
            decoder.decode(MealsResponse.self, from: response.value!)
            
            self.mealsData = listMealsResponse.meals
            
            DispatchQueue.main.async {
                self.collectionMeals.reloadData()
            }
        }
        
        
        collectionMeals.dataSource = self
        collectionMeals.delegate = self
        collectionMeals.register(UINib(nibName: String(describing: MealsViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: MealsViewCell.self))
    }
}

extension MealsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        mealsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let meal = mealsData[indexPath.row]
        let cell = collectionMeals.dequeueReusableCell(withReuseIdentifier: String(describing: MealsViewCell.self), for: indexPath) as! MealsViewCell
        
        cell.imgMeal.kf.setImage(with: URL(string: meal.strMealThumb))
        cell.labelMealName.text = meal.strMeal
        
        return cell
    }
}

extension MealsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let idMeal = mealsData[indexPath.row].idMeal
        
        let vc = DetailViewController(nibName: String(describing: DetailViewController.self), bundle: nil)
        vc.idMeal = idMeal
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MealsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: 150)
    }
}
