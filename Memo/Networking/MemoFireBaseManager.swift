//
//  ConnectDB.swift
//  Memo
//
//  Created by 박지현 on 2021/06/22.
//

import Foundation
import RxSwift
import Firebase

class MemoFireBaseManager: BaseFireBaseManager {
    
    func post(request: Memo) -> Single<String> {
        var ref: DocumentReference? = nil
        let databaseRef = dataBase.collection("/Memo")
        return Single<String>.create { single in
            let semaphore = DispatchSemaphore(value: 0)
            ref = databaseRef.addDocument(data:[
                "title":request.title,
                "content":request.content,
                "date":request.date
            ]) {
                $0 == nil ? single(.success(ref!.documentID)) : single(.failure($0!))
                semaphore.signal()
            }
            return Disposables.create()
        }
    }
    
    func put(request: Memo) -> Single<Void> {
        let databaseRef = dataBase.collection("/Memo")
        return Single<Void>.create { single in
            let semaphore = DispatchSemaphore(value: 0)
            databaseRef.document(request.id).setData([
                "title":request.title,
                "content":request.content,
                "date":request.date
            ]){
                $0 == nil ? single(.success(Void())) : single(.failure($0!))
                semaphore.signal()
            }
            
            return Disposables.create()
        }
    }
    
    func delete(request: Memo) -> Single<Void> {
        let databaseRef = dataBase.collection("/Memo")
        return Single<Void>.create { single in
            let semaphore = DispatchSemaphore(value: 0)
            databaseRef.document().delete() {
                $0 == nil ? single(.success(Void())) : single(.failure($0!))
                semaphore.signal()
            }
            return Disposables.create()
        }
    }
    
    
    func read() -> Single<[Memo]> {
        let databaseRef = dataBase.collection("/Memo")
        return Single<[Memo]>.create { single in
            let semaphore = DispatchSemaphore(value: 0)
            databaseRef.getDocuments() { document,error  in
                guard let document = document else {
                    single(.failure(error!))
                    semaphore.signal()
                    return
                }
                single(.success(self.convertMemoList(data: document.documents)))
                semaphore.signal()
            }
            return Disposables.create()
        }
    }
    
}

extension MemoFireBaseManager {
    private func convertMemoList(data:[QueryDocumentSnapshot]) -> Array<Memo> {
        var tempADArray = Array<Memo>()
        
        for ad in data {
            let date = ad["date"] as! Timestamp
            let m = Memo(id: ad.documentID, title: ad["title"] as! String, content: ad["content"] as! String, date.dateValue())
            tempADArray.append(m)
        }
        
        return tempADArray
    }
    
}
