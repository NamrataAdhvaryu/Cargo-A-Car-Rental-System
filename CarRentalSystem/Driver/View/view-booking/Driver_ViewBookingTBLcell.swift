//
//  Driver_ViewBookingTBLcell.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 20/08/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

class Driver_ViewBookingTBLcell: UITableViewCell {

    // MARK : outlet
    @IBOutlet weak var pickLocationLbl: UILabel!
    @IBOutlet weak var pickDateLbl: UILabel!
    @IBOutlet weak var dropLocationLbl: UILabel!
    @IBOutlet weak var dropDateLbl: UILabel!
    @IBOutlet weak var totalkmLbl: UILabel!
    @IBOutlet weak var viewdetailBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
