//
//  MetaResponse.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerik  | Stone on 16/04/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

struct MetaResponse: JSONDecodable {
    
    let version: String
    let totalRecords: Int
    
    init(json: JSON) throws {
        self.version = try getValue(for: "version", from: json)
        self.totalRecords = try getValue(for: "total_records", from: json)
    }
}
