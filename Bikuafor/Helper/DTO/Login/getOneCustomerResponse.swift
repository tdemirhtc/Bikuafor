//
//  getOneCustomerResponse.swift
//  Bikuafor
//
//  Created by Hatice Taşdemir on 4.12.2024.
//


import Foundation
import ObjectMapper

@objcMembers
class getOneCustomerResponse : BaseModel{
    
    var ImageUrl : String!
    
    class func newInstance(map: Map) -> Mappable?{
        return getOneCustomerResponse()
    }
    required init?(map: Map){super.init(map: map)}
    override init(){super.init()}

    override func mapping(map: Map)
    {
        ImageUrl <- map["ImageUrl"]
    }
    @objc required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        ImageUrl = (aDecoder.decodeObject(forKey: "ImageUrl") as? String)!
        
    }
    
    @objc override func encode(with aCoder: NSCoder)
    {
        if ImageUrl != nil{
            aCoder.encode(ImageUrl, forKey: "ImageUrl")
        }
    }
}
