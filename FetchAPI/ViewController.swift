//
//  ViewController.swift
//  FetchAPI
//
//  Created by Tommy on 28/03/23.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let vc = CategoriesViewController(nibName: String(describing: CategoriesViewController.self), bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
