//
//  ParticipantsTableViewCell.swift
//  ChristmasDinner
//
//  Created by GUILLERMO CRESPO AGUAYO on 10/1/19.
//  Copyright © 2019 GUILLERMO CRESPO AGUAYO. All rights reserved.
//

import UIKit

class ParticipantsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblNameP: UILabel!
    @IBOutlet weak var tickBox: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
