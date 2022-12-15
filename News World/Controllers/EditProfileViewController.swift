//
//  EditProfileViewController.swift
//  News World
//
//  Created by Arman Merchant on 2022-11-28.
//

import UIKit

protocol editDetailsDelegate: NSObject{
    func didEditComplete(account:Account)
}
class EditProfileViewController: BaseViewController {


    @IBOutlet weak var editTextField: UITextField!
    @IBOutlet weak var editButton: UIButton!
    weak var delegate: editDetailsDelegate?
    var account:Account!
    var index:Int!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func editButtonClicked(_ sender: Any) {
        guard !editTextField.getText().isEmpty else { return }
        switch index{
        case 1:
            account.fname = editTextField.getText()
        case 2:
            account.lname = editTextField.getText()
        default:
            print("")
        }
        self.dismiss(animated: true) {
            self.delegate?.didEditComplete(account: self.account)
        }
    }
}
