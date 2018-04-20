//
//  CPFValidator.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerik  | Stone on 19/04/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

final class CPFValidator {
    
    private let regularExpression = NSRegularExpression()
    
    func validate(cpf: String) -> Bool {
        
        let conditions = [
            !cpf.isEmpty,
            isValidFormat(cpf: cpf),
            islogicallyValid(cpf: cpf),
            !blackList.contains(cpf)
        ]
        
        return !conditions.contains(false)
    }
    
    private var blackList: [String] {
        return [
            "00000000000",
            "11111111111",
            "22222222222",
            "33333333333",
            "44444444444",
            "55555555555",
            "66666666666",
            "77777777777",
            "88888888888",
            "99999999999",
            "12345678909"
        ]
    }
    
    private func isValidFormat(cpf: String) -> Bool {
        let pattern = "^(([0-9]{3}.[0-9]{3}.[0-9]{3}-[0-9]{2})|([0-9]{11}))$"
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: cpf.count)
        let numberOfMatches = regex?.numberOfMatches(in: cpf, options: [], range: range) ?? 0
        return numberOfMatches > 0
    }
    
    private func getOnlyStringNumbers(cpf: String) -> String {
        let pattern = "[.-]"
        let stringNumbers = cpf.replacingOccurrences(of: pattern, with: "", options: .regularExpression, range: nil)
        return stringNumbers
    }
    
    private func getCpfNumbers(cpf: String) -> [Int] {
        let stringNumbers = getOnlyStringNumbers(cpf: cpf)
        return stringNumbers.compactMap { Int(String($0)) }
    }
    
    private func islogicallyValid(cpf: String) -> Bool {
        let numbers = getCpfNumbers(cpf: cpf)
        guard numbers.count == 11 else { return false }
        
        let firstBlock = getSum(for: numbers, maxPosition: 8, maxMultiplier: 10)
        let secondBlock = getSum(for: numbers, maxPosition: 9, maxMultiplier: 11)
        let dv1 = firstBlock > 9 ? 0 : firstBlock
        let dv2 = secondBlock > 9 ? 0 : secondBlock
        
        return dv1 == numbers[9] && dv2 == numbers[10]
    }
    
    private func getSum(for numbers: [Int], maxPosition: Int, maxMultiplier: Int) -> Int {
        var multiplier = maxMultiplier
        var result = 0
        
        for index in 0 ... maxPosition {
            let partialResult = numbers[index] * multiplier
            result += partialResult
            multiplier -= 1
        }
        
        return 11 - result % 11
    }
}
