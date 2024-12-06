//
//  BaseManager.swift
//  Bikuafor
//
//  Created by Hatice Taşdemir on 27.11.2024.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper

enum ErrorStatus {
    case validation
    case unauthenticated
    case other
}

enum MessageType: Int {
    case information = 0
    case error = 1
    case success = 2
    case warning = 3
}

class BaseManager: NSObject {
    
    func handleResponse<T>(showSuccessAlert: Bool = true,
                           showError: Bool = true,
                           showList: Bool = false,
                           showDetail: Bool = false,
                           response: AFDataResponse<ResponseResult<T>>,
                           success: ((T?) -> Void)? = nil,
                           failure: ((ErrorStatus) -> Void)? = nil) where T: Mappable {
        
        if let responseResult = response.value {
            if (responseResult.Success ?? false && responseResult.Code == 200) {
                
                if responseResult.Code == 200{
                    
                    if let message = responseResult.Message {
                        if showSuccessAlert {
                            AlertManager.showSuccess(message: message) {
                                success?(responseResult.Data)
                            }
                        }
                        else {
                            success?(responseResult.Data)
                        }
                    }
                    else {
                        success?(responseResult.Data)
                    }
                    
                }else{
                    
                    if let message = responseResult.Message {
                        if showError {
                            AlertManager.showWarning(message: message) {
                                success?(responseResult.Data)
                            }
                        }
                        else {
                            success?(responseResult.Data)
                        }
                    }
                    else {
                        success?(responseResult.Data)
                    }
                    
                    
                    //var _errorStatus = ErrorStatus.other
                    //if responseResult.Message != nil {
                    //    _errorStatus = .other
                    //    if showSuccessAlert {
                    //        // SweetAlert
                    //    }
                    //}
                    //self.handleError(showError: showError, showList: showList, showDetail: showDetail,  responseResult: responseResult, errorStatus: _errorStatus, failure: failure)
                }
                
            }
            else {
                var errorStatus = ErrorStatus.other
                
                if let statusCode = response.value?.Code {
                    if statusCode == 400 {
                        errorStatus = .validation
                    }
                    else if statusCode == 401 {
                        errorStatus = .unauthenticated
                        
                    }else if statusCode == 403 {
                        errorStatus = .unauthenticated
                        
                    }else if statusCode == 409 {
                        errorStatus = .other
                        responseResult.MessageType = 3
                    }
                    else if statusCode == 500 {
                        errorStatus = .other
                    } else
                    
                    if responseResult.Message != nil && statusCode != 403 {
                        errorStatus = .other
                        if showError {
                            // SweetAlert
                        }
                    }
                }
                var statusCode = response.value?.Code
                if statusCode != 403{
                    self.handleError(showError: showError, showList: showList, showDetail: showDetail,  responseResult: responseResult, errorStatus: errorStatus, failure: failure)
                }else{
                    self.handleError(showError: false, showList: showList, showDetail: showDetail,  responseResult: responseResult, errorStatus: errorStatus, failure: failure)
                }
                
            }
        }
        else {
            if showError, let _ = response.error?.localizedDescription {
                failure?(.other)
            }
        }
    }
    
    func handleError<T>(showError: Bool, showList: Bool, showDetail: Bool, responseResult: ResponseResult<T>, errorStatus: ErrorStatus, failure: ((ErrorStatus) -> Void)? = nil) where T: Mappable {
        
        if let validations = responseResult.Validations, validations.count > 0 {
            AlertManager.showWarning(message: validations[0].message) {
                failure?(errorStatus)
            }
        }
        else {
            
            if showError, let messageType = responseResult.MessageType, let message = responseResult.Message {
                
                if let messageTypeEnum = MessageType(rawValue: messageType) {
                    switch messageTypeEnum {
                    case MessageType.information:
                        AlertManager.showNotification(message: message, complation: {
                            failure?(errorStatus)
                        })
                        break
                    case MessageType.warning:
                        AlertManager.showWarning(message: message) {
                            failure?(errorStatus)
                        }
                        break
                    case MessageType.error:
                        if showList || showDetail {
                            
                            if showDetail {
                                AlertManager.showError(message: message) {
                                    failure?(errorStatus)
                                }
                            }
                        }
                        else {
                            AlertManager.showError(message: message) {
                                failure?(errorStatus)
                            }
                        }
                        
                        failure?(errorStatus)
                        break
                    case MessageType.success:
                        AlertManager.showSuccess(message: message) {
                            failure?(errorStatus)
                        }
                        break
                    }
                }
                else {
                    failure?(errorStatus)
                }
            }
            else {
                failure?(errorStatus)
            }
        }
    }
}
