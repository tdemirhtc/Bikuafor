//
//  FindClosestSalonsResponse.swift
//  Bikuafor
//
//  Created by Hatice Taşdemir on 27.11.2024.
//

import Foundation
import Foundation
import ObjectMapper

class FindClosestSalonsResponse : BaseModel {
    
    var list : [SalonList]?
    
    override func mapping(map: Map) {
        list <- map["items"]
    }
    
    class func newInstance(map: Map) -> Mappable?{
        return FindClosestSalonsResponse()
    }
    
    required init?(map: Map) {super.init(map: map)}
    override init(){super.init()}
    
    @objc required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        list = aDecoder.decodeObject(forKey: "items") as? [SalonList]
        
        
    }
}


class SalonList : BaseModel {
    
    var  Id   : Int!
    var  SalonId   : Int!
    var  DistanceStr   : String?
    var  Title : String?
    var  Latitude : String?
    var  Longitude : String?
    var  CountryCode : String?
    var  Phone : String?
    var  Address : String?
    var  Email : String?
    var  SeatCount   : Int!
    var  IsFavorite   : Int!
    var  SalonTypeIds : [Double]?
    var  Rating   : Double!
    var  Distance   : Double!
    var  ServiceEndDate   : String?
    var  BackgroundImageUrl   : String?
    var  ProfileImageUrl   : String?
    var  WorkHours : [workHours]?
    var  DT_RowId   : String?
    var  SalonTypeName   : String?
    var  CreateDate   : String?
    var AtHome : Int!
    var IsAd : Int!
    var AdId : Int!
    var AdUrl : String!
    var MediaUrl : String!
    
    override func mapping(map: Map) {
        Id <- map["Id"]
        SalonId <- map["SalonId"]
        DistanceStr <- map["DistanceStr"]
        Title <- map["Title"]
        Latitude <- map["Latitude"]
        Longitude <- map["Longitude"]
        CountryCode <- map["CountryCode"]
        Phone <- map["Phone"]
        Address <- map["Address"]
        Email <- map["Email"]
        SeatCount <- map["SeatCount"]
        IsFavorite <- map["IsFavorite"]
        SalonTypeIds <- map["SalonTypeIds"]
        Rating <- map["Rating"]
        Distance <- map["Distance"]
        ServiceEndDate <- map["ServiceEndDate"]
        BackgroundImageUrl <- map["BackgroundImageUrl"]
        ProfileImageUrl <- map["ProfileImageUrl"]
        WorkHours <- map["WorkHours"]
        DT_RowId <- map["DT_RowId"]
        CreateDate <- map["CreateDate"]
        IsAd <- map["IsAd"]
        AtHome <- map["AtHome"]
        AdId <- map["AdId"]
        AdUrl <- map["AdUrl"]
        MediaUrl <- map["MediaUrl"]
    }
    
    class func newInstance(map: Map) -> Mappable?{
        return SalonList()
    }
    
    required init?(map: Map) {super.init(map: map)}
    override init(){super.init()}
    
    @objc required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        Id = aDecoder.decodeObject(forKey: "Id") as? Int
        SalonId = aDecoder.decodeObject(forKey: "SalonId") as? Int
        DistanceStr = aDecoder.decodeObject(forKey: "DistanceStr") as? String
        Title = aDecoder.decodeObject(forKey: "Title") as? String
        Latitude = aDecoder.decodeObject(forKey: "Latitude") as? String
        Longitude = aDecoder.decodeObject(forKey: "Longitude") as? String
        CountryCode = aDecoder.decodeObject(forKey: "CountryCode") as? String
        Phone = aDecoder.decodeObject(forKey: "Phone") as? String
        Address = aDecoder.decodeObject(forKey: "Address") as? String
        Email = aDecoder.decodeObject(forKey: "Email") as? String
        SeatCount = aDecoder.decodeObject(forKey: "SeatCount") as? Int
        IsFavorite = aDecoder.decodeObject(forKey: "IsFavorite") as? Int
        SalonTypeIds = (aDecoder.decodeObject(forKey: "SalonTypeIds") as? [Double])
        Rating = aDecoder.decodeObject(forKey: "Rating") as? Double
        Distance = aDecoder.decodeObject(forKey: "Distance") as? Double
        ServiceEndDate = aDecoder.decodeObject(forKey: "ServiceEndDate") as? String
        BackgroundImageUrl = aDecoder.decodeObject(forKey: "BackgroundImageUrl") as? String
        ProfileImageUrl = aDecoder.decodeObject(forKey: "ProfileImageUrl") as? String
        WorkHours = aDecoder.decodeObject(forKey: "WorkHours") as? [workHours]
        DT_RowId = aDecoder.decodeObject(forKey: "DT_RowId") as? String
        SalonTypeName = aDecoder.decodeObject(forKey: "SalonTypeName") as? String
        CreateDate = aDecoder.decodeObject(forKey: "CreateDate") as? String
        AtHome = aDecoder.decodeObject(forKey: "AtHome") as? Int
        IsAd = aDecoder.decodeObject(forKey: "IsAd") as? Int
        AdId = aDecoder.decodeObject(forKey: "AdId") as? Int
        AdUrl = aDecoder.decodeObject(forKey: "AdUrl") as? String
        MediaUrl = aDecoder.decodeObject(forKey: "MediaUrl") as? String
    }
}


class workHours : BaseModel {
    
    var  DayOfWeek      : Int!
    var  StartHour      : Int!
    var  StartMinute    : Int!
    var  EndHour        : Int!
    var  EndMinute      : Int!
   
    required init?(map: Map){super.init(map: map)}
       override init(){super.init()}

       init(dayOfWeek: Int?, startHour: Int?, startMinute: Int?, endHour: Int?, endMinute: Int?) {
           super.init()
           self.DayOfWeek = dayOfWeek
           self.StartHour = startHour
           self.StartMinute = startMinute
           self.EndHour = endHour
           self.EndMinute = endMinute
       }

    
    override func mapping(map: Map) {
            DayOfWeek <- map["DayOfWeek"]
            StartHour <- map["StartHour"]
            StartMinute <- map["StartMinute"]
            EndHour <- map["EndHour"]
            EndMinute <- map["EndMinute"]
        }

        init(fromDictionary dictionary: [String:Any]){
            super.init()
            DayOfWeek = dictionary["DayOfWeek"] as? Int
            StartHour = dictionary["StartHour"] as? Int
            StartMinute = dictionary["StartMinute"] as? Int
            EndHour = dictionary["EndHour"] as? Int
            EndMinute = dictionary["EndMinute"] as? Int
        }

        func toDictionary() -> [String:Any]
        {
            var dictionary = [String:Any]()
            if DayOfWeek != nil{ dictionary["DayOfWeek"] = DayOfWeek }
            if StartHour != nil{ dictionary["StartHour"] = StartHour }
            if StartMinute != nil{ dictionary["StartMinute"] = StartMinute }
            if EndHour != nil{ dictionary["EndHour"] = EndHour }
            if EndMinute != nil{ dictionary["EndMinute"] = EndMinute }

            return dictionary
        }

    @objc required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
