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
    
    private let cpfValidator = CPFValidator()
    private let cnpjValidator = CNPJValidator()
    
    let model: SingleInputModel
    let questionType: QuestionType
    
    var answer: AnswerState = .none
    
    var displayAnswer: String = "" {
        didSet {
            updateAnswer()
        }
    }
    
    init(model: SingleInputModel) {
        self.model = model
        self.questionType = model.type
    }
    
    var shouldUseCustomKeyboard: Bool {
        return model.validationType == .birthdate
    }
    
    func shouldEnableNextButton(for text: String) -> Observable<Bool> {
        
        guard model.isMandatory else {
            return Observable.just(true)
        }
        
        if needsExtraValidation {
            let validationResult = checksExtraValidation(for: text)
            return Observable.just(validationResult)
        }
        
        let validationResult = validate(text)
        
        return Observable.just(validationResult)
    }
    
    func formatDateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
    
    private var needsExtraValidation: Bool {
        return model.validationType == .cpf || model.validationType == .cnpj
    }
    
    private func validate(_ text: String) -> Bool {
        let regex = try? NSRegularExpression(pattern: model.validation, options: [])
        let range = NSRange(location: 0, length: text.count)
        let numberOfMatches = regex?.numberOfMatches(in: text, options: [], range: range) ?? 0
        return numberOfMatches > 0
    }
    
    private func checksExtraValidation(for text: String) -> Bool {
        switch model.validationType {
        case .cpf:
            return cpfValidator.validate(cpf: text)
        case .cnpj:
            return cnpjValidator.validate(cnpj: text)
        default:
            fatalError("NUNCA DEVERIA CAIR AQUI!")
        }
    }
    
    private func updateAnswer() {
        let answer = QuestionAnswer(questionId: model.questionId,
                                    answerId: model.answerId,
                                    question: model.title,
                                    answer: displayAnswer
        )
        self.answer = .answered(with: answer)
    }
}
