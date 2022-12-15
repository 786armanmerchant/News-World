//
//  MatchModel.swift
//  News World
//
//  Created by Arman Merchant on 2022-11-20.
//

import Foundation
import FirebaseFirestoreSwift

class Match: NSObject, Codable, Identifiable{
    @DocumentID var id: String?
    var name:String?
    var score:String?
    var type: Int?
}

