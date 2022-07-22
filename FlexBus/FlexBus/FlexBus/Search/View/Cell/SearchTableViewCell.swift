//
//  SearchTableViewCell.swift
//  BestBus
//
//  Created by 이찬호 on 2022/07/14.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var busNum: UILabel!
    @IBOutlet weak var firstStation: UILabel!
    @IBOutlet weak var lastStation: UILabel!
    @IBOutlet weak var line: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
