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
    
    lazy var rightButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(buttonPressed(_:)))
        return btn
    }()
    
    var memo: Memo = Memo(id: "", title: "", content: "", nil)
    let vm: MemoViewModel = MemoViewModel.shared
    var isUpdate: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        self.navigationItem.rightBarButtonItem = self.rightButton
    }
    
    func updateView() {
        titleM.text = memo.title
        contentM.text = memo.content
        dateM.text = memo.date.toString()
    }
    
    @objc private func buttonPressed(_ sender: Any) {
        if titleM.text == "" && contentM.text == ""{
            self.navigationController?.popViewController(animated: true)
        }
        memo.title = titleM.text!
        memo.content = contentM.text!
        memo.date = dateM.text!.toDate()!
        if isUpdate {
            vm.update(memo: memo) { success in
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            vm.write(memo: memo) { success in
                if success != "" { self.vm.updateMemo(self.memo) }
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

