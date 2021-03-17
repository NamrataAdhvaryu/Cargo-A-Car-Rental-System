//
//  UserInformationVC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 24/07/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

class DriverInformationVC : UIViewController {
//outlet
    @IBOutlet weak var driverProfile: UIImageView!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var driverNameLbl: UILabel!
    @IBOutlet weak var driverEmailLbl: UILabel!
    @IBOutlet weak var driverContactLbl: UILabel!
    
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var driverAddressLbl: UILabel!
    @IBOutlet weak var driverLocationLbl: UILabel!
    
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var driverPriceLbl: UILabel!
    @IBOutlet weak var driverTotaltourLbl: UILabel!
    @IBOutlet weak var driverStatusLbl: UILabel!
    
    var driveID = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //print(driveID)
        design()
        getPerticluerDriver()
        
        
        // Do any additional setup after loading the view.
    }
    
    func design()
    {
        driverProfile.layer.cornerRadius = driverProfile.frame.size.width / 2;
        driverProfile.clipsToBounds = true
        
        view1.layer.cornerRadius = 10
        view1.clipsToBounds = true
        view1.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view1.layer.borderColor = #colorLiteral(red: 0.1311177611, green: 0.2742711604, blue: 0.9628491998, alpha: 1)
        view1.layer.borderWidth = 1
        
        view2.layer.cornerRadius = 10
        view2.clipsToBounds = true
        view2.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view2.layer.borderColor = #colorLiteral(red: 0.1311177611, green: 0.2742711604, blue: 0.9628491998, alpha: 1)
        view2.layer.borderWidth = 1
        
        view3.layer.cornerRadius = 10
        view3.clipsToBounds = true
        view3.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view3.layer.borderColor = #colorLiteral(red: 0.1311177611, green: 0.2742711604, blue: 0.9628491998, alpha: 1)
        view3.layer.borderWidth = 1
        
    }
    
    func getPerticluerDriver()
    {
        let url = URL(string: "\(commConst.baseUrl)getAllDriverdata.php?driver_id=\(driveID)")
        
        let request = URLRequest(url: url!)
        
        let session = URLSession.shared;
        
        let dataTask = session.dataTask(with: request) { (data, resp, error) in
            
            let str = String(data: data!, encoding: String.Encoding.utf8)
            print(str!)
            
            do
            {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                print(jsonData)
                
                DispatchQueue.main.async {
                    
                    let dic = jsonData[0] as! [String : Any]
                    
                    let name = dic["driver_name"] as! String
                    self.driverNameLbl.text = name
                    
                    let email = dic["driver_email"] as! String
                    self.driverEmailLbl.text = email
                    
                    let address = dic["driver_address"] as! String
                    self.driverAddressLbl.text = address
                    
                    let mob = dic["driver_mob"] as! String
                    self.driverContactLbl.text = mob
                    
                    let location = dic["driver_location"] as! String
                    self.driverLocationLbl.text = location
                    
                    let totalTour = dic["driver_numberOftour"] as! String
                    self.driverTotaltourLbl.text = totalTour
                    
                    let price = dic["driver_priceperHour"] as! String
                    self.driverPriceLbl.text = price
                    
                    let status = dic["driver_status"] as! String
                    self.driverStatusLbl.text = status
                    
                    let imgpath = dic["driver_profilepic"] as! String
                    let finalpath = "\(commConst.baseUrl)\(imgpath)";
                    let url = URL(string: finalpath)
                    do
                    {
                        let data = try Data(contentsOf: url!)
                        self.driverProfile.image = UIImage(data: data)
                    }
                    catch
                    {
                        print("Error in download image.")
                    }
                }
            }
            catch
            {
                print("Error in get data from json.")
            }
            
        }
        dataTask.resume()
        
    }
    
    @IBAction func backTapped(_ sender: Any) {
        
        navigateObj.navigationCommonPop(uiViewController: self)
    }
}
