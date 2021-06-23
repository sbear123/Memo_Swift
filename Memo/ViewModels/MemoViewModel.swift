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
    
    let network = MemoFireBaseManager()
    
    let disposeBag = DisposeBag()
    
    var memoList: [Memo] = []
    
    func getMemo(_ num: Int) -> Memo {
        return memoList[num]
    }
    
    func updateMemo(_ memo: Memo) {
        memoList.append(memo)
    }
    
    func loadMemo(handler: @escaping (Bool) -> Void){
        network.read().subscribe(
            onSuccess: { arr in
                self.memoList = arr
                handler(true)
            },
            onFailure: { err in
                handler(false)
            }).disposed(by: disposeBag)
    }
    
    func write(memo: Memo, handler: @escaping (String) -> Void){
        network.post(request: memo).subscribe(
            onSuccess: { id in
                handler(id)
            },
            onFailure: { err in
                handler("")
            }).disposed(by: disposeBag)
    }
    
    func delete(memo: Memo, handler: @escaping (Bool) -> Void){
        network.delete(request: memo).subscribe(
            onSuccess: { _ in
                handler(true)
            },
            onFailure: { err in
                handler(false)
            }).disposed(by: disposeBag)
    }
    
    func update(memo: Memo, handler: @escaping (Bool) -> Void){
        network.put(request: memo).subscribe(
            onSuccess: {_ in
                handler(true)
            },
            onFailure: { err in
                handler(false)
            }).disposed(by: disposeBag)
    }
    
}
