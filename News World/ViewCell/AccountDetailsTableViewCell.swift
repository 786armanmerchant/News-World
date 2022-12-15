//
//  AccountDetailsTableViewCell.swift
//  News World
//
//  Created by Arman Merchant on 2022-11-28.
//

import UIKit

class AccountDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var editButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        editButton.setTitle("", for: .normal)
     
        
        
    }
    
    
    

    
    
     func setupAccount(account:Account?, index:Int){
        var item: String = ""
         var title: String? = ""
         print(index)
        switch index {
        case 1:
            item = account?.fname ?? "first name"
            title = "FIRST NAME"
            editButton.isHidden = false
        case 2:
            item = account?.lname ?? "last name"
            title = "LAST NAME"
            editButton.isHidden = false
        case 3:
            item = account?.email ?? "email"
            title = "EMAIL"
            editButton.isHidden = true
        case 4:
            item = "SIGN OUT"
            title = ""
            editButton.isHidden = true
        default:
            item = ""
        }
         itemLabel.text = item.localize()
         titleLbl.text = title?.localize()
    }
}
