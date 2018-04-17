//
//  ViewController.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerik  | Stone on 16/04/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import UIKit
import RxSwift

final class KYCController: UIViewController {

    @IBOutlet private var collectionView: UICollectionView!
    
    private let disposeBag = DisposeBag()
    private let dataSource = KYCDataSource()
    private let viewModel = KYCViewModel()
}

extension KYCController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setCollectionViewLayout()
        
        viewModel.getQuestions()
        .subscribe(onNext: { model in
            
            
        })
        .disposed(by: disposeBag)
    }
}

extension KYCController {
    
    private func setupCollectionView() {
        collectionView.register(cellNib: SingleInputCell.self)
        collectionView.register(cellNib: SingleChoiceCell.self)
        collectionView.dataSource = dataSource
        dataSource.viewModel = viewModel
    }
    
    private func setCollectionViewLayout() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemSize = CGSize(width: view.bounds.width, height: view.bounds.height)
        layout.itemSize = itemSize
    }
}
