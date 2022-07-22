//
//  BusLineCell.swift
//  BestBus
//
//  Created by 이찬호 on 2022/07/15.
//

import UIKit

class BusLineCell: UITableViewCell {

    @IBOutlet weak var stationName: UILabel!
    @IBOutlet weak var stationNum: UILabel!
    @IBOutlet weak var busImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
