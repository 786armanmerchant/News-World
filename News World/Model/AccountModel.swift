//
//  AccountModel.swift
//  News World
//
//  Created by Arman Merchant on 2022-11-28.
//

import Foundation
import FirebaseFirestoreSwift


class Account: NSObject, Codable, Identifiable{
    @DocumentID var id: String?
    var fname:String?
    var lname:String?
    var email:String?
    var dp:String?
}
