//
//  KYCDataSource.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerik  | Stone on 17/04/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import UIKit

final class KYCDataSource: NSObject {
    
    var model: QuestionsDisplay!
    var viewModel: KYCViewModel!
}

extension KYCDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return model.numberOfQuestions
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let question = model.questions[indexPath.row]
        
        switch question.type {
        case .singleInput:
            let cell: SingleInputCell = collectionView.dequeueReusableCell(for: indexPath)
            
            return cell
        case .singleChoice:
            let cell: SingleChoiceCell = collectionView.dequeueReusableCell(for: indexPath)
            
            return cell
        }
    }
}
