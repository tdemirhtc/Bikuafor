//
//  BaseModel.swift
//  Bikuafor
//
//  Created by Hatice Taşdemir on 27.11.2024.
//

import Foundation
import UIKit
import ObjectMapper

protocol DefineModel {
    var id: Int? { get set }
    var name : String? { get set }
}
protocol DefineModelString {
    var id: String? { get set }
    var name : String? { get set }
}

@objcMembers
class BaseModel: NSObject, NSCoding, Mappable {
    
    override init(){}
    
    func mapping(map: Map) {
        
    }
    
    required init?(map: Map) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
    }
    
    func encode(with aCoder: NSCoder) {
        
    }
    
    func propertyNames() -> [String] {
        return Mirror(reflecting: self).children.compactMap { $0.label }
        }
    
    func isContainsProperty(property: String) -> Bool {
        return propertyNames().contains(property)
    }
}
