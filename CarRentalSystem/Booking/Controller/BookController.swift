//
//  BookController.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 11/08/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

@objc protocol BookDelegate{
    
    @objc optional func BookReturnResponse(arr : [Any])
    @objc optional func ErrorHandle(arr : [Any])
}

class BookController: NSObject {

    var delegate : BookDelegate?
    
    func BookCar(bookModel : BookModel)
    {
        let url = URL(string: "\(commConst.baseUrl)BookCar.php");
        
        let strBody = "car_id=\(bookModel.car_id!)&driver_id=\(bookModel.driver_id!)&sp_id=\(bookModel.sp_id!)&user_id=\(bookModel.user_id!)&pickLocation=\(bookModel.toFromLocation!)&dropLocation=\(bookModel.toToLocation!)&pickDate=\(bookModel.toFromDate!)&dropDate=\(bookModel.toToDate!)&totalKM=\(bookModel.totalKM!)&spFare=\(bookModel.spfare!)";
        
        var request = URLRequest(url: url!)
        request.addValue(String(strBody.count), forHTTPHeaderField: "Content-Lenght");
        request.httpBody = strBody.data(using: String.Encoding.utf8)
        request.httpMethod = "POST"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, resp, err) in
            
            let str = String(data: data!, encoding: String.Encoding.utf8)
            print(str!)
            
            do
            {
                let jsonBook = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                
                DispatchQueue.main.async {
                    
                    self.delegate?.BookReturnResponse!(arr: jsonBook)
                }
            }
            catch
            {
                DispatchQueue.main.async {
                    
                    print("Error in Insert data")
                    let err = [Any]()
                    self.delegate?.ErrorHandle!(arr: err)
                    
                }
                
            }
        }
        dataTask.resume()
        
    }
    
    
    
}
