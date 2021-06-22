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
    
    static var dummyList = [
        Memo(title: "메모하기", content: "메모장을 만들어볼게요"),
        Memo(title: "오늘의 메모", content: "오늘은 메모를 해볼게요!")
    ]
}
