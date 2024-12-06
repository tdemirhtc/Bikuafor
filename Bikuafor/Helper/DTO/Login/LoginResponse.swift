//
//  LoginResponse.swift
//  Bikuafor
//
//  Created by Hatice Taşdemir on 27.11.2024.
//

import Foundation
import ObjectMapper

@objcMembers
class LoginResponse : BaseModel{
    
    var Id : Int?
    var Username : String?
    var LoginToken : String?
    var CompanyName : String?
    var Name : String?
    var Surname : String?
    var ImageUrl : String?
    var LoginLang : Int?
    var UserType : Int?
    var SubId : Int?
    var SelectedSalonId : Int?
    var IsSalonManager : Int?
    
    class func newInstance(map: Map) -> Mappable?{
        return LoginResponse()
    }
    required init?(map: Map){super.init(map: map)}
    override init(){super.init()}

    override func mapping(map: Map)
    {
        Id <- map["Id"]
        Username <- map["Username"]
        Name <- map["Name"]
        Surname <- map["Surname"]
        LoginToken <- map["LoginToken"]
        CompanyName <- map["CompanyName"]
        ImageUrl <- map["ImageUrl"]
        SubId <- map["SubId"]
        LoginLang <- map["LoginLang"]
        UserType <- map["UserType"]
        SelectedSalonId <- map["SelectedSalonId"]
        IsSalonManager <- map["IsSalonManager"]
       
    }
    @objc required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        Id = aDecoder.decodeObject(forKey: "Id") as? Int
        Username = aDecoder.decodeObject(forKey: "Username") as? String
        Name = aDecoder.decodeObject(forKey: "Name") as? String
        Surname = aDecoder.decodeObject(forKey: "Surname") as? String
        LoginToken = aDecoder.decodeObject(forKey: "LoginToken") as? String
        CompanyName = aDecoder.decodeObject(forKey: "CompanyName") as? String
        ImageUrl = aDecoder.decodeObject(forKey: "ImageUrl") as? String
        SubId = aDecoder.decodeObject(forKey: "SubId") as? Int
        UserType = aDecoder.decodeObject(forKey: "UserType") as? Int
        LoginLang = aDecoder.decodeObject(forKey: "LoginLang") as? Int
        SelectedSalonId = aDecoder.decodeObject(forKey: "SelectedSalonId") as? Int
        IsSalonManager = aDecoder.decodeObject(forKey: "IsSalonManager") as? Int
        
    }
    
    @objc override func encode(with aCoder: NSCoder)
    {
        if Id != nil{
            aCoder.encode(Id, forKey: "Id")
        }
        if Username != nil{
            aCoder.encode(Username, forKey: "Username")
        }
        if Name != nil{
            aCoder.encode(Name, forKey: "Name")
        }
        if Surname != nil{
            aCoder.encode(Surname, forKey: "Surname")
        }
        if LoginToken != nil{
            aCoder.encode(LoginToken, forKey: "LoginToken")
        }
        if CompanyName != nil{
            aCoder.encode(CompanyName, forKey: "CompanyName")
        }
        if ImageUrl != nil{
            aCoder.encode(ImageUrl, forKey: "ImageUrl")
        }
        if SubId != nil{
            aCoder.encode(SubId, forKey: "SubId")
        }
        if LoginLang != nil{
            aCoder.encode(LoginLang, forKey: "LoginLang")
        }
        if UserType != nil{
            aCoder.encode(UserType, forKey: "UserType")
        }
        if SelectedSalonId != nil{
            aCoder.encode(SelectedSalonId, forKey: "SelectedSalonId")
        }
        if IsSalonManager != nil{
            aCoder.encode(IsSalonManager, forKey: "IsSalonManager")
        }
    }
}
