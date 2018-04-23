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
    private var questionModel: QuestionsDisplay!
    
    private(set) var currentIndex = 0
    
    let indexSubject: PublishSubject<Int> = PublishSubject()
    
    var hasNextItem: Bool {
        return questionModel.viewModels.indices.contains(currentIndex + 1)
    }
    
    var hasPreviousItem: Bool {
        guard currentIndex - 1 >= 0 else { return false }
        return questionModel.viewModels.indices.contains(currentIndex - 1)
    }
    
    var shouldShowPreviousButton: Bool {
        return hasPreviousItem
    }
    
    var hasMoreQuestions: Bool {
        return service.hasMoreQuestions()
    }
    
    func getCurrentIndex() -> Observable<Int> {
        return indexSubject
            .distinctUntilChanged()
            .do(onNext: { [weak self] index in
                self?.currentIndex = index
            })
    }
    
    func getQuestions() -> Observable<QuestionsDisplay> {

        let questionsDisplay = service.getQuestions()
            .map({ response in
                return QuestionsDisplay(response: response)
            })
            .do(onNext: { [weak self] model in
                self?.questionModel = model
            })
        
        return questionsDisplay
    }
    
    func getAnswers() -> [QuestionAnswer] {
        
        var answers: [QuestionAnswer] = []
        
        for question in questionModel.viewModels {
            if case let .answered(answer) = question.answer {
                answers.append(answer)
            }
        }
        
        return answers
    }
}
