//
//  SingleInputCell.swift
//  KYC
//
//  Created by Calebe Emerik  | Stone on 04/04/18.
//  Copyright © 2018 br.com.buy4.kyc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SingleInputCell: UICollectionViewCell {

	@IBOutlet private var titleLabel: UILabel!
	@IBOutlet private var fieldContainer: UIView!
	@IBOutlet private var textField: UITextField!
	
    private let disposeBag = DisposeBag()
    
	weak var footer: NavigationFooterView!
    weak var viewModel: SingleInputCellViewModel! {
        didSet {
            configUI()
        }
    }
    
	override func awakeFromNib() {
		super.awakeFromNib()
        
		roundContainer()
	}
    
    private func configUI() {
        setOutlets(for: viewModel.model)
        setTextObservable()
    }
    
    private func setOutlets(for model: SingleInputModel) {
        DispatchQueue.main.async {
            self.titleLabel.text = model.title
            self.textField.placeholder = model.placeholder
            self.textField.keyboardType = model.keyboard.type
            self.textField.returnKeyType = model.keyboard.button
            self.textField.autocapitalizationType = model.keyboard.capitalization
            self.textField.autocorrectionType = model.keyboard.correction
            self.textField.spellCheckingType = model.keyboard.spellChecking
        }
    }
	
	private func roundContainer() {
		fieldContainer.layer.cornerRadius = 3
		fieldContainer.clipsToBounds = true
	}
    
    private func setTextObservable() {
        textField.rx.text.orEmpty
            .subscribe(onNext: { [weak self] text in
                self?.shouldEnableNextButton(for: text)
            })
            .disposed(by: disposeBag)
    }
    
    private func shouldEnableNextButton(for text: String) {
        viewModel.shouldEnableNextButton(for: text)
            .bind(to: footer.nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}
