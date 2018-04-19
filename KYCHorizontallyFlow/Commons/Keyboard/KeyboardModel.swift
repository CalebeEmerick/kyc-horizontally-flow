//
//  KeyboardModel.swift
//  Flip
//
//  Created by Calebe Emerick on 29/08/17.
//  Copyright © 2017 Buy4. All rights reserved.
//
import UIKit

public struct KeyboardModel {
	
	public let animationDuration: CGFloat
	public let animationCurve: CGFloat
	public let isLocal: Bool
	public let frameEnd: CGRect
	public let frameBegin: CGRect
	
	public var height: CGFloat {
		return frameEnd.height
	}
	
	public var durationTime: TimeInterval {
		return TimeInterval(animationDuration)
	}
	
	public init?(json: [AnyHashable: Any]?) {
		guard
			let animationDuration = json?[UIKeyboardAnimationDurationUserInfoKey] as? CGFloat,
			let animationCurve = json?[UIKeyboardAnimationCurveUserInfoKey] as? CGFloat,
			let isLocal = json?[UIKeyboardIsLocalUserInfoKey] as? Bool,
			let frameEnd = json?[UIKeyboardFrameEndUserInfoKey] as? CGRect,
			let frameBegin = json?[UIKeyboardFrameBeginUserInfoKey] as? CGRect
			else { return nil }
		
		self.animationDuration = animationDuration
		self.animationCurve = animationCurve
		self.isLocal = isLocal
		self.frameEnd = frameEnd
		self.frameBegin = frameBegin
	}
}
