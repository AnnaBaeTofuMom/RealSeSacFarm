//
//  BoardViewModel.swift
//  SeSacBada
//
//  Created by 배경원 on 2022/01/05.
//

import Foundation

class BoardViewModel {
    var boardArray = Observable(Board())

    func getReadPost(completion: @escaping (APIError?, StatusCode?) -> Void) {
        APIService.readPost { board, error, code in
            guard let board = board else {
                completion(error, .failed)
                return
            }
            
            self.boardArray.value = board
            completion(nil, .success)
            
        }
    }
    
    func formatDate(date: String) -> String {
        let formatter = DateFormatter()
        let splitedDate = String(date.split(separator: "T")[0])
        formatter.dateFormat = "yyyy-MM-dd"
        let dateDate = formatter.date(from: splitedDate) ?? Date()
        formatter.dateFormat = "MM/dd"
        return formatter.string(from: dateDate)
        
    }
    
}

