//
//  WelcomeViewController.swift
//  News World
//
//  Created by Arman Merchant on 2022-10-10.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var signinButton: CustomButton!
    
    @IBOutlet weak var faqButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
        // TITLE ANIMANTION
        
        titleLabel.text = ""
        var charIndex = 0.0
        let titleText = "News World"
        
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                self.titleLabel.text?.append(letter)
                
            }
            charIndex += 1
           
        }
        
        
    }

    
    
    @IBAction func signupBUttonClicked(_ sender: Any) {
       navigateToSignUp()
    }
    
    @IBAction func signinBUttonClicked(_ sender: Any) {
        
       navigateToSignIn()
        
    }
    
    @IBAction func faqButtonClicked(_ sender: Any) {
        guard let FAQVC = CommonUtils.getViewController(id: "FAQViewController") as? FAQViewController else {
            return
        }
        navigationController?.pushViewController(FAQVC, animated: true)
    }
    
    
    
    
    
    
    
    // Navigate to Sign Up
    fileprivate func navigateToSignUp(){
        guard let signupVC = CommonUtils.getViewController(id: "SignupViewController")   as? SignupViewController else {
            return
        }
        navigationController?.pushViewController(signupVC, animated: true)
    }
    
    // Navigate to Sign In
    fileprivate func navigateToSignIn(){
        guard let signinVC = CommonUtils.getViewController(id: "SigninViewController") as? SigninViewController else {
            return
        }
        navigationController?.pushViewController(signinVC, animated: true)
    }
        
    }
