//
//  SingleChoiceDelegate.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerick on 19/04/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import UIKit

final class SingleChoiceDelegate: NSObject {
	
    var header: SingleChoiceHeader?
    var didSelectAnswer: ((IndexPath) -> Void)?
}

extension SingleChoiceDelegate: UITableViewDelegate {
	
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return header
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        didSelectAnswer?(indexPath)
    }
}
