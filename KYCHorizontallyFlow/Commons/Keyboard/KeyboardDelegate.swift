//
//  KeyboardDelegate.swift
//  Flip
//
//  Created by Calebe Emerick on 06/09/17.
//  Copyright © 2017 Buy4. All rights reserved.
//

import Foundation

protocol KeyboardDelegate: class {
	
	func keyboardOpenned(keyboard model: KeyboardModel)
	func keyboardClosed(keyboard model: KeyboardModel)
}
