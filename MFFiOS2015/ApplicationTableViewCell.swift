//
//  ApplicationTableViewCell.swift
//  MFFiOS2015
//
//  Created by Fernandez Astigarraga Emilio on 08/12/15.
//  Copyright © 2015 avast. All rights reserved.
//

import UIKit

class ApplicationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var developerLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var application: Application! {
        didSet {
            nameLabel.text = application.name
            developerLabel.text = application.developer
            priceLabel.text = application.price
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
