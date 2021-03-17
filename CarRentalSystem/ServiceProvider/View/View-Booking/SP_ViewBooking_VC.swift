//
//  SP_ViewBooking_VC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 17/08/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

class SP_ViewBooking_VC: UIViewController {

    //MARK : to store booking data
    var bookDetail = [Any]();
    
    // MARK : outlet of tableview
    @IBOutlet weak var tblOutlet: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getSpBooking()
    }
    
    // MARK : get data from booking table for Service Provider
    func getSpBooking()
    {
        let spId = UserDefaults.standard.string(forKey: "sp_id")
        
        let url = URL(string: "\(commConst.baseUrl)getSpBooked.php?sp_id=\(spId!)");
        
        let request = URLRequest(url: url!)
        
        let session = URLSession.shared;
        
        let dataTask = session.dataTask(with: request) { (data, resp, err) in
            
            let str = String(data: data!, encoding: String.Encoding.utf8)
            print(str!)
            
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                
                if json.count == 0
                {
                    alert.commonAlert(Msg: "No Booking yet", uiVC: self)
                }
                else
                {
                    DispatchQueue.main.async {
                        
                        self.bookDetail = json
                        self.tblOutlet.reloadData()
                        
                    }
                }
                
            }
            catch
            {
                alert.commonAlert(Msg: "Error in getting JSon data", uiVC: self)
            }
            
        }
        dataTask.resume()
        
    }
    
    
    
    // MARK : back button action
    @IBAction func backBtnClick(_ sender: Any) {
        
        navigateObj.navigationCommonPop(uiViewController: self)
    }
    
   
}

// MARK : uitableview delegate and datasource

extension SP_ViewBooking_VC: UITableViewDelegate,UITableViewDataSource
{
    
    //MARK : delegate function of tableview
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return bookDetail.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "SP_ViewBookingTBLcell", for: indexPath) as! SP_ViewBookingTBLcell
        
        // MARK : design of tableview cell control
        
        // Pick date & drop date
        cell.pickdateLBL.layer.cornerRadius = 15
        cell.pickdateLBL.clipsToBounds = true
        
        cell.dropdateLBL.layer.cornerRadius = 15
        cell.dropdateLBL.clipsToBounds = true
        
        // total KM
        cell.totalkmLBL.layer.cornerRadius = 15
        cell.totalkmLBL.clipsToBounds = true
        
        // view detail button
        cell.viewDetailBtn.layer.cornerRadius = 10
        cell.viewDetailBtn.clipsToBounds = true
        
        // main view of tableview cell
        cell.mainView.layer.cornerRadius = 10
        cell.clipsToBounds = true
        
        // MARK : Make an action of view detail button
        cell.viewDetailBtn.tag = indexPath.row
        cell.viewDetailBtn.addTarget(self, action: #selector(self.viewBookingAction), for: .touchUpInside)
        
        // MARK : Data fill in uitableview cell
        
       let dic = bookDetail[indexPath.row] as! [String : Any]
        
        // MARK : pick date and drop date
        let Pdate = dic["pickDate"] as! String
        let Ddate = dic["dropDate"] as! String
        cell.pickdateLBL.text = "   \(Pdate)"
        cell.dropdateLBL.text = "   \(Ddate)"
        
        // MARK : pick location and drop location
        let Plocation = dic["pickLocation"] as! String
        let Dlocation = dic["dropLocation"] as! String
        cell.pickLocationLBL.text = Plocation
        cell.dropLocationLBL.text = Dlocation
        
        // MARK : total lm
        let KM = dic["totalKM"] as! String
        cell.totalkmLBL.text = "    \(KM) KM"
        
        return cell
    }
    
    // MARK : Height of Tableview cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 241;
    }
    
    // MARK : @objc method of view detail button which is in tableview cell
    @objc func viewBookingAction(sender : UIButton)
    {
        let dic = bookDetail[sender.tag] as! [String :  Any]
        
        let bookID = dic["book_id"] as! String
        
        let carID = dic["car_id"] as! String
        
        let driverID = dic["driver_id"] as! String
        
        let userID = dic["user_id"] as! String
        
        let stb = self.storyboard?.instantiateViewController(withIdentifier: "SP_ViewBookingDetailVC") as! SP_ViewBookingDetailVC
        
        stb.bookId = bookID
        stb.carId = carID
        stb.driverId = driverID
        stb.userId = userID
        
        self.navigationController?.pushViewController(stb, animated: true)
    }
    
    
}
