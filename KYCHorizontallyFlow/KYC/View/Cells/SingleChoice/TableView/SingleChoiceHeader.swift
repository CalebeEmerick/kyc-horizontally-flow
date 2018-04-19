//
//  SingleChoiceHeader.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerik  | Stone on 19/04/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import UIKit

final class SingleChoiceHeader: UIView {
    
    @IBOutlet private var titleLabel: UILabel!
    
    var title: String! {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            self.titleLabel.text = self.title
        }
    }
}
