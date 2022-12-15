//
//  SigninViewController.swift
//  News World
//
//  Created by Arman Merchant on 2022-10-10.
//

import UIKit
import Firebase
import MaterialTextField

class SigninViewController: UIViewController {
    

    @IBOutlet weak var emailTextfield: MFTextField!
    
    @IBOutlet weak var passwordTextfield: MFTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Looks for single or multiple taps.
             let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
            //tap.cancelsTouchesInView = false

            view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func newUser(_ sender: UIButton) {
        navigateToSignUp()
        
    }
    @IBAction func signinButtonClicked(_ sender: Any) {
        
        var isValidated = true
        if !(CommonUtils.validateTextfield(item: emailTextfield.getText(), regEx: RegEx.email)){
            isValidated = false
            emailTextfield.showError("Invalid email", true, .red)
        }else{
            emailTextfield.removeError()
        }
        if !(CommonUtils.validateTextfield(item: passwordTextfield.getText(), regEx: RegEx.password)){
            isValidated = false
            passwordTextfield.showError("Invalid password", true, .red)
        }else{
            passwordTextfield.removeError()
        }
        if isValidated {
            signingInUser()
        }
    }
    
    
    // MARK: - Signing In User

    fileprivate func signingInUser() {
        
        Auth.auth().signIn(withEmail: emailTextfield.getText(), password: passwordTextfield.getText()) {  authResult, error in

            if error != nil {

                 let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                 let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                
                  alertController.addAction(defaultAction)
                  self.present(alertController, animated: true, completion: nil)
                     
            }else {
           
          
                //Store login status
                DataPersistance.manager.setLoginStatus(true)
                DataPersistance.manager.setEmail(self.emailTextfield.getText())
                // Navigate user to HomeScreen
                self.navigateToHomeScreen()
            }
        }
    }
    
    fileprivate func navigateToHomeScreen(){
        guard let homeVC = CommonUtils.getViewController(id: "HomeTabViewController")   as? HomeTabViewController else {
            return
        }
//        let nav = UINavigationController(rootViewController:  homeVC)
//         nav.navigationBar.isTranslucent = true
//         nav.navigationBar.prefersLargeTitles = true
         self.window?.rootViewController = homeVC
         self.window?.makeKeyAndVisible()
    }
    
    // MARK: - Navigation
    // Navigate to Sign Up
    fileprivate func navigateToSignUp(){
        guard let signupVC = CommonUtils.getViewController(id: "SignupViewController")   as? SignupViewController else {
            return
        }
        navigationController?.pushViewController(signupVC, animated: true)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

}
