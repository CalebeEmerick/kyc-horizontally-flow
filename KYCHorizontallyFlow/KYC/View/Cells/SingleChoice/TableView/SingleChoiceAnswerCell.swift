//
//  SingleChoiceAnswerCell.swift
//  KYC
//
//  Created by Calebe Emerik  | Stone on 06/04/18.
//  Copyright © 2018 br.com.buy4.kyc. All rights reserved.
//

import UIKit

final class SingleChoiceAnswerCell: UITableViewCell {
    
    @IBOutlet private var answerContainer: UIView!
    @IBOutlet private var answerLabel: UILabel!
    
    var answer: Answer! {
        didSet {
            updateUI()
        }
    }
    
    override var isSelected: Bool {
        get {
            return super.isSelected
        }
        set {
            super.setSelected(newValue, animated: true)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setAnswerContainerBorder()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            changeBackground(to: Color(hexString: "#12AA4B").color)
            changeAnswerTextColor(to: .white)
        }
        else {
            changeAnswerTextColor(to: Color(hexString: "#383838").color)
            changeBackground(to: .white)
        }
    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            self.answerLabel.text = self.answer.description
        }
    }
    
    private func changeBackground(to color: UIColor) {
        UIView.animate(withDuration: 0.3) {
            self.answerContainer.backgroundColor = color
        }
    }
    
    private func changeAnswerTextColor(to color: UIColor) {
        answerLabel.textColor = color
    }
    
    private func setAnswerContainerBorder() {
        answerContainer.layer.borderWidth = 0.5
        answerContainer.layer.borderColor = Color(hexString: "#ddd").cgColor
        answerContainer.layer.cornerRadius = 3
        answerContainer.clipsToBounds = true
    }
}
