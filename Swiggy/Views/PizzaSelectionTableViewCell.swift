//
//  PizzaSelectionTableViewCell.swift
//  Swiggy
//
//  Created by Namit on 25/10/18.
//  Copyright © 2018 Namit. All rights reserved.
//

import UIKit

class PizzaSelectionTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var variation:Variations?{
        didSet{
            if let name = variation?.name{
             self.nameLabel.text = name
            }
            if let price = variation?.price{
            self.priceLabel.text = "Rs. \(price)"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
