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
	
	weak var footer: NavigationFooterView! {
		didSet {
			setSpaceBottom()
		}
	}
	
	weak var viewModel: CellViewModelProtocol! {
		didSet {
			configUI()
		}
	}
    
    override func awakeFromNib() {
        super.awakeFromNib()
		
        setupTableView()
    }
	
	private func configUI() {
		
	}
	
	private func setSpaceBottom() {
		let footer = UIView()
		footer.frame.size.height = 20
		tableView.tableFooterView = footer
	}
    
    private func setupTableView() {
		tableView.register(cellNib: SingleChoiceTitleCell.self)
		tableView.register(cellNib: SingleChoiceAnswerCell.self)
		tableView.dataSource = dataSource
		tableView.delegate = delegate
		tableView.rowHeight = 80
    }
}
