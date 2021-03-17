//
//  CommonAlert.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 20/06/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

class CommonAlert: NSObject {

    //commonalert
    func commonAlert(Msg : String,uiVC : UIViewController)
    {
        let alert = UIAlertController(title: "Alert", message: Msg, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        uiVC.present(alert, animated: true, completion: nil)
        
    }
    
    func CommontextLayer(txt : TextFieldValidator,imgStr : String)
    {
        txt.borderStyle = .none
        
        let BottomLine = CALayer()
        BottomLine.frame = CGRect(x: 35, y: txt.frame.size.height - 10, width: txt.frame.size.width - 50, height: 1.0)
        BottomLine.backgroundColor = #colorLiteral(red: 0.1311177611, green: 0.2742711604, blue: 0.9628491998, alpha: 1)
        txt.layer.addSublayer(BottomLine)
        
        // add image on textfiled
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        img.image = UIImage(named: imgStr)
        txt.leftViewMode = .always
        txt.leftView = img
    }
    
    func CommonLableLayer(lbl : UILabel)
    {
        let BottomLine = CALayer()
        BottomLine.frame = CGRect(x: 35, y: lbl.frame.size.height - 10, width: lbl.frame.size.width - 50, height: 1.0)
        BottomLine.backgroundColor = #colorLiteral(red: 0.1311177611, green: 0.2742711604, blue: 0.9628491998, alpha: 1)
        lbl.layer.addSublayer(BottomLine)
    }
}
