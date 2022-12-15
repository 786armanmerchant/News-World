//
//  CustomButton.swift
//  News World
//
//  Created by Arman Merchant on 2022-10-10.
//

import UIKit

class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setRadiusAndShadow()
    }
      
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setRadiusAndShadow()
    }
      
    func setRadiusAndShadow() {
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
        layer.masksToBounds = false
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
//        layer.masksToBounds = false
     }
}
