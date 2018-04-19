//
//  QuestionsService.swift
//  KYCHorizontallyFlow
//
//  Created by Calebe Emerik  | Stone on 17/04/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation
import RxSwift

final class QuestionsService {
    
    func getQuestions() -> Observable<QuestionsResponse> {
        
        let path = Bundle.main.path(forResource: "Response", ofType: "json")!
        let url = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: url, options: .mappedIfSafe)
        let jsonObject = try! JSONSerialization.jsonObject(with: data, options: [])
        let responseJSON = jsonObject as! JSON
        
        let response = try! QuestionsResponse(json: responseJSON)
        
        return Observable.just(response)
    }
    
    func hasMoreQuestions() {
        
    }
}
