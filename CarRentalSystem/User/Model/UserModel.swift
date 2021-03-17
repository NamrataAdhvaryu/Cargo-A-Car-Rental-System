//
//  User_Model.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 18/06/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import Foundation

// create a class for relatable table
class usermodel
{
    var user_id :Int?
    var user_name :String?
    var user_address :String?
    var user_email :String?
    var user_password :String?
    var user_city :String?
    var user_mob :String?
    var user_profilepic :String?
    

    init(user_id:Int,user_name:String,user_address:String,user_email:String,user_password:String,user_city:String,user_mob:String,user_profilepic:String)
        {
            self.user_id = user_id
            self.user_name = user_name
            self.user_address = user_address
            self.user_email = user_email
            self.user_password = user_password
            self.user_city = user_city
            self.user_mob = user_mob
            self.user_profilepic = user_profilepic
        }
    
    init(user_email:String,user_password:String) {
        
        self.user_email = user_email
        self.user_password = user_password
    }
    
    init(userid : Int,username : String,useraddress:String,useremail:String,userpassword:String,usercity:String,usermob:String,userprofilepic:String)
    {
        self.user_id = userid
        self.user_name = username
        self.user_address = useraddress
        self.user_email = useremail
        self.user_password = userpassword
        self.user_city = usercity
        self.user_mob = usermob
        self.user_profilepic = userprofilepic
    }
    
}
