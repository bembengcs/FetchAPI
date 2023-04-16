//
//  CategoriesViewController.swift
//  FetchAPI
//
//  Created by Tommy on 11/04/23.
//

import UIKit
import Alamofire
import Kingfisher

class CategoriesViewController: UIViewController {
    
    struct CategoriesResponse: Codable {
        let categories: [Category]
    }
    
    // MARK: - Category
    struct Category: Codable {
        let idCategory, strCategory: String
        let strCategoryThumb: String
        let strCategoryDescription: String
    }
    
    var data: [Category] = []
    
    @IBOutlet weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationItem.hidesBackButton = true
        
        let url = "https://www.themealdb.com/api/json/v1/1/categories.php"
        
        AF.request(url).responseData { [self] response in
            let decoder = JSONDecoder()
            let listCategoriesResponse: CategoriesResponse = try!
            decoder.decode(CategoriesResponse.self, from: response.value!)
            
            self.data = listCategoriesResponse.categories
            
            DispatchQueue.main.async {
                self.collection.reloadData()
            }
        }
        
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib(nibName: String(describing: CategoryCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: CategoryCollectionViewCell.self))
    }
}

extension CategoriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = data[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CategoryCollectionViewCell.self), for: indexPath) as! CategoryCollectionViewCell
        
        cell.imageCategory.kf.setImage(with: URL(string: category.strCategoryThumb))
        cell.labelCategoryName.text = category.strCategory
        
        return cell
    }

}

extension CategoriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let categoryName = data[indexPath.row].strCategory
        
        let vc = MealsViewController(nibName: String(describing: MealsViewController.self), bundle: nil)
        vc.categoryName = categoryName
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension CategoriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let padding: CGFloat =  16
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: 150)
    }
}
