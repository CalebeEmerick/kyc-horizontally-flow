//
//  KeyboardSingleInput.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerik  | Stone on 17/04/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import UIKit

struct KeyboardSingleInput {
    
    private(set) var type: UIKeyboardType = .default
    private(set) var capitalization: UITextAutocapitalizationType = .none
    private(set) var correction: UITextAutocorrectionType = .no
    private(set) var spellChecking: UITextSpellCheckingType = .no
    private(set) var button: UIReturnKeyType = .done
    
    init(for type: SingleInputValidationType) {
        switch type {
        case .name:
            capitalization = .words
        case .cpf:
            self.type = .numberPad
        case .birthdate:
            capitalization = .words
        }
    }
}
