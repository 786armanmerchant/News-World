//
//  Extension.swift
//  News World
//
//  Created by Arman Merchant on 2022-10-10.
//

import Foundation
import UIKit
import MaterialTextField


extension UITextField {
    func getText()-> String{
        return self.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    func makeCapital()->String{
        return self.getText().uppercased()
    }
}



extension MFTextField {
    func showError(_ message: String, _ animated: Bool = false, _ errorColor: UIColor = .red) {
        let error = NSError(domain: "errorDomain", code: 100, userInfo: [NSLocalizedDescriptionKey: NSLocalizedString(message, comment: message)])
        self.setError(error, animated: animated)
        self.errorColor = errorColor
    }

    func removeError() {
        self.setError(nil, animated: true)
    }
    func setActiveLabelColor(_ color: UIColor = .black) {
        self.tintColor = color
    }
}


extension UIView {
    func addShadow(cornerRadius:CGFloat = 15, shadowRadius:CGFloat = 20, shadowColor:UIColor = UIColor.gray, shadowOffset: CGSize = CGSize(width: 0.0, height: 0.3), opacity:Float = 0.5){
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: shadowRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = opacity
        layer.shadowPath = shadowPath.cgPath
        
    }
    func setupCardView(){
        layer.cornerRadius = 10.0
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 0.7
    }
    
    func addSubviewForAutoLayout(_ view: UIView) {
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addGradient(count: Int, index: UInt32) {
        //        print(self.layer.sublayers?.count)
        
        if self.layer.sublayers == nil {
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = self.bounds
            gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
            self.layer.insertSublayer(gradientLayer, at: index)
            return
        }
        
        guard self.layer.sublayers?.count == count else { return }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        self.layer.insertSublayer(gradientLayer, at: index)
    }
    
}


extension UIViewController {
    var window: UIWindow? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let delegate = windowScene.delegate as? SceneDelegate, let window = delegate.window else { return nil }
        return window
    }
    
 
    
}

extension UIButton {
    
    func makeStarndard(radius: CGFloat = 10, borderWidth: CGFloat = 0, borderColor:UIColor = .white){
        layer.cornerRadius = radius
        layer.masksToBounds = true
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
}


extension UICollectionView {

    convenience init(frame: CGRect, direction: UICollectionView.ScrollDirection, identifiers: [String]) {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = direction
        layout.minimumLineSpacing = 0

        self.init(frame: frame, collectionViewLayout: layout)

        guard let nameSpace = Bundle.nameSpace else { return }

        for identifier in identifiers {
            if let anyClass: AnyClass = NSClassFromString("\(nameSpace).\(identifier)") {
                self.register(anyClass, forCellWithReuseIdentifier: identifier)
            }
        }
    }

}


extension Bundle {

    static var nameSpace: String? {
        guard let info = Bundle.main.infoDictionary,
              let projectName = info["CFBundleExecutable"] as? String else { return nil }

        let nameSpace = projectName.replacingOccurrences(of: "-", with: "_")

        return nameSpace
    }

}


extension  String {
    func localize()-> String{
        let path = Bundle.main.path(forResource: DataPersistance.getAppLanguage(), ofType: "lproj")
             let bundle =  Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: self, comment: "")
    }
}
