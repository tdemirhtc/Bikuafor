//
//  ResultValidation.swift
//  Bikuafor
//
//  Created by Hatice Taşdemir on 27.11.2024.
//

import Foundation
import Foundation
import ObjectMapper

public final class ResultValidation: Mappable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private let fieldKey = "Field"
    private let messageKey = "Message"
    
    
    // MARK: Properties
    public var field: String?
    public var message: String?
    
    // MARK: ObjectMapper Initializers
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public required init?(map: Map){
        //super.init(map: map)
    }
    
    public required init() {
        //super.init()
    }
    
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public func mapping(map: Map) {
        field <- map[fieldKey]
        message <- map[messageKey]
    }
    
}
