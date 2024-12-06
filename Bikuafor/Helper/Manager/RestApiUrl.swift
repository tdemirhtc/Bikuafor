//
//  RestApiUrl.swift
//  Bikuafor
//
//  Created by Hatice Taşdemir on 27.11.2024.
//

import Foundation
import UIKit

class RestApiURLManager: NSObject {
    
    class var mPreffixURL: String  { return StaticVariables.serviceURL }
    
    
    
    class var login: URL { return URL(string:  mPreffixURL + "/api/authentication/login")! }
    
    class var findClosestSalon: URL { return URL (string: mPreffixURL + "/api/salon/findClosestSalons")! }
    class var getOneCustomer: URL { return URL (string: mPreffixURL + "/api/customer/getOneCustomer")! }  
    class var updateCustomer: URL { return URL (string: mPreffixURL + "/api/customer/updateCustomerReview")! }
    
}

