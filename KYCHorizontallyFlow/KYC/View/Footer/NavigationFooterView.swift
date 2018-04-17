//
//  NavigationFooterView.swift
//  KYC
//
//  Created by Calebe Emerik  | Stone on 04/04/18.
//  Copyright © 2018 br.com.buy4.kyc. All rights reserved.
//

import UIKit

final class NavigationFooterView: UIView {
    
    @IBOutlet private var previousButton: UIButton!
    @IBOutlet private var nextButton: UIButton!
    
	@IBAction private func previousAction() {
		didTapPreviousAction?()
	}
	
	@IBAction private func nextAction() {
		didTapNextAction?()
	}
	
	var didTapPreviousAction: (() -> Void)?
	var didTapNextAction: (() -> Void)?
	
	override func awakeFromNib() {
        super.awakeFromNib()
        
        makeTopBorder()
        setPreviousButtonBorder()
        round(previousButton)
        round(nextButton)
    }
    
    func enableNextButton() {
        setNextButtonEnabled(to: true)
    }
    
    func disableNextButton() {
        setNextButtonEnabled(to: false)
    }
    
    func showPreviousButton() {
        setPreviousButtonAlpha(to: 1)
    }
    
    func hidePreviousButton() {
        setPreviousButtonAlpha(to: 0)
    }
    
    private func setNextButtonEnabled(to state: Bool) {
        nextButton.isEnabled = state
    }
    
    private func setPreviousButtonAlpha(to alpha: CGFloat) {
        UIView.animate(withDuration: 0.25) {
            self.previousButton.alpha = alpha
        }
    }
    
    private func round(_ button: UIButton) {
        button.layer.cornerRadius = 3
        button.clipsToBounds = true
    }
    
    private func makeTopBorder() {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0.5)
        border.backgroundColor = Color(hexString: "ddd").cgColor
        layer.addSublayer(border)
    }
    
    private func setPreviousButtonBorder() {
        previousButton.layer.borderWidth = 0.5
        previousButton.layer.borderColor = Color(hexString: "#053A1D").cgColor
    }
}
