//
//  KYCDelegate.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerik  | Stone on 20/04/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import UIKit

final class KYCDelegate: NSObject {
    
    var footer: NavigationFooterView!
    var model: QuestionsDisplay!
}

extension KYCDelegate: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let viewModel = model.viewModels[indexPath.row]
        
        switch viewModel.questionType {
        case .singleInput:
            let cell = cell as? SingleInputCell
            cell?.footer = footer
            cell?.viewModel = viewModel as! SingleInputCellViewModel
            cell?.updateAnswer()
        case .singleChoice:
            let cell = cell as? SingleChoiceCell
            cell?.footer = footer
            cell?.viewModel = viewModel as! SingleChoiceCellViewModel
            cell?.updateAnswer()
        }
    }
}
