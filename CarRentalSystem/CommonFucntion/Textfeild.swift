//
//  Textfeild.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 29/06/20.
//  Copyright © 2020 Namrata AkashKhushbu. All rights reserved.
//

import Foundation
import UIKit

extension UITextField
{
    static func CreateTextField(frame : CGRect ,placeholder : String ,image : UIImage ) -> [UITextField]
    {
        let textField = UITextField(frame: frame)
        textField.placeholder = placeholder
        textField.keyboardType = .default
        textField.borderStyle = .none
        let img = UIImageView()
        img.image = image
        textField.leftViewMode = .always
        textField.leftView = img
        
        return [textField]
    }
    
    
}
extension CALayer
{
    static func CreateLayer(frame : CGRect,bgcolor : UIColor) -> CALayer
    {
        let BottomLine = CALayer()
        BottomLine.frame = frame
        BottomLine.backgroundColor = (bgcolor as! CGColor)
        return BottomLine
    }
}
