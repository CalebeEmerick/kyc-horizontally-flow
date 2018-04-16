//
//  QuestionType.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerik  | Stone on 16/04/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

enum QuestionType: JSONDecodable {
    
    case singleInput(SingleInput)
    case singleChoice(SingleChoice)
    
    init(json: JSON) throws {
        
        let typeString: String = try getValue(for: "type", from: json)
        
        switch typeString {
        case "single-input":
            let model: SingleInput =
                try getModel(for: "single-input-meta", from: json)
            self = .singleInput(model)
        case "single-choice":
            let model: SingleChoice =
                try getModel(for: "single-choice-meta", from: json)
            self = .singleChoice(model)
        default:
            fatalError("NUNCA ENTRAR AQUI!")
        }
    }
}
