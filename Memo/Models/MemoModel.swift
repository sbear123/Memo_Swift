//
//  MemoModel.swift
//  Memo
//
//  Created by 박지현 on 2021/06/22.
//

import Foundation

class Memo: Codable {
    var title: String
    var content: String
    var date: Date
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
        self.date = Date()
    }
}
