//
//  MemoViewModel.swift
//  Memo
//
//  Created by 박지현 on 2021/06/22.
//

import Foundation
import RxSwift
import RxCocoa

class MemoViewModel {
    static let shared = MemoViewModel()
    
    var memoList: [Memo] = [
        Memo(title: "메모하기", content: "메모장을 만들어볼게요"),
        Memo(title: "오늘의 메모", content: "오늘은 메모를 해볼게요!")
    ] {
        didSet{
            //tablelist업데이트 코드 작성
        }
    }
    
    func getMemo(_ num: Int) -> Memo {
        return memoList[num]
    }
    
}
