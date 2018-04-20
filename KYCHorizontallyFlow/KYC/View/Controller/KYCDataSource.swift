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
    
    private func dequeueCell<T>(of type: T.Type, from collectionView: UICollectionView, with indexPath: IndexPath)
        -> T where T: Reusable {
            let cell: T = collectionView.dequeueReusableCell(for: indexPath)
            return cell
    }
}

extension KYCDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return model.numberOfQuestions
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let viewModel = model.viewModels[indexPath.row]
        
        switch viewModel.questionType {
        case .singleInput:
            return dequeueCell(of: SingleInputCell.self, from: collectionView, with: indexPath)
        case .singleChoice:
            return dequeueCell(of: SingleChoiceCell.self, from: collectionView, with: indexPath)
        }
    }
}
