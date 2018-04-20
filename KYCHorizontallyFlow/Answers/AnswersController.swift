//
//  AnswersController.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerik  | Stone on 20/04/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import UIKit

final class AnswersController: UITableViewController {
    
    var answers: [QuestionAnswer] = [] {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(cellNib: AnswerCell.self)
        tableView.estimatedRowHeight = 220
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return answers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: AnswerCell = tableView.dequeueReusableCell(for: indexPath)
        
        let answer = answers[indexPath.row]
        cell.answer = answer
        
        return cell
    }
}
