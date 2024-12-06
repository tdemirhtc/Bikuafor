//
//  AuthanticationManager.swift
//  Bikuafor
//
//  Created by Hatice Taşdemir on 27.11.2024.
//

import Foundation
import UIKit
import Foundation
import Alamofire
import SwiftLoader

class AuthenticationManager : BaseManager {
    
    static let instance = AuthenticationManager()
    
    func login(parameters: LoginRequest , success: ((LoginResponse?) -> Void)? = nil, failure: ((ErrorStatus) -> Void)? = nil) {
        
        AlamofireManager.instance.responseObject(url: RestApiURLManager.login, parameters: parameters.toDictionary(), showLoader: true) { (response: (AFDataResponse<ResponseResult<LoginResponse>>)) in
            SwiftLoader.hide()
            super.handleResponse(showSuccessAlert: false, response:response, success: success, failure: failure)
        }
    }
  
    func getOneCustomer(parameters: getOnecustomerRequest , success: ((getOneCustomerResponse?) -> Void)? = nil, failure: ((ErrorStatus) -> Void)? = nil) {
        
        AlamofireManager.instance.responseObject(url: RestApiURLManager.getOneCustomer, parameters: parameters.toDictionary(), showLoader: true) { (response: (AFDataResponse<ResponseResult<getOneCustomerResponse>>)) in
            SwiftLoader.hide()
            super.handleResponse(showSuccessAlert: false, response:response, success: success, failure: failure)
        }
    }
    
    func FindClosestSalons(parameters: FindClosestSalonsRequest , success: ((FindClosestSalonsResponse?) -> Void)? = nil, failure: ((ErrorStatus) -> Void)? = nil) {
        
        AlamofireManager.instance.responseObject(url: RestApiURLManager.findClosestSalon, parameters: parameters.toDictionary(), showLoader: true) { (response: (AFDataResponse<ResponseResult<FindClosestSalonsResponse>>)) in
            SwiftLoader.hide()
            super.handleResponse(showSuccessAlert: false, response:response, success: success, failure: failure)
        }
    }
    
    
    
    
    
}
