//
//  getOneCustomer.swift
//  Bikuafor
//
//  Created by Hatice Taşdemir on 4.12.2024.
//

import Foundation

import ObjectMapper

@objcMembers
class getOnecustomerRequest : BaseParameter{
    
    var Id: Int?
    
    public required init() {
        super.init()
    }
    
    init(fromDictionary dictionary: [String:Any]){
        
        Id = dictionary["Id"] as? Int
        
    }
    
    override func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        
        if Id != nil{
            dictionary["Id"] = Id
        }
        return dictionary
        
    }

    @objc required init?(coder aDecoder: NSCoder)
    {
        Id = (aDecoder.decodeObject(forKey: "Id") as? Int)!
        
    }
    
    @objc  func encode(with aCoder: NSCoder)
    {
        
        if Id != nil{
            aCoder.encode(Id, forKey: "Id")
        }
        
    }
}
