//
//  DriverModel.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 19/06/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import Foundation

// create a class for relatable table
class Drivermodel
{
    var driver_id :Int?
    var driver_name :String?
    var driver_address :String?
    var driver_email :String?
    var driver_password :String?
    var driver_mob :String?
    var driver_profilepic :String?
    var driver_location : String?
    var driver_isbooked_status :String?
    var driver_numberOftour :String?
    var driver_priceperHour :String?
    var driver_status :String?
    
    
    init(driver_id:Int,driver_name:String,driver_address:String,driver_email:String,driver_password:String,driver_mob:String,driver_status:String,driver_profilepic:String)
    {
        self.driver_id = driver_id
        self.driver_name = driver_name
        self.driver_address = driver_address
        self.driver_email = driver_email
        self.driver_password = driver_password
        self.driver_mob = driver_mob
        self.driver_status = driver_status
        self.driver_profilepic = driver_profilepic
    }
    
    init(driver_email:String,driver_password:String) {
        
        self.driver_email = driver_email
        self.driver_password = driver_password
    }
    
    init(driver_id:Int,driver_name:String,driver_address:String,driver_email:String,driver_password:String,driver_mob:String,driver_profilepic:String,driver_location : String,driver_isbooked_status :String,driver_numberOftour :String,driver_priceperHour :String,driver_status:String)
    {
        self.driver_id = driver_id
        self.driver_name = driver_name
        self.driver_address = driver_address
        self.driver_email = driver_email
        self.driver_password = driver_password
        self.driver_mob = driver_mob
        self.driver_profilepic = driver_profilepic
        self.driver_location = driver_location
        self.driver_isbooked_status = driver_isbooked_status
        self.driver_numberOftour = driver_numberOftour
        self.driver_priceperHour = driver_priceperHour
        self.driver_status = driver_status
    }
    
    // MARK : for driver is booked status update
    init(driver_id : Int,driverStats : String)
    {
        self.driver_id = driver_id
        self.driver_isbooked_status = driverStats
    }
}
