//
//  MemoCell.swift
//  Memo
//
//  Created by 박지현 on 2021/06/22.
//

import Foundation
import UIKit

class MemoCell: UITableViewCell {
    @IBOutlet weak var title_M: UILabel!
    @IBOutlet weak var content_M: UILabel!
    @IBOutlet weak var date_M: UILabel!
    
    func update(memo: Memo) {
        title_M.text = memo.title
        content_M.text = memo.content
        date_M.text = memo.date.toString()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy.MM.dd."
        return dateFormatter.string(from: self)
    }
}
