//
//  UserManager.swift
//  Bikuafor
//
//  Created by Hatice Taşdemir on 29.11.2024.
//

import Foundation
import UIKit

class UserDefaultManager: NSObject {

    static func setValue(key: String, value: Any?) {
        
        UserDefaults.standard.setValue(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    static func getValue(key: String) -> Any? {
        
        return UserDefaults.standard.value(forKey: key)
    }
    
    static func setObject<T>(key: String, value: T) where T: BaseModel {
       
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: value)
        userDefaults.set(encodedData, forKey: key)
        userDefaults.synchronize()
    }
    
    static func getObject<T>(key: String) -> T? where T: BaseModel {
        
        let userDefaults = UserDefaults.standard
        let decoded  = userDefaults.object(forKey: key) as! Data
        let decodedObject = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? T
        
        return decodedObject
    }
    
    static func removeObject(key: String) {
        
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
}
