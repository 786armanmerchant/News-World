//
//  CommonUtils.swift
//  News World
//
//  Created by Arman Merchant on 2022-10-10.
//

import Foundation
import UIKit
import Lottie
import Kingfisher


class CommonUtils {
    
    class func getViewController(id:String)-> UIViewController? {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        return sb.instantiateViewController(withIdentifier: id)
    }
    
    class func validateTextfield(item:String, regEx:String)->Bool{
        let emailPred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return emailPred.evaluate(with: item)
    }
    
    class func playLottieAnimation(fileName: String,animationView: AnimationView, loopMode:LottieLoopMode){
        animationView.animation = Animation.named(fileName)
        animationView.loopMode = loopMode
        animationView.play()
    }
    
    class func setImageFrom(url: URL?, imageView: UIImageView? = nil ){
        guard let imageURL = url else {return}
        let resource = ImageResource(downloadURL: imageURL)

        imageView?.contentMode = .scaleToFill
        imageView?.kf.indicatorType = .activity
        imageView?.kf.setImage(with: resource)
    }
    
    
    class func setImageForDp(url: String, imageView: UIImageView? = nil ){
        guard let imgURL = URL.init(string: url) else {
            return
        }
        let resource = ImageResource(downloadURL: imgURL)
        
            imageView?.contentMode = .scaleToFill
            imageView?.kf.indicatorType = .activity
            imageView?.kf.setImage(with: resource)
    }
}
