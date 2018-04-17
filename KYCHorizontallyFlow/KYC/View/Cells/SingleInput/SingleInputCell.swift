//
//  SingleInputCell.swift
//  KYC
//
//  Created by Calebe Emerik  | Stone on 04/04/18.
//  Copyright © 2018 br.com.buy4.kyc. All rights reserved.
//

import UIKit

final class SingleInputCell: UICollectionViewCell {

	@IBOutlet private var titleLabel: UILabel!
	@IBOutlet private var fieldContainer: UIView!
	@IBOutlet private var textField: UITextField!
	
	@IBAction private func textFieldDidChange(_ textField: UITextField) {
		guard let text = textField.text else { return }
		setNextButtonTo(state: text.isEmpty)
	}
	
	weak var footer: NavigationFooterView?
	
//    weak var model: SingleAnswerModel? {
//        didSet {
//            updateUI()
//        }
//    }
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		roundContainer()
	}
	
//    private func updateUI() {
//        guard let model = model else { return }
//        setOutlets(for: model)
//    }
	
//    private func setOutlets(for model: SingleAnswerModel) {
//        DispatchQueue.main.async {
//            self.titleLabel.text = model.title
//            self.textField.placeholder = model.placeholder
//        }
//    }
	
	private func roundContainer() {
		fieldContainer.layer.cornerRadius = 3
		fieldContainer.clipsToBounds = true
	}
	
	private func setNextButtonTo(state: Bool) {
		if !state {
			footer?.enableNextButton()
		}
		else {
			footer?.disableNextButton()
		}
	}
}
