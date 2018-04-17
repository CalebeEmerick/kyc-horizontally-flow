//
//  QuestionType.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerik  | Stone on 17/04/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

enum QuestionType {
    
    case singleInput
    case singleChoice
    
    init(json: JSON) throws {
        
        let typeString: String = try getValue(for: "type", from: json)
        
        switch typeString {
        case "single-input":
            self = .singleInput
        case "single-choice":
            self = .singleChoice
        default:
            fatalError("NUNCA ENTRAR AQUI!")
        }
    }
    
    static func asd() {
        
    }
}
