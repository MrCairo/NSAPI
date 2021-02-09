//
//  NAPIListingTableViewCell.swift
//  NAPIS
//
//  Created by Mitchell Fisher on 12/27/18.
//  Copyright © 2018 Committed Code. All rights reserved.
//

import UIKit

class NAPIListingTableViewCell: UITableViewCell {
    @IBOutlet weak var apiTitleLabel: UILabel!
    @IBOutlet weak var apiFullNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
