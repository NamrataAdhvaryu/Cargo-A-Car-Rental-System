//
//  spController.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 19/06/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

// Create protocol for return data via delegate method

@objc protocol spdelegate{
    
    @objc optional func spReturnResponse(arr : [Any])
    @objc optional func spLoginReturnResp(arr : [Any])
    @objc optional func spUpdateReturnResp(arr : [Any])
    @objc optional func ErrorSP(arr : [Any])
    
}

class spController: NSObject {
    
    var delegate : spdelegate?
    
    func spRegistration(spModel : spmodel)
    {
        let url = URL(string: "\(commConst.baseUrl)SpRegistration.php")
        
        let strBody = "sp_name=\(spModel.sp_name!)&sp_address=\(spModel.sp_address!)&sp_email=\(spModel.sp_email!)&sp_password=\(spModel.sp_password!)&sp_mob=\(spModel.sp_mob!)&sp_profilepic=\(spModel.sp_profilepic!)";
        /*
        CommonApiCall(url: url!, param: strBody) { (result) -> () in
            
            self.delegate?.spReturnResponse!(arr: result)
        }
 */
        CommonApiCall(url: url!, param: strBody, completion: { (result) in
            
            self.delegate?.spReturnResponse!(arr: result)
            
        }) { (error) in
            
            self.delegate?.ErrorSP!(arr: error)
        }
    }
    
    func splogin(spModel : spmodel)
    {
        let url = URL(string: "\(commConst.baseUrl)SpLogin.php?sp_email=\(spModel.sp_email!)&sp_password=\(spModel.sp_password!)")
        /*
        CommonApiLogin(url: url!) { (result) -> () in
            
            self.delegate?.spLoginReturnResp!(arr: result)
        }
 */
        CommonApiLogin(url: url!, completion: { (result) in
            
            self.delegate?.spLoginReturnResp!(arr: result)
            
        }) { (error) in
            
            self.delegate?.ErrorSP!(arr: error)
        }
        
    }
    
    func spUpdate(spUpdateModel : spmodel)
    {
        let url = URL(string: "\(commConst.baseUrl)updateSPData.php")
        
        let strbody = "sp_name=\(spUpdateModel.sp_name!)&sp_email=\(spUpdateModel.sp_email!)&sp_password=\(spUpdateModel.sp_password!)&sp_address=\(spUpdateModel.sp_address!)&sp_mob=\(spUpdateModel.sp_mob!)&sp_pincode=\(spUpdateModel.sp_pincode!)&sp_location=\(spUpdateModel.sp_location!)&sp_status=\(spUpdateModel.sp_status!)&sp_profilepic=\(spUpdateModel.sp_profilepic!)&sp_id=\(spUpdateModel.sp_id!)";
        
        /*
        // here your can use directly common fuction for insert data into databse
        CommonApiCall(url: url!, param: strbody) { (result)->() in
            
            self.delegate?.spUpdateReturnResp!(arr: result)
            
        }
        */
        
        // either you can write code as below
        
        var request = URLRequest(url: url!)
        request.addValue(String(strbody.count), forHTTPHeaderField: "Content-Length");
        request.httpBody = strbody.data(using: String.Encoding.utf8);
        request.httpMethod = "POST";
        
        let session = URLSession.shared;
        let dataTask = session.dataTask(with: request) { (data, resp, err) in
            
            let str = String(data: data!, encoding: String.Encoding.utf8)
            print(str!)
            
            do
            {
                let jasondata = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                
                DispatchQueue.main.async {
                    
                    self.delegate?.spUpdateReturnResp!(arr: jasondata)
                }
            }
            catch
            {
                
                DispatchQueue.main.async {
                    
                    print("Error in do catch block")
                    let err = [Any]()
                    self.delegate?.ErrorSP!(arr: err)
                }
                
            }
        
 
    }
    dataTask.resume()

}
}
