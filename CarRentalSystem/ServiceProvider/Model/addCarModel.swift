//
//  addCarModel.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 24/06/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import Foundation

class addCarModel
{
    var sp_id :Int?
    var car_id : Int?
    var car_name : String?
    var car_model : String?
    var car_modelNo : String?
    var car_passCapacity : String?
    var car_RCbook : String?
    var car_insurance : String?
    var car_ISavailable : String?
    var car_bookedStatus : String?
    var car_AC : String?
    var car_Airbag : String?
    var car_lockDoor : String?
    var car_SteeringType : String?
    var car_PriceKM : String?
    var car_paymentMode : String?
    var car_luggage : String?
    var car_image : String?
    
    // for store multiple images
    var imgData : Data?
    
    
    init(sp_id : Int,car_id : Int,car_name :String,car_model : String,car_modelNo :String,car_passCapacity :String,car_RCbook:String,car_insurance:String,car_ISavailable :String,car_bookedStatus:String,car_AC :String,car_Airbag:String,car_lockDoor :String,car_SteeringType :String,car_PriceKM:String,car_paymentMode:String,car_luggage :String,car_image :String)
    {
        self.sp_id = sp_id
        self.car_id = car_id
        self.car_name = car_name
        self.car_model = car_model
        self.car_modelNo = car_modelNo
        self.car_passCapacity = car_passCapacity
        self.car_RCbook = car_RCbook
        self.car_insurance  = car_insurance
        self.car_ISavailable = car_ISavailable
        self.car_bookedStatus = car_bookedStatus
        self.car_AC = car_AC
        self.car_Airbag = car_Airbag
        self.car_lockDoor = car_lockDoor
        self.car_SteeringType = car_SteeringType
        self.car_PriceKM = car_PriceKM
        self.car_paymentMode = car_paymentMode
        self.car_luggage = car_luggage
        self.car_image = car_image
        
    }
    
    // get all car
    init(car_id : Int,car_name :String,car_model : String,car_modelNo :String,car_passCapacity :String,car_RCbook:String,car_insurance:String,car_ISavailable :String,car_bookedStatus:String,car_AC :String,car_Airbag:String,car_lockDoor :String,car_SteeringType :String,car_PriceKM:String,car_paymentMode:String,car_luggage :String,car_image :String)
    {
        self.car_id = car_id
        self.car_name = car_name
        self.car_model = car_model
        self.car_modelNo = car_modelNo
        self.car_passCapacity = car_passCapacity
        self.car_RCbook = car_RCbook
        self.car_insurance  = car_insurance
        self.car_ISavailable = car_ISavailable
        self.car_bookedStatus = car_bookedStatus
        self.car_AC = car_AC
        self.car_Airbag = car_Airbag
        self.car_lockDoor = car_lockDoor
        self.car_SteeringType = car_SteeringType
        self.car_PriceKM = car_PriceKM
        self.car_paymentMode = car_paymentMode
        self.car_luggage = car_luggage
        self.car_image = car_image
        
    }
    
    // for add multiple images into AddCar table
    init(data : Data) {
        
        self.imgData = data
    }
    
    // MARK : update into car bokked status
    init(bookstatus : String,carid : Int)
    {
        self.car_bookedStatus = bookstatus
        self.car_id = carid
    }
}
