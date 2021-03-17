//
//  SP_ViewBookingTBLcell.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 17/08/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

class SP_ViewBookingTBLcell: UITableViewCell {

    // MARK : outlet of control
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var pickdateLBL: UILabel!
    @IBOutlet weak var dropdateLBL: UILabel!
    @IBOutlet weak var pickLocationLBL : UILabel!
    @IBOutlet weak var dropLocationLBL : UILabel!
    
    @IBOutlet weak var totalkmLBL : UILabel!
    
    @IBOutlet weak var viewDetailBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
