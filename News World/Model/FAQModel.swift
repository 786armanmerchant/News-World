//
//  FAQModel.swift
//  News World
//
//  Created by Arman Merchant on 2022-11-21.
//

import Foundation
import FirebaseFirestoreSwift

class Faq: NSObject, Codable, Identifiable{
    @DocumentID var id: String?
    var question:String?
    var answer:String?
}


