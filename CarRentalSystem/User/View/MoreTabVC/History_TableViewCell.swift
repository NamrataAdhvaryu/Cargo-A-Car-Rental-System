//
//  History_TableViewCell.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 05/09/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

class History_TableViewCell: UITableViewCell {

    // MARK : outlet
    @IBOutlet weak var pickLocation: UILabel!
    @IBOutlet weak var dropLocation: UILabel!
    @IBOutlet weak var pickDate: UILabel!
    @IBOutlet weak var dropDate: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
