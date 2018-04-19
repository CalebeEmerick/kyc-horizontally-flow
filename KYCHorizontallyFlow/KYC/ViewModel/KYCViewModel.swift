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
    
    func getQuestions() -> Observable<QuestionsDisplay> {
        
        let questionsDisplay = service.getQuestions()
            .map({ response in
                return QuestionsDisplay(response: response)
            })
        
        return questionsDisplay
    }
}
