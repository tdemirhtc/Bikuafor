//
//  FindClosestSalons.swift
//  Bikuafor
//
//  Created by Hatice Taşdemir on 27.11.2024.
//

import Foundation
import Foundation
import ObjectMapper

@objcMembers
class FindClosestSalonsRequest : BaseParameter{
    
    var SearchValue: String?
    
    public required init() {
        super.init()
    }
    
    init(fromDictionary dictionary: [String:Any]){
        
        SearchValue = dictionary["SearchValue"] as? String
        
    }
    
    override func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        
        if SearchValue != nil{
            dictionary["SearchValue"] = SearchValue
        }
        return dictionary
        
    }
    
    
    
    
    
    
    @objc required init?(coder aDecoder: NSCoder)
    {
        SearchValue = aDecoder.decodeObject(forKey: "SearchValue") as? String
        
    }
    
    @objc  func encode(with aCoder: NSCoder)
    {
        
        if SearchValue != nil{
            aCoder.encode(SearchValue, forKey: "SearchValue")
        }
        
    }
}
