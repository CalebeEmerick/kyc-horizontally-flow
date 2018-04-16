//
//  KeyboardManager.swift
//  Flip
//
//  Created by Calebe Emerick on 29/08/17.
//  Copyright © 2017 Buy4. All rights reserved.
//
import Foundation

public final class KeyboardManager {
	
	weak var delegate: KeyboardDelegate?
	
	public func startObserving() {
		let notification = NotificationCenter.default
		notification.addObserver(self, selector: #selector(keyboardWillAppear), name: .UIKeyboardWillShow, object: nil)
		notification.addObserver(self, selector: #selector(keyboardWillDisappear), name: .UIKeyboardWillHide, object: nil)
	}
	
	public func stopObserving() {
		NotificationCenter.default.removeObserver(self)
	}
	
	@objc private func keyboardWillAppear(notification: Notification) {
		if let model = KeyboardModel(json: notification.userInfo) {
			delegate?.keyboardOpenned(keyboard: model)
		}
	}
	
	@objc private func keyboardWillDisappear(notification: Notification) {
		if let model = KeyboardModel(json: notification.userInfo) {
			delegate?.keyboardClosed(keyboard: model)
		}
	}
}
