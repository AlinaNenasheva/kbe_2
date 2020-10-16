//
//  AgentHeaderTableViewCell.swift
//  FINAL_SMTH
//
//  Created by Алина Ненашева on 10/16/20.
//  Copyright © 2020 Алина Ненашева. All rights reserved.
//

import UIKit

class AgentHeaderTableViewCell: UITableViewCell {

    @IBOutlet var agentName: UILabel!
    @IBOutlet var passport: UILabel!
    @IBOutlet var phone: UILabel!
    @IBOutlet var insuranceCompany: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
