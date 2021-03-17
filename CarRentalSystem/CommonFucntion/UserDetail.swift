//
//  UserDetail.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 30/07/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import Foundation
import UIKit

func getUserdata(completion: @escaping ([Any])->())
{
    let url = URL(string: "\(commConst.baseUrl)AllUser.php?)")
    
    let request = URLRequest(url: url!)
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request) { (data, response, error) in
        
        let strConvert = String(data: data!, encoding: String.Encoding.utf8)
        print(strConvert!)
        
        do
        {
            let jsonData = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
            
                DispatchQueue.main.async {
                    
                    completion(jsonData)
                    
                }
        }
        catch
        {
            print("Error in getting json data")
        }
        
    }
    dataTask.resume()
}
