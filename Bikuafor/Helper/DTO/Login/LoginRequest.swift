//
//  LoginRequest.swift
//  Bikuafor
//
//  Created by Hatice Taşdemir on 27.11.2024.
//


import Foundation
import ObjectMapper

@objcMembers
class LoginRequest : BaseParameter{
    
    var Username : String?
    var Password : String?
    var DeviceToken : String?
    var LoginLang : Int?
    var UserType : Int?
    var Lat : String?
    var Lng : String?
    
    
    
    
    public required init() {
        super.init()
    }
    
    init(fromDictionary dictionary: [String:Any]){
        
        Username  = dictionary["Username"] as? String
        Password  = dictionary["Password"] as? String
        DeviceToken  = dictionary["DeviceToken"] as? String
        LoginLang  = dictionary["LoginLang"] as? Int
        UserType  = dictionary["UserType"] as? Int
        Lat  = dictionary["Lat"] as? String
        Lng  = dictionary["Lng"] as? String
    }
    
    override func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        
        if Username != nil{
            dictionary["Username"] = Username
        }
        if Password != nil{
            dictionary["Password"] = Password
        }
        if DeviceToken != nil{
            dictionary["DeviceToken"] = DeviceToken
        }
        if LoginLang != nil{
            dictionary["LoginLang"] = LoginLang
        }
        if UserType != nil{
            dictionary["UserType"] = UserType
        }
        if Lat != nil{
            dictionary["Lat"] = Lat
        }
        if Lng != nil{
            dictionary["Lng"] = Lng
        }
        
       
        return dictionary
    }

    
    
    @objc required init?(coder aDecoder: NSCoder)
    {
        
        
        Username = aDecoder.decodeObject(forKey: "Username") as? String
        Password = aDecoder.decodeObject(forKey: "Password") as? String
        DeviceToken = aDecoder.decodeObject(forKey: "DeviceToken") as? String
        LoginLang = aDecoder.decodeObject(forKey: "LoginLang") as? Int
        UserType = aDecoder.decodeObject(forKey: "UserType") as? Int
        Lat = aDecoder.decodeObject(forKey: "Lat") as? String
        Lng = aDecoder.decodeObject(forKey: "Lng") as? String
        
       
    }
    
    @objc  func encode(with aCoder: NSCoder)
    {
       
        if Username != nil{
            aCoder.encode(Username, forKey: "Username")
        }
        if Password != nil{
            aCoder.encode(Password, forKey: "Password")
        }
        if DeviceToken != nil{
            aCoder.encode(DeviceToken, forKey: "DeviceToken")
        }
        if LoginLang != nil{
            aCoder.encode(LoginLang, forKey: "LoginLang")
        }
        if UserType != nil{
            aCoder.encode(UserType, forKey: "UserType")
        }
        if Lat != nil{
            aCoder.encode(Lat, forKey: "Lat")
        }
        if Lng != nil{
            aCoder.encode(Lng, forKey: "Lng")
        }
        
    }
    
}
