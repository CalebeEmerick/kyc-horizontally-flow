//
//  JSON.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerik  | Stone on 16/04/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]

protocol JSONDecodable {
    init(json: JSON) throws
}

enum JSONDecodableError: Error {
    case invalidKey(String)
}

func getValue<T>(for key: String, from json: JSON) throws -> T {
    
    guard let someValue = json[key] as? T else {
        throw JSONDecodableError.invalidKey(key)
    }
    
    return someValue
}

func getList<T>(for key: String, from json: JSON) throws
    -> [T] where T: JSONDecodable {
        
        let jsonList: [JSON] = try getValue(for: key, from: json)
        let objectList = try jsonList.compactMap { try T(json: $0) }
        
        return objectList
}

func getModel<T>(for key: String, from json: JSON) throws
    -> T where T: JSONDecodable {
        
        let value: JSON = try getValue(for: key, from: json)
        let model = try T(json: value)
        
        return model
}
