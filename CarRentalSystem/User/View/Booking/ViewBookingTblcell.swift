//
//  ViewBookingTblcell.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 13/08/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

class ViewBookingTblcell: UITableViewCell {
    
    // MARK : outlet of tableview cell
    @IBOutlet weak var bothLocationlbl: UILabel!
    @IBOutlet weak var fromDatelbl : UILabel!
    @IBOutlet weak var toDatelbl: UILabel!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var viewDetail: UIButton!
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
