//
//  BookModel.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 11/08/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import Foundation

// class for booking and travel table
class BookModel
{
    var car_id :Int?
    var driver_id :Int?
    var sp_id :Int?
    var user_id :Int?
    var toFromLocation :String?
    var toToLocation :String?
    var toFromDate :String?
    var toToDate :String?
    var totalKM :String?
    var spfare :String?
    
    init(car_id :Int,driver_id :Int,sp_id : Int,user_id : Int,toFromLocation:String,toToLocation:String,toFromDate:String,toToDate:String,totalKM :String,spfare :String)
    {
        
        self.car_id = car_id
        self.driver_id = driver_id
        self.sp_id = sp_id
        self.user_id = user_id
        
        self.toFromLocation = toFromLocation
        self.toToLocation = toToLocation
        self.toFromDate = toFromDate
        self.toToDate = toToDate
        self.totalKM = totalKM
        self.spfare = spfare
        
    }
    
}

