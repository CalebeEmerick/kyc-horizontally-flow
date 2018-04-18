//
//  SingleChoiceCellViewModel.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerik  | Stone on 17/04/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

final class SingleChoiceCellViewModel: CellViewModelProtocol {
    
    let model: SingleChoiceModel
    let questionType: QuestionType
    
    init(model: SingleChoiceModel) {
        self.model = model
        self.questionType = model.type
    }
}
