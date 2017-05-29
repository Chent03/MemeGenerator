//
//  MemeTableViewCell.swift
//  Meme
//
//  Created by Tony Chen on 5/26/17.
//  Copyright © 2017 Tony Chen. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    @IBOutlet weak var memeImage: UIImageView!
    
    
    @IBOutlet weak var memeTop: UILabel!
    
    @IBOutlet weak var memeBot: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
