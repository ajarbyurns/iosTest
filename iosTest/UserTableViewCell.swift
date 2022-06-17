//
//  UserTableViewCell.swift
//  iosTest
//
//  Created by bitocto_Barry on 17/06/22.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var displayPic: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        displayPic.layer.cornerRadius = displayPic.frame.height/2
        displayPic.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
