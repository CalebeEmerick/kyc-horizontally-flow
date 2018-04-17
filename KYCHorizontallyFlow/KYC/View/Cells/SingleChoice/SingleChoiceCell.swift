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
    
//    var model: SingleChoiceAnswerModel? {
//        didSet {
//            updateUI()
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setSpaceBottom()
        setupTableView()
    }
    
    private func setSpaceBottom() {
        let footer = UIView()
        footer.frame.size.height = 20
        tableView.tableFooterView = footer
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.register(cellNib: SingleChoiceTitleCell.self)
        tableView.register(cellNib: SingleChoiceAnswerCell.self)
    }
    
//    private func updateUI() {
//        guard let model = model else { return }
//        updateTable(for: model)
//    }
    
//    private func updateTable(for model: SingleChoiceAnswerModel) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
//            self.tableView.reloadData()
//        }
//    }
}

extension SingleChoiceCell: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
}
