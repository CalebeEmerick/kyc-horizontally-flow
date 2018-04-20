//
//  ViewController.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerik  | Stone on 16/04/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class KYCController: UIViewController {

    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var footerView: UIView!
    @IBOutlet private var footerBottomConstraint: NSLayoutConstraint!
    
    private let disposeBag = DisposeBag()
    private let dataSource = KYCDataSource()
    private let delegate = KYCDelegate()
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
        setScrollViewObservable()
        setPageChangeObservable()
        setFooterButtonCallbacks()
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
                self?.updateDelegate(for: model)
                self?.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    private func updateDataSource(for model: QuestionsDisplay) {
        dataSource.model = model
    }
    
    private func updateDelegate(for model: QuestionsDisplay) {
        delegate.footer = footer
        delegate.model = model
    }
    
    private func setupCollectionView() {
        collectionView.register(cellNib: SingleInputCell.self)
        collectionView.register(cellNib: SingleChoiceCell.self)
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
    }
    
    private func setCollectionViewLayout() {
        let screen = UIScreen.main.bounds
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemSize = CGSize(width: screen.width, height: screen.height - 64 - 50)
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
    
    private func updateCurrentPage() {
        let offSet = collectionView.contentOffset
        guard let indexPath = collectionView.indexPathForItem(at: offSet) else {
            return
        }
        viewModel.indexSubject
            .onNext(indexPath.row)
    }
    
    private func shouldShowPreviousButton(for index: Int) {
        let state = viewModel.shouldShowPreviousButton
        checkNeedsShowPreviousButton(for: state)
    }
    
    private func showNextQuestion() {
        if viewModel.hasNextItem {
            moveToPage(index: viewModel.currentIndex + 1)
        }
    }
    
    private func showPreviousQuestion() {
        if viewModel.hasPreviousItem {
            moveToPage(index: viewModel.currentIndex - 1)
        }
    }
    
    private func moveToPage(index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    private func checkNeedsShowPreviousButton(for state: Bool) {
        if state {
            footer.showPreviousButton()
        }
        else {
            footer.hidePreviousButton()
        }
    }
    
    private func setFooterButtonCallbacks() {
        footer.didTapPreviousButton = { [weak self] in
            self?.showPreviousQuestion()
            self?.hideKeyboard()
        }
        footer.didTapNextButton = { [weak self] in
            self?.checkNeedsShowNextPage()
            self?.hideKeyboard()
        }
    }
    
    private func hideKeyboard() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
        }
    }
    
    private func checkNeedsShowNextPage() {
        if viewModel.hasNextItem {
            showNextQuestion()
        }
        else {
            compileAnswers()
        }
    }
    
    private func compileAnswers() {
        let answers = viewModel.getAnswers()
        let controller = storyboard?.instantiateViewController(withIdentifier: "AnswersController") as! AnswersController
        controller.answers = answers
        
        DispatchQueue.main.async {
            self.show(controller, sender: nil)
        }
    }
    
    private func setScrollViewObservable() {
        collectionView.rx.didScroll
            .subscribe(onNext: { [weak self] in
                self?.updateCurrentPage()
            })
            .disposed(by: disposeBag)
    }
    
    private func setPageChangeObservable() {
        viewModel.getCurrentIndex()
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] index in
                self?.shouldShowPreviousButton(for: index)
            })
            .disposed(by: disposeBag)
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
