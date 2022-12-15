//
//  DataPersistance.swift
//  News World
//
//  Created by Arman Merchant on 2022-11-28.
//

import Foundation

class DataPersistance:NSObject {
    static let manager = DataPersistance()
    static let userDefaults = UserDefaults.standard

     func isLoggedIn() -> Bool? {
        if DataPersistance.contains(key: UserDefaultsKeys.loginStatus) {
            return true
        } else {
            return nil
        }
    }

     func setLoginStatus(_ isUserLogged: Bool?) {
        guard let status = isUserLogged else { return }
        DataPersistance.save(key: UserDefaultsKeys.loginStatus, data: status as AnyObject)
    }
    func setEmail(_ email:String?){
        guard let email = email else {
            return
        }
        DataPersistance.save(key: UserDefaultsKeys.email, data: email as AnyObject)
    }
    func getEmail()->String?{
       // if DataPersistance.contains(key: UserDefaultsKeys.loginStatus) {
            return DataPersistance.userDefaults.string(forKey: UserDefaultsKeys.email)
      //  } else {
          //  return nil
       // }
    }
    
    
    
    class func saveAppLangage(language: String){
              UserDefaults.standard.set(language, forKey: "appLang")
              
          }
          //MARK: Get app language
          class func getAppLanguage()-> String {
              if let lang = UserDefaults.standard.string(forKey: "appLang") {
                  return lang
              } else {
                  return "en-US"
              }
          }
    
    static func save(key: String, data: AnyObject) {
        userDefaults.set(data, forKey: key)
        userDefaults.synchronize()
    }
    static func contains(key: String) -> Bool {
        if userDefaults.object(forKey: key) != nil {
            return true
        }
        return false
    }
    func removeAll() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        DataPersistance.userDefaults.synchronize()
    }
}
