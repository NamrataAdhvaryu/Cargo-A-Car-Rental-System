//
//  DVerificationController.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 28/07/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

@objc protocol DLVerificationDelegate
{
    @objc optional func AddDLImagesReturnResp(arr : [Any])
    @objc optional func ErrorDriverVerification(arr : [Any])
}

class DVerificationController: NSObject {
    
    var delegete : DLVerificationDelegate?
   // function for add verification detail of driver
    func verificationDetail(verifyModel : DriverVerification)
    {
        
        let url = URL(string: "\(commConst.baseUrl)DriverDLUploading.php")
        
        var request = URLRequest(url: url!)
        request.addValue(String(verifyModel.verifydata!.count), forHTTPHeaderField: "Content-Length")
        request.httpBody = verifyModel.verifydata
        request.httpMethod = "POST"
        
        let session = URLSession.shared;
        let dataTask = session.dataTask(with: request) { (data, resp, err) in
            
            let str = String(data: data!, encoding: String.Encoding.utf8)
            print(str!)
            
            do
            {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                print(jsonData)
                DispatchQueue.main.async {
                    
                    self.delegete?.AddDLImagesReturnResp!(arr: jsonData)
                }
            }
            catch{
                
                DispatchQueue.main.async {
                    
                    print("You are already verified.")
                    let err = [Any]()
                    self.delegete?.ErrorDriverVerification!(arr: err)
                }
                
            }
            
        }
        dataTask.resume()
    }

}
