//
//  SpProfile_VC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 13/06/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

class SpProfile_VC: UIViewController {

    // MARK : To store Multiple tour id
    var TourIDarray = [Any]();
    
    //MARK : TO STORE FINAL TRAVEL DATA
    var FinalTraveldata = [Any]();
    
    //MARK : store tour id
    var storeTourID = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK : get booked data
    func getSpBookData()
    {
        let spID = UserDefaults.standard.string(forKey: "sp_id")
        
        let url = URL(string: "\(commConst.baseUrl)getSpBooked.php?sp_id=\(spID!)");
        
        let request = URLRequest(url: url!)
        
        let session = URLSession.shared;
        let dataTask = session.dataTask(with: request) { (data, resp, err) in
            
            
            // let str = String(data: data!, encoding: String.Encoding.utf8)
            // print(str!)
            
            do
            {
                let jsondata = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                
                DispatchQueue.main.async {
                    
                    self.bookDetail = jsondata
                    
                    self.getTourID()
                }
            }
            catch
            {
                print("error in getting booked sp data.")
            }
            
        }
        dataTask.resume()
    }
    
    // Mark : GET TOUR ID
    func getTourID()
    {
        
        var i = 0
        
        for item in bookDetail
        {
            
            print(item)
            let dic = bookDetail[i] as! [String : Any]
            let tourID = dic["tour_id"] as! String
            print(tourID)
            i = i + 1;
            TourIDarray.append(tourID)
        }
        print(TourIDarray)
        getTraveldata()
    }
    
    // MARK : GET TRAVEL DATA USING TOUR ID
    func getTraveldata()
    {
        var i = 0
        for item in TourIDarray
        {
            print(item)
            let tourId = TourIDarray[i] as! String
            self.storeTourID = tourId
            
            i = i + 1;
            
            Travel()
        }
    }
    
    func Travel()
    {
        let url = URL(string: "\(commConst.baseUrl)getTourData.php?tour_id=\(storeTourID)");
        
        let request = URLRequest(url: url!)
        
        let session = URLSession.shared;
        let dataTask = session.dataTask(with: request) { (data, resp, err) in
            
            
            let str = String(data: data!, encoding: String.Encoding.utf8)
            print("This is str :\(str!)")
            
            do
            {
                let jsondata = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                
                DispatchQueue.main.async {
                    
                    self.FinalTraveldata.append(jsondata)
                    print("Final : \(self.FinalTraveldata)")
                    
                }
            }
            catch
            {
                print("error in getting booked sp data.")
            }
        }
        dataTask.resume()
    }
    
    
    

    */

}
