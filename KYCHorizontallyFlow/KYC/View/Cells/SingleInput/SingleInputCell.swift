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
    
    private lazy var birthDatePicker: UIDatePicker = {
        return makeBirthDatePicker()
    }()
    
	var footer: NavigationFooterView!
    var viewModel: SingleInputCellViewModel! {
        didSet {
            configUI()
        }
    }
    
	override func awakeFromNib() {
		super.awakeFromNib()
        
        textField.delegate = self
		roundContainer()
	}
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = ""
        textField.text = ""
    }
    
    func updateAnswer() {
        switch viewModel.answer {
        case let .answered(with: answer):
            setAnswer(to: answer.answer)
            shouldEnableNextButton(for: answer.answer)
        case .none:
            setAnswer()
            shouldEnableNextButton(for: "")
        }
    }
    
    private func configUI() {
        setOutlets(for: viewModel.model)
        setTextObservable()
        checkNeedsCustomKeyboard()
    }
    
    private func setOutlets(for model: SingleInputModel) {
        titleLabel.text = model.title
        textField.placeholder = model.placeholder
        textField.keyboardType = model.keyboard.type
        textField.returnKeyType = model.keyboard.button
        textField.autocapitalizationType = model.keyboard.capitalization
        textField.autocorrectionType = model.keyboard.correction
        textField.spellCheckingType = model.keyboard.spellChecking
    }
	
	private func roundContainer() {
		fieldContainer.layer.cornerRadius = 3
		fieldContainer.clipsToBounds = true
	}
    
    private func setTextObservable() {
        
        textField.rx.controlEvent(.editingChanged)
        .subscribe(onNext: { [weak self] in
            guard let text = self?.textField.text else { return }
            self?.updateAnswer(for: text)
            self?.shouldEnableNextButton(for: text)
        })
        .disposed(by: disposeBag)
    }
    
    private func updateAnswer(for text: String) {
        viewModel.displayAnswer = text
    }
    
    private func shouldEnableNextButton(for text: String) {
        viewModel.shouldEnableNextButton(for: text)
            .bind(to: footer.nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    private func makeBirthDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker()
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let today = Date()
        let minimumDate = calendar.date(byAdding: .year, value: -120, to: today)
        let maximumDate = calendar.date(byAdding: .year, value: -18, to: today)
        datePicker.backgroundColor = Color(hexString: "fafafa").color
        datePicker.datePickerMode = .date
        datePicker.minimumDate = minimumDate
        datePicker.maximumDate = maximumDate
        return datePicker
    }
    
    private func checkNeedsCustomKeyboard() {
        if viewModel.shouldUseCustomKeyboard {
            configBirthDatePicker()
        }
        else {
            textField.inputView = nil
        }
    }
    
    private func configBirthDatePicker() {
        textField.inputView = birthDatePicker
        setBirthDatePickerObservable()
    }
    
    private func setBirthDatePickerObservable() {
        birthDatePicker.rx.date
            .skip(1)
            .subscribe(onNext: { [weak self] date in
                self?.setDateToField(date)
            })
            .disposed(by: disposeBag)
    }
    
    private func setAnswer(to text: String = "") {
        DispatchQueue.main.async {
            self.textField.text = text
        }
    }
    
    private func setDateToField(_ date: Date) {
        let dateString = viewModel.formatDateToString(date)
        textField.text = dateString
        updateAnswer(for: dateString)
        shouldEnableNextButton(for: dateString)
    }
}

extension SingleInputCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.endEditing(true)
        
        return true
    }
}
