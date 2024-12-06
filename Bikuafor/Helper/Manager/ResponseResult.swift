//
//  ResponseResult.swift
//  Bikuafor
//
//  Created by Hatice Taşdemir on 27.11.2024.
//


import Foundation
import ObjectMapper

public class ResponseResult<T>: NSObject, Mappable  where T: Mappable  {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private let dataKey = "Data"
    private let successKey = "Success"
    private let codeKey = "Code"
    private let messageKey = "Message"
    private let messageTypeKey = "MessageType"
    private let internalMessageKey = "InternalMessage"
    private let validationsKey = "Validations"
    
    // MARK: Properties
    
    public var Data: T?
    public var Success: Bool?
    public var Code: Int?
    public var Message: String?
    public var MessageType: Int?
    public var InternalMessage: String?
    public var Validations: [ResultValidation]?
    
    
    // MARK: ObjectMapper Initializers
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public required init?(map: Map){
    }
    
    public required override init() {
        super.init()
    }
    
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public func mapping(map: Map) {
        Data <- map[dataKey]
        Success <- map[successKey]
        Message <- map[messageKey]
        MessageType <- map[messageTypeKey]
        InternalMessage <- map[internalMessageKey]
        Validations <- map[validationsKey]
        Code  <- map[codeKey]
  }

  

}
