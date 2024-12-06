//
//  StaticVariables.swift
//  Bikuafor
//
//  Created by Hatice Taşdemir on 27.11.2024.
//

import Foundation
import UIKit

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

open class StaticVariables: NSObject {
    
    static var serviceURL : String  = "https://api.bikuafor.net"
    //static var serviceURL : String  = "https://fastgreenapple70.conveyor.cloud"
    static let publicToken: String = "0f422e864dfbe3cdbb57c3edd9c0653c15219de7"
  static var loginToken: String = "0f422e864dfbe3cdbb57c3edd9c0653c15219de7"
    
    static var imageArray = [Data]()
    static var PinkColor = "#DF1D68"
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.bikuafor.net"
        //components.host = "192.168.1.69:45455"
        //components.port = 45455
        components.path = "/" + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }

        return url
    }
}
