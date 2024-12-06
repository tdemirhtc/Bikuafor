//
//  BaseResponse.swift
//  Bikuafor
//
//  Created by Hatice Taşdemir on 27.11.2024.
//


import Foundation
import ObjectMapper

class BaseResponse : BaseModel {
    
    var Success : Bool?
    var Message : String!
    var Code : Int!
    var Data : AnyObject?
    
    override func mapping(map: Map) {
        Message <- map["Message"]
        Success <- map["Success"]
        Code <- map["Code"]
        Data <- map["Data"]
    }
    
    class func newInstance(map: Map) -> Mappable?{
        return BaseResponse()
    }
    
    required init?(map: Map) {super.init(map: map)}
    override init(){super.init()}
    
    @objc required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Message = aDecoder.decodeObject(forKey: "Message") as? String
        Success = aDecoder.decodeObject(forKey: "Success") as? Bool
        Code = aDecoder.decodeObject(forKey: "Code") as? Int
        Data = aDecoder.decodeObject(forKey: "Data") as? AnyObject
        
        
    }
}
