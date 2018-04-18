//
//  SingleInputCellViewModel.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerik  | Stone on 17/04/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation
import RxSwift

final class SingleInputCellViewModel: CellViewModelProtocol {
    
    let model: SingleInputModel
    let questionType: QuestionType
    
    init(model: SingleInputModel) {
        self.model = model
        self.questionType = model.type
    }
    
    func shouldEnableNextButton(for text: String) -> Observable<Bool> {
        
        guard model.isMandatory else {
            return Observable.just(true)
        }
        
        let validationResult = validate(text)
        
        return Observable.just(validationResult)
    }
    
    private func validate(_ text: String) -> Bool {
        let regex = try? NSRegularExpression(pattern: model.validation, options: [])
        let range = NSRange(location: 0, length: text.count)
        let numberOfMatches = regex?.numberOfMatches(in: text, options: [], range: range) ?? 0
        return numberOfMatches > 0
    }
}
