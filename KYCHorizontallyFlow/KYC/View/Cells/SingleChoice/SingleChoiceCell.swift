//
//  SingleChoiceCell.swift
//  KYC
//
//  Created by Calebe Emerik  | Stone on 06/04/18.
//  Copyright © 2018 br.com.buy4.kyc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SingleChoiceCell: UICollectionViewCell {
    
    @IBOutlet private var tableView: UITableView!
	
    private let disposeBag = DisposeBag()
	private let dataSource = SingleChoiceDataSource()
	private let delegate = SingleChoiceDelegate()
    private let header = SingleChoiceHeader.makeXib()
    
	var footer: NavigationFooterView! {
		didSet {
            footer.disableNextButton()
			setSpaceBottom()
		}
	}
	
	var viewModel: SingleChoiceCellViewModel! {
		didSet {
			configUI()
		}
	}
    
    override func awakeFromNib() {
        super.awakeFromNib()
		
        setupTableView()
    }
	
    func updateAnswer() {
        switch viewModel.answer {
        case let .answered(with: answer):
            selectRowFor(selected: answer)
            footer.enableNextButton()
        case .none:
            deselectSelectedRow()
            footer.disableNextButton()
        }
    }
    
    private func selectRowFor(selected answer: QuestionAnswer) {
        let indexPath = getIndexPathFor(selected: answer)
        tableView.selectRow(at: indexPath, animated: false, scrollPosition: .middle)
    }
    
    private func deselectSelectedRow() {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
    
    private func getIndexPathFor(selected questionAnswer: QuestionAnswer) -> IndexPath {
        var selectedIndex = 0
        
        for (index, answer) in viewModel.model.answers.enumerated()
            where answer.id == questionAnswer.answerId {
                selectedIndex = index
                break
        }
        
        return IndexPath(row: selectedIndex, section: 0)
    }
    
	private func configUI() {
		dataSource.answers = viewModel.model.answers
        setupDelegate()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.tableView.reloadData()
        }
	}
	
	private func setSpaceBottom() {
		let footer = UIView()
		footer.frame.size.height = 20
		tableView.tableFooterView = footer
	}
    
    private func setupTableView() {
		tableView.register(cellNib: SingleChoiceAnswerCell.self)
		tableView.dataSource = dataSource
		tableView.rowHeight = 80
    }
    
    private func setupDelegate() {
        header.title = viewModel.model.title
        tableView.delegate = delegate
        delegate.header = header
        delegate.didSelectAnswer = { [weak self] indexPath in
            self?.footer.enableNextButton()
            self?.viewModel.selectedIndexPath = indexPath
        }
    }
}
