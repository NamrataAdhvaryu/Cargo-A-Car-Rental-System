//
//  User_ShowAllDriver.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 22/07/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

// declare for get id for info button
var driverid = "";

class User_ShowAllDriver: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return driverData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowDriverTableCell1", for: indexPath) as! ShowDriverTableCell1
        //design
        
        cell.view1.clipsToBounds = true
        cell.view1.layer.cornerRadius = 10
        
        cell.profileImg.clipsToBounds = true
        cell.profileImg.layer.cornerRadius = cell.profileImg.frame.size.width / 2;
        cell.selectBtn.clipsToBounds = true
        cell.selectBtn.layer.cornerRadius = 10
        
        
        // delegate
        //cell.delegate = self
        cell.infoBtn.tag = indexPath.row
        cell.infoBtn.addTarget(self, action: #selector(self.InfoBtnTap), for: .touchUpInside)
        
        // for select driver
        cell.selectBtn.tag = indexPath.row
        cell.selectBtn.addTarget(self, action: #selector(self.selectDriver), for: .touchUpInside)
        
        let dic = driverData[indexPath.row] as! [String : Any]
        
        
        let name = dic["driver_name"] as! String
        cell.driverName.text = name
        
        let contact = dic["driver_mob"] as! String
        cell.contact.text =  "Contact : \(contact)"
        
        let price = dic["driver_priceperHour"] as! String
        cell.price.text = "Price per hour : \(price))"
        
        let totalTour = dic["driver_numberOftour"] as! String
        cell.tour.text = "Total tour : \(totalTour))"
        
        let driverStatus = dic["driver_isbooked_status"] as! String
        if driverStatus == "Booked"
        {
            cell.selectBtn.titleLabel?.text = driverStatus
            cell.selectBtn.isEnabled = false
            cell.selectBtn.alpha = 0.5
            
        }
        
        
        // for img
        let imgpath = dic["driver_profilepic"] as! String
        let fullpath = "\(commConst.baseUrl)\(imgpath)"
        //print(fullpath)
        
        let url = URL(string: fullpath)
        do
        {
            let imgdata = try Data(contentsOf: url!)
            cell.profileImg.image = UIImage(data: imgdata)
        }
        catch
        {
            print("error in get image")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 148
    }
    
    @IBOutlet weak var tbloutlet: UITableView!
    var driverData = [Any]();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        getAllDriver()
        // Do any additional setup after loading the view.
    }
    
    func getAllDriver()
    {
        let url = URL(string: "\(commConst.baseUrl)getAllDriver.php")
        
        let request = URLRequest(url: url!)
        
        
        let session = URLSession.shared;
        
        let dataTask = session.dataTask(with: request) { (data, resp, err) in
            
           // let str = String(data: data!, encoding: String.Encoding.utf8)
            
          //  print(str!)
            
            do
            {
                let jsondata = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                
                self.driverData = jsondata
                DispatchQueue.main.async {
                    
                    self.tbloutlet.reloadData()
                }
            }
            catch
            {
                print("Error in get data.")
            }
        }
        dataTask.resume()
    }
    
    // infobtn
    @objc func InfoBtnTap(sender : UIButton)
    {
        let dic = driverData[sender.tag] as! [String : Any]
        let id = dic["driver_id"] as! String
        driverid = id
        let stb = self.storyboard?.instantiateViewController(withIdentifier: "DriverInformationVC") as! DriverInformationVC
        stb.driveID = id
        self.navigationController?.pushViewController(stb, animated: true)
    }
    
    // MARK : Action of select driver button
    @objc func selectDriver(sender : UIButton)
    {
        let dic = driverData[sender.tag] as! [String : Any]
        let id = dic["driver_id"] as! String
        let priceDriver = dic["driver_priceperHour"] as! String
        sender.setTitle("Selected", for: .normal)
        
        let stb = self.storyboard?.instantiateViewController(withIdentifier: "checkoutSummaryVC") as! checkoutSummaryVC
        
       stb.selected_DriverId = id
        stb.selected_DriverPrice = priceDriver
        self.navigationController?.pushViewController(stb, animated: true)
        
    }
    

    @IBAction func backBtnAction(_ sender: Any) {
        
        navigateObj.navigationCommonPop(uiViewController: self)
    }
}
