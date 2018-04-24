//
//  SingleChoiceDataSource.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerick on 19/04/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import UIKit

final class SingleChoiceDataSource: NSObject {
	
	var answers: [Answer] = []
}

extension SingleChoiceDataSource: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return answers.count
    }
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
        let cell: SingleChoiceAnswerCell = tableView.dequeueReusableCell(for: indexPath)

        let answer = answers[indexPath.row]
        cell.answer = answer
        
		return cell
	}
}
