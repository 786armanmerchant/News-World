//
//  HomeTabViewController.swift
//  News World
//
//  Created by Arman Merchant on 2022-10-10.
//

import UIKit

class HomeTabViewController: UITabBarController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true

      
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.items?[0].title = "NEWS".localize()
        tabBar.items?[1].title = "CATEGORY".localize()
        tabBar.items?[2].title = "SPORTS".localize()
        tabBar.items?[3].title = "SETTINGS".localize()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
