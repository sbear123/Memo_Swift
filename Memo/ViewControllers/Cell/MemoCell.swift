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
        date_M.text = dateToString(time: memo.date)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

func dateToString(time: Date) -> String {
    let date = DateFormatter()
    date.locale = Locale(identifier: "ko_kr")
    date.timeZone = TimeZone(abbreviation: "KST")
    date.dateFormat = ("yyyy.MM.dd.")
    return date.string(from: time)
}
