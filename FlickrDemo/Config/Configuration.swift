//
//  Configuration.swift
//  FlickrDemo
//
//  Created by ervinaydin on 01/06/2023.
//

import Foundation

enum EnvConfig: String {
    //Error types
    enum ConfigError: Error {
        case missingKey
    }
    
    case YBS_HOST
    case YBS_CLIENT_ID
    
    static func value(_ key: EnvConfig) throws -> String {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key.rawValue) as? String
        else {
            throw ConfigError.missingKey
        }
        return value
    }
}
