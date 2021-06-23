//
//  MemoModel.swift
//  Memo
//
//  Created by 박지현 on 2021/06/22.
//

import Foundation

class Memo: Codable {
    var id: String
    var title: String
    var content: String
    var date: Date
    
    init(id: String, title: String, content: String,_ dateS: Date?) {
        self.id = id
        self.title = title
        self.content = content
        if let date = dateS {
            self.date = date
        } else {
            self.date = Date()
        }
    }
}

extension String {
    func toDate() -> Date? { //"yyyy-MM-dd HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy.MM.dd."
        if let date = dateFormatter.date(from: self) { return date }
        else { return nil }
    }
}

