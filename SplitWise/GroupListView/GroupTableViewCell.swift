//
//  GroupTableViewCell.swift
//  SplitWise
//
//  Created by  Oleg Ponomarev on 20.10.2022.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    @IBOutlet var groupNameLabel: UILabel!
    @IBOutlet var checkAmountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
