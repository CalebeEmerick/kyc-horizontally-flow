//
//  QuestionsDisplay.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerik  | Stone on 17/04/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

final class QuestionsDisplay {
    
    let numberOfQuestions: Int
    let viewModels: [CellViewModelProtocol]
    
    init(response: QuestionsResponse) {
        
        var viewModels: [CellViewModelProtocol] = []
            
        for question in response.questions {
            switch question.type {
            case .singleInput:
                let model = SingleInputModel(question: question)
                let viewModel = SingleInputCellViewModel(model: model)
                viewModels.append(viewModel)
            case .singleChoice:
                let model = SingleChoiceModel(question: question)
                let viewModel = SingleChoiceCellViewModel(model: model)
                viewModels.append(viewModel)
            }
        }
        
        self.viewModels = viewModels
        self.numberOfQuestions = viewModels.count
    }
}
