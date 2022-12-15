//
//  SettingViewController.swift
//  News World
//
//  Created by Arman Merchant on 2022-10-11.
//

import UIKit
import Firebase

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
  


        // Do any additional setup after loading the view.
    }
    

    @IBAction func signOutButton(_ sender: CustomButton) {
        
        
        do {
            
          try Auth.auth().signOut()
           // navigationController?.popToRootViewController(animated: true)
        navigateToSignIn()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    func navigateToSignIn(){
        guard let signinVC = CommonUtils.getViewController(id: "WelcomeViewController")   as? WelcomeViewController else {
            return
        }
       let nav = UINavigationController(rootViewController:  signinVC)
        nav.navigationBar.isTranslucent = true
        nav.navigationBar.prefersLargeTitles = true
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
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
