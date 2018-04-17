//
//  KYCViewModel.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerik  | Stone on 17/04/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation
import RxSwift

final class KYCViewModel {
    
    private let service = QuestionsService()
    private let singleInputViewModel = SingleInputCellViewModel()
    private let singleChoiceViewModel = SingleChoiceCellViewModel()
    
    func getQuestions() -> Observable<QuestionsDisplay> {
        
        let questionsDisplay = service.getQuestions()
            .map({ [unowned self] response -> QuestionsDisplay in
                self.parseResponseToQuestionsDisplay(response)
            })
        
        return questionsDisplay
    }
    
    private func parseResponseToQuestionsDisplay(_ response: QuestionsResponse) -> QuestionsDisplay {
        var questions: [QuestionTypeProtocol] = []
        
        for question in response.questions {
            switch question.type {
            case .singleInput:
                let model = SingleInputModel(question: question)
                questions.append(model)
            case .singleChoice:
                let model = SingleChoiceModel(question: question)
                questions.append(model)
            }
        }
        
        return QuestionsDisplay(questions: questions)
    }
    
    private func getCellViewModel(from questionsDisplay: QuestionsDisplay) {
        // PENSAR SE DEVO FAZER O VIEWMODEL DA CELL GENERICO E DEPOIS FAZER O DOWNCASTING
        // OU SE DEVO RECEBER O MODELO NA CELL E DEPOIS PASSAR PRO VIEWMODEL
    }
}
