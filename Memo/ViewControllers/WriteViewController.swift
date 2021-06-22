//
//  WriteViewController.swift
//  Memo
//
//  Created by 박지현 on 2021/06/22.
//

import UIKit

class WriteViewController: UIViewController {

    @IBOutlet var titleM: UITextField!
    @IBOutlet var dateM: UILabel!
    @IBOutlet var contentM: UITextView!
    
    var memo: Memo = Memo(title: "", content: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    func updateView() {
        titleM.text = memo.title
        contentM.text = memo.content
        dateM.text = dateToString(time: memo.date)
    }

}

