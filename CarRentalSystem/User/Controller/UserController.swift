//
//  UserController.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 18/06/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

 // Create protocol for return data via delegate method

@objc protocol userdelegate{
    
    @objc optional func userReturnResponse(arr : [Any])
    @objc optional func userLoginReturnResp(arr : [Any])
    @objc optional func getAllcarDataResponse(car : [Any])
    @objc optional func getUpdateUserResponse(updateUser : [Any])
    @objc optional func ErrorUser(arr : [Any])
}

class UserController: NSObject {
    
    var delegate: userdelegate?
    
    
    // get all user data
    
    
    
    
    // create function for get data
    func userRegistration(userModel : usermodel)
    {
        //get data from tbl user
        getUserdata { (result) in
            
            print(result)
            
            let dic = result[0] as! [String : Any]
            var userArr = [dic]
            for item in dic
            {
                let email = dic["user_email"] as! String
               // userArr.append(email)
            }
            print(userModel.user_email!)
            
            let searchValue = userModel.user_email
            var checkEmail = ""
        /*
            for emailValue in userArr
            {
                if (emailValue == searchValue) as! String
                {
                    checkEmail = emailValue as! String
                }
            }
 */
            
            if searchValue == checkEmail
            {
                let url = URL(string: "\(commConst.baseUrl)UserLogin.php?user_email=\(userModel.user_email!)&user_password=\(userModel.user_password!)")
                /*
                CommonApiLogin(url: url!, completion: { (result) in
                    
                    self.delegate?.userLoginReturnResp!(arr: result)
                })
 */
                CommonApiLogin(url: url!, completion: { (result) in
                    
                    self.delegate?.userLoginReturnResp!(arr: result)
                    
                }) { (error) in
                    
                    self.delegate?.ErrorUser!(arr: error)
                }
            }
            else
            {
                // if user not exits then register user
                let url = URL(string: "\(commConst.baseUrl)UserRegistration.php")
                
                let strBody = "user_name=\(userModel.user_name!)&user_address=\(userModel.user_address!)&user_email=\(userModel.user_email!)&user_password=\(userModel.user_password!)&user_mob=\(userModel.user_mob!)&user_city=\(userModel.user_city!)&user_profilepic=\(userModel.user_profilepic!))";
                /*
                CommonApiCall(url: url!, param: strBody) { (result) -> () in
                    
                    self.delegate?.userReturnResponse!(arr: result)
                }
 */
                CommonApiCall(url: url!, param: strBody, completion: { (result) in
                    
                    self.delegate?.userReturnResponse!(arr: result)
                    
                }) { (error) in
                    
                    self.delegate?.ErrorUser!(arr: error)
                }
                
            }
        }
    }
    
    //for login
    func userLogin(userModel : usermodel)
    {
        let url = URL(string: "\(commConst.baseUrl)UserLogin.php?user_email=\(userModel.user_email!)&user_password=\(userModel.user_password!)")
        /*
        CommonApiLogin(url: url!) { (result) -> () in
            
            self.delegate?.userLoginReturnResp!(arr: result)
        }
        */
        CommonApiLogin(url: url!, completion: { (result) in
            
            self.delegate?.userLoginReturnResp!(arr: result)
            
        }) { (error) in
            
            self.delegate?.ErrorUser!(arr: error)
        }
    }
    
    // update user
    func updateUserFunc(userModel : usermodel)
    {
       // let ID = UserDefaults.standard.string(forKey: "user_id")
        let url = URL(string: "\(commConst.baseUrl)updateItem.php")
        
        // containt data
       let body = "user_name=\(userModel.user_name!)&user_address=\(userModel.user_address!)&user_email=\(userModel.user_email!)&user_password=\(userModel.user_password!)&user_mob=\(userModel.user_mob!)&user_city=\(userModel.user_city!)&user_profilepic=\(userModel.user_profilepic!)&user_id=\(userModel.user_id!)";
        
       // print(body)
        /*
        CommonApiCall(url: url!, param: body) { (result)->() in
            
            self.delegate?.getUpdateUserResponse!(updateUser: result)
        }
        */
        CommonApiCall(url: url!, param: body, completion: { (result) in
            
            self.delegate?.userReturnResponse!(arr: result)
            
        }) { (error) in
            
            self.delegate?.ErrorUser!(arr: error)
        }
 
        // request that contanit url and body data
        /*
        var reuqest = URLRequest(url: url!)
        reuqest.addValue(String(body.count), forHTTPHeaderField: "Content-Length")
        reuqest.httpBody = body.data(using: String.Encoding.utf8)
        reuqest.httpMethod = "POST"
        
        let session = URLSession.shared
        let datatask = session.dataTask(with: reuqest) { (data, response, error) in
            
            let str = String(data: data!, encoding: String.Encoding.utf8)
            
            print(str!)
            
            do
            {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                
                print(jsonData)
                DispatchQueue.main.async {
                    
                    self.delegate?.getUpdateUserResponse!(updateUser: jsonData)
                }
            }
            catch
            {
                print("Error in data Updating")
            }
            
        }
        datatask.resume()
    }
 */
}
}
