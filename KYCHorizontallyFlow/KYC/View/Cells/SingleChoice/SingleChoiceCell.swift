//
//  SingleChoiceCell.swift
//  KYC
//
//  Created by Calebe Emerik  | Stone on 06/04/18.
//  Copyright © 2018 br.com.buy4.kyc. All rights reserved.
//

import UIKit

final class SingleChoiceCell: UICollectionViewCell {
    
    @IBOutlet private var tableView: UITableView!
	
	private let dataSource = SingleChoiceDataSource()
	private let delegate = SingleChoiceDelegate()
    private let header = SingleChoiceHeader.makeXib()
	
	weak var footer: NavigationFooterView! {
		didSet {
			setSpaceBottom()
		}
	}
	
	weak var viewModel: SingleChoiceCellViewModel! {
		didSet {
			configUI()
		}
	}
    
    override func awakeFromNib() {
        super.awakeFromNib()
		
        setupTableView()
    }
	
	private func configUI() {
		dataSource.answers = viewModel.model.answers
        setupDelegate()
        tableView.reloadData()
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
    }
}
