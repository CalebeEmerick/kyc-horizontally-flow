//
//  SingleInputValidationType.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerik  | Stone on 16/04/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

enum SingleInputValidationType {
    
    case cpf
    case cnpj
    
    init(value: String) {
        switch value {
        case "cpf":
            self = .cpf
        case "cnpj":
            self = .cnpj
        default:
            fatalError("NUNCA DEVERIA CAIR AQUI!")
        }
    }
}
