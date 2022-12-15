//
//  BaseViewController.swift
//  News World
//
//  Created by Arman Merchant on 2022-11-21.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarTintColor()
        //setGradientBackground()
    }
    
    func hideNavBar(_ hidden:Bool = true, animated:Bool = true){
        navigationController?.setNavigationBarHidden(hidden, animated: animated)
    }
    func setNavBarTintColor(color:UIColor = .white, titleColor: UIColor = .black){
        navigationController?.navigationBar.barTintColor = color
        navigationController?.navigationBar.titleTextAttributes =  [NSAttributedString.Key.foregroundColor : titleColor]
    }
//    func setGradientBackground()  {
//        guard let tabBar = self.tabBarController?.tabBar else {return}
//        let gradientlayer = CAGradientLayer()
//        gradientlayer.frame = tabBar.bounds
//        gradientlayer.colors = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0, green: 0.5209681392, blue: 0.706921041, alpha: 1).cgColor]
//        gradientlayer.locations = [0, 1]
//        gradientlayer.startPoint = CGPoint(x: 1.0, y: 0.0)
//        gradientlayer.endPoint = CGPoint(x: 1.0, y: 1.0)
//        tabBar.layer.insertSublayer(gradientlayer, at: 0)
//    }
    func setBackButton() {
        let leftButtonView = UIView(frame: CGRect(x: 4, y: 4, width: 64, height: 24))
        let leftButton = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: leftButtonView.frame.height))
        leftButtonView.tintColor = .black
        leftButton.setImage(UIImage(systemName: "chevron.backward"), for: UIControl.State.normal)
        leftButton.addTarget(self, action: #selector(backButtonClicked), for: UIControl.Event.touchUpInside)
        leftButtonView.addSubview(leftButton)
        let leftNavButton = UIBarButtonItem(customView: leftButtonView)
        self.navigationItem.leftBarButtonItem = leftNavButton
    }
    @objc func backButtonClicked(){
        self.navigationController?.popViewController(animated: true)
    }
}
