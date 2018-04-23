//
//  CNPJValidator.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerik  | Stone on 23/04/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

final class CNPJValidator {
    
    private let pattern: String
    
    init(pattern: String) {
        self.pattern = pattern
    }
    
    init() {
        pattern = "^(([0-9]{2}.[0-9]{3}.[0-9]{3}/[0-9]{4}-[0-9]{2})|([0-9]{14}))$"
    }
    
    func validate(cnpj: String) -> Bool {
        
        guard !cnpj.isEmpty else {
            return false
        }
        
        guard validate(cnpj, with: pattern) else {
            return false
        }
        
        let stringNumbers = getOnlyStringNumbers(cnpj: cnpj)
        
        guard !blackList.contains(stringNumbers) else {
            return false
        }
        
        let numbers = getCnpjNumbers(cnpj: stringNumbers)
        
        let isValid = validateCnpj(numbers)
        
        return isValid
    }
    
    private var blackList: [String] {
        return [
            "00000000000000",
            "11111111111111",
            "22222222222222",
            "33333333333333",
            "44444444444444",
            "55555555555555",
            "66666666666666",
            "77777777777777",
            "88888888888888",
            "99999999999999",
        ]
    }
    
    private func getOnlyStringNumbers(cnpj: String) -> String {
        let pattern = "[.-/]"
        let stringNumbers = cnpj.replacingOccurrences(of: pattern, with: "", options: .regularExpression, range: nil)
        return stringNumbers
    }
    
    private func getCnpjNumbers(cnpj: String) -> [Int] {
        return cnpj.compactMap { Int(String($0)) }
    }
    
    private func validateCnpj(_ numbers: [Int]) -> Bool {
        guard numbers.count == 14 else { return false }
        let digits = Array(numbers[0..<12])
        let firstDigit = checkDigit(for: digits, upperBound: 9, lowerBound: 2, mod: 11)
        let secondDigit = checkDigit(for: digits + [firstDigit], upperBound: 9, lowerBound: 2, mod: 11)
        
        return firstDigit == numbers[12] && secondDigit == numbers[13]
    }
    
    private func checkDigit(for digits: [Int], upperBound: Int, lowerBound: Int, mod: Int, secondMod: Int = 10) -> Int {
        
        guard lowerBound < upperBound else {
            preconditionFailure("Lower bound is greater than upper bound.")
        }
        
        let factors = Array((lowerBound...upperBound).reversed())
        
        let multiplied = digits.reversed().enumerated().map {
            return $0.element * factors[$0.offset % factors.count]
        }
        
        let sum = multiplied.reduce(0, +)
        
        return (sum % mod) % secondMod
    }
    
    private func validate(_ text: String, with pattern: String) -> Bool {
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: text.count)
        let numberOfMatches = regex?.numberOfMatches(in: text, options: [], range: range) ?? 0
        return numberOfMatches > 0
    }
}
