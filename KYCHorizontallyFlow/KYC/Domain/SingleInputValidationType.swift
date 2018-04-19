//
//  SingleInputValidationType.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerik  | Stone on 16/04/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

enum SingleInputValidationType {
    
    case name
    case cpf
    case birthdate
    case other
    
    init(value: String) {
        switch value {
        case "name":
            self = .name
        case "cpf":
            self = .cpf
        case "birthdate":
            self = .birthdate
        case "other":
            self = .other
        default:
            fatalError("NUNCA DEVERIA CAIR AQUI!")
        }
    }
}
