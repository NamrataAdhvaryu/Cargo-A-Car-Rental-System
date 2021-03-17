//
//  CommonMVC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 19/06/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import Foundation
import FCAlertView
import UIKit

func CommonApiCall(url:URL,param:String,completion: @escaping ([Any])->(),completionError: @escaping (([Any])->())) {
    
                var request = URLRequest(url: url);
                request.addValue(String(param.count), forHTTPHeaderField: "Content-Length");
                request.httpBody  = param.data(using: String.Encoding.utf8);
                request.httpMethod = "POST";
                let session = URLSession.shared;
                let datatask  = session.dataTask(with: request) { (data1, resp, err) in
                    
                    let strresp  = String(data: data1!, encoding: String.Encoding.utf8);
                    print(strresp!)
                    do
                    {
                        
                        let jsonarr  = try JSONSerialization.jsonObject(with: data1!, options: []) as! [Any];
                        print(jsonarr)
                        
                        DispatchQueue.main.async {
                            
                            completion(jsonarr);
                            
                        }
                    }
                    catch
                    {
                        DispatchQueue.main.async {
                            
                            print("error")
                            // completion()
                            let errorArr = [Any]()
                            completionError(errorArr)
                            
                        }
                        
                    }
                }
                
                datatask.resume();
            }

func CommonApiLogin(url:URL,completion: @escaping ([Any])->(),completionError: @escaping (([Any])->()))
{
    let request = URLRequest(url: url)
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request) { (data, response, error) in
        
        let strConvert = String(data: data!, encoding: String.Encoding.utf8)
        print(strConvert!)
        
        do
        {
            let jsonData = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
            
            if jsonData.count == 1
            {
                print("sucessfull")
                
                DispatchQueue.main.async {
                    
                    completion(jsonData)

                }
                
            }
            else
            {
                DispatchQueue.main.async {
                    
                    print("error")
                    let errorArr = [Any]()
                    completionError(errorArr)
                }
               
                
            }
            
            
        }
        catch
        {
            
        }
        
    }
    dataTask.resume()
}





