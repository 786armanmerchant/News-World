//
//  AccountHeaderTableViewCell.swift
//  News World
//
//  Created by Arman Merchant on 2022-11-28.
//

import Foundation
import UIKit
import Kingfisher

class AccountHeaderTableViewCell: UITableViewCell {
    var dp:String?{
        didSet{
            CommonUtils.setImageForDp(url: dp ?? "", imageView: imgView)
        }
    }
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        editButton.setTitle("", for: .normal)
        imgView.layer.cornerRadius = imgView.frame.width/2
        imgView.contentMode = .scaleAspectFit
    }
}
