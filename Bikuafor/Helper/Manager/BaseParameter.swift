//
//  BaseParameter.swift
//  Bikuafor
//
//  Created by Hatice Taşdemir on 27.11.2024.
//

import Foundation
import Foundation

public class BaseParameter: NSObject {
    

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    
  }


    public required override init() {
        super.init()
    }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func toDictionary() -> [String: Any] {
    let dictionary: [String: Any] = [:]
    //if let value = applicationId { dictionary[SerializationKeys.applicationId] = value }
    return dictionary
  }
    
    func propertyNames() -> [String] {
        return Mirror(reflecting: self).children.compactMap { $0.label }
    }
    
    func isContainsProperty(property: String) -> Bool {
        return propertyNames().contains(property)
    }

}
