//
//  CommonNavigationFunc.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 17/06/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

class CommonNavigationFunc: NSObject {
    
    // common fucntion for navigation for one viewcontroller to Another view Controller in whole application (Pushview controller)
    func navigationCommonPush(uiViewController : UIViewController, identifier : String )
    {
        let stb = uiViewController.storyboard?.instantiateViewController(withIdentifier: identifier)
        
        uiViewController.navigationController?.pushViewController(stb!, animated: true)
    }
    
    //common function for to go back for one view controler to another view controller in whole application (Pop view controller)
    func navigationCommonPop(uiViewController : UIViewController)
    {
        uiViewController.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    

}
