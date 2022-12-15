//
//  ScoreViewController.swift
//  News World
//
//  Created by Arman Merchant on 2022-11-21.
//

import UIKit
import Lottie

class ScoreViewController: UIViewController {

    @IBOutlet weak var animationView: AnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CommonUtils.playLottieAnimation(fileName: "money", animationView: animationView, loopMode: .loop)
    }

}
