//
//  ShowCarTableCell1.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 21/06/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

class ShowCarTableCell1: UITableViewCell {

    // outlets
    
    
    @IBOutlet weak var carNameOutlet: UILabel!
    
    @IBOutlet weak var carImageOutlet: UIImageView!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var passangerBtn: UIButton!
    @IBOutlet weak var pasangerLbl: UILabel!
    
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var acBtn: UIButton!
    @IBOutlet weak var acLable: UILabel!
    
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var streeingBtn: UIButton!
    @IBOutlet weak var streeingLable: UILabel!
    
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var insuranceBtn: UIButton!
    @IBOutlet weak var insuranceLabel: UILabel!
    
    @IBOutlet weak var ContinueBtn: UIButton!
    
    @IBOutlet weak var bookstatusBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // view design
        
        // btn design
        ContinueBtn.layer.cornerRadius = 10
        ContinueBtn.clipsToBounds = true
        
        
        // view design
        view1.layer.cornerRadius = 10
        view2.layer.cornerRadius = 10
        view3.layer.cornerRadius = 10
        view4.layer.cornerRadius = 10
        
        // lable
        carNameOutlet.layer.cornerRadius = 10
        carNameOutlet.layer.borderWidth = 2
        carNameOutlet.layer.borderColor = #colorLiteral(red: 0.7102812178, green: 0.7849145392, blue: 1, alpha: 1)
        carNameOutlet.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
