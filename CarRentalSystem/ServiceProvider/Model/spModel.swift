//
//  spModel.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 19/06/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import Foundation

class spmodel
{
    var sp_id :Int?
    var sp_name :String?
    var sp_address :String?
    var sp_email :String?
    var sp_password :String?
    var sp_mob :String?
    var sp_profilepic :String?
    var sp_pincode :String?
    var sp_location :String?
    var sp_status :String?
    
    
   /* for registration */ init(sp_id:Int,sp_name:String,sp_address:String,sp_email:String,sp_password:String,sp_mob:String,sp_profilepic:String)
    {
        
        
        self.sp_id = sp_id
        self.sp_name = sp_name
        self.sp_address = sp_address
        self.sp_email = sp_email
        self.sp_password = sp_password
        self.sp_mob = sp_mob
        self.sp_profilepic = sp_profilepic
    }
    
    /* for login */
    init(sp_email:String,sp_password:String) {
        
        self.sp_email = sp_email
        self.sp_password = sp_password
    }
    
   
    /* for updatedata */ init(sp_id:Int,sp_name:String,sp_address:String,sp_email:String,sp_password:String,sp_mob:String,sp_profilepic:String,sp_pincode :String ,sp_location:String,sp_status:String)
    {
        
        
        self.sp_id = sp_id
        self.sp_name = sp_name
        self.sp_address = sp_address
        self.sp_email = sp_email
        self.sp_password = sp_password
        self.sp_mob = sp_mob
        self.sp_profilepic = sp_profilepic
        self.sp_pincode = sp_pincode
        self.sp_location = sp_location
        self.sp_status = sp_status
    }
}
