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
    @IBOutlet private var footerView: UIView!
    @IBOutlet private var footerBottomConstraint: NSLayoutConstraint!
    
    private let disposeBag = DisposeBag()
    private let dataSource = KYCDataSource()
    private let viewModel = KYCViewModel()
    private let keyboardManager = KeyboardManager()
    private let footer = NavigationFooterView.makeXib()
}

extension KYCController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyboardManager.delegate = self
        setupCollectionView()
        setCollectionViewLayout()
        setFooterConstraints()
        getQuestions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        keyboardManager.startObserving()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        keyboardManager.stopObserving()
    }
}

extension KYCController {
    
    private func getQuestions() {
        viewModel.getQuestions()
            .subscribe(onNext: { [weak self] model in
                self?.updateDataSource(for: model)
            })
            .disposed(by: disposeBag)
    }
    
    private func updateDataSource(for model: QuestionsDisplay) {
        dataSource.model = model
        dataSource.footer = footer
        dataSource.viewModel = viewModel
        collectionView.reloadData()
    }
    
    private func setupCollectionView() {
        collectionView.register(cellNib: SingleInputCell.self)
        collectionView.register(cellNib: SingleChoiceCell.self)
        collectionView.dataSource = dataSource
        dataSource.viewModel = viewModel
    }
    
    private func setCollectionViewLayout() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemSize = CGSize(width: view.bounds.width, height: collectionView.bounds.height)
        layout.itemSize = itemSize
    }
    
    private func setFooterConstraints() {
        footerView.addSubview(footer)
        footer.translatesAutoresizingMaskIntoConstraints = false
        footer.leadingAnchor.constraint(equalTo: footerView.leadingAnchor)
            .isActive = true
        footer.trailingAnchor.constraint(equalTo: footerView.trailingAnchor)
            .isActive = true
        footer.bottomAnchor.constraint(equalTo: footerView.bottomAnchor)
            .isActive = true
        footer.topAnchor.constraint(equalTo: footerView.topAnchor)
            .isActive = true
    }
}

extension KYCController: KeyboardDelegate {
    
    func keyboardOpenned(keyboard model: KeyboardModel) {
        moveFooter(to: model.height, with: model.durationTime)
    }
    
    func keyboardClosed(keyboard model: KeyboardModel) {
        moveFooter(to: 0, with: model.durationTime)
    }
    
    private func moveFooter(to position: CGFloat, with duration: TimeInterval) {
        footerBottomConstraint.constant = position
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
}
