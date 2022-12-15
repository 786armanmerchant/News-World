//
//  Constants.swift
//  News World
//
//  Created by Arman Merchant on 2022-10-10.
//

import Foundation

enum RegEx{
    static let email    = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    static let password = ".{6,}"
    static let name     = ".{2,}"
}

struct FirestoreKeys {
    static let matches = "matches"
    static let faq = "faqs"
    static let accounts = "accounts"
}


enum MatchType: Int{
    case football = 0
    case cricket = 1
    case basketball = 2
}

enum NewsCategory: String, CaseIterable, Codable {
    case general
    case business
    case entertainment
    case health
    case science
    case sports
    case technology
    
    var systemName: String {
        switch self {
        case .general:
            return "newspaper"
        case .business:
            return "briefcase"
        case .entertainment:
            return "film"
        case .health:
            return "stethoscope"
        case .science:
            return "bolt"
        case .sports:
            return "sportscourt"
        case .technology:
            return "desktopcomputer"
        }
    }
}


enum NewsCountry: String, CaseIterable, Codable {
    case au
    case ca
    case ch
    case `in`
    case us

    
    var systemName: String {
        switch self {
        case .au:
            return "🇦🇺 Australia "
        case .ca:
            return "🇨🇦 Canada "
        case .ch:
            return "🇨🇳 China "
        case .`in`:
            return "🇮🇳 India "
        case .us:
            return "🇺🇸 United States "
   
        }
    }
}


struct UserDefaultsKeys {
    static let loginStatus = "userAuthenticated"
    static let email = "email"
}





