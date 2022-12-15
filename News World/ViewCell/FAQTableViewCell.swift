//
//  FAQTableViewCell.swift
//  News World
//
//  Created by Arman Merchant on 2022-11-21.
//

import Foundation
import UIKit


class FAQTableViewCell: UITableViewCell {
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var container: UIView!
    
    var FAQ: Faq?{
        didSet{
            setupFAQs(FAQ:FAQ)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .white
        container.setupCardView()
    }
    fileprivate func setupFAQs(FAQ:Faq?){
        question.text = FAQ?.question
        answer.text = FAQ?.answer
    }

}
