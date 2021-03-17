//
//  Driver_ViewBookingVC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 20/08/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit
import FCAlertView
class Driver_ViewBookingVC: UIViewController,FCAlertViewDelegate {
   
    // MARK : store booked driver
    var driverARR = [Any]();
    
    // MARK : outlet of tableview
    @IBOutlet weak var tblOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getBookeddriver()
        // Do any additional setup after loading the view.
    }

    // MARK : get booking data (in which driver is booked)
    func getBookeddriver()
    {
        let bookDriver = UserDefaults.standard.string(forKey: "driver_id")
        
        let url = URL(string: "\(commConst.baseUrl)getBookedDriver.php?driver_id=\(bookDriver!)")
        
        let request = URLRequest(url: url!)
        
        let session = URLSession.shared;
        
        let dataTask = session.dataTask(with: request) { (data, resp, err) in
            
            let str = String(data: data!, encoding: String.Encoding.utf8)
            print(str!)
            
            do
            {
                let jsondata = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                
                if jsondata.count == 0
                {
                    
                    DispatchQueue.main.async {
                        
                        let alert = FCAlertView()
                        alert.colorScheme = #colorLiteral(red: 0.1311177611, green: 0.2742711604, blue: 0.9628491998, alpha: 1)
                        alert.makeAlertTypeCaution()
                        alert.delegate = self
                        alert.blurBackground = true
                        alert.showAlert(inView: self, withTitle: "Car-Rental System", withSubtitle: "No Booking Yet.", withCustomImage: nil, withDoneButtonTitle: nil, andButtons: nil)
                    }
                    alert.commonAlert(Msg: "No data found", uiVC: self)
                }
                else
                {
                    DispatchQueue.main.async {
                        
                        self.driverARR = jsondata
                        self.tblOutlet.reloadData()
                        
                    }
                }
            }
            catch
            {
                alert.commonAlert(Msg: "Error in getting json data.", uiVC: self)
            }
        }
        dataTask.resume()
    }
    
    // MARK : alert ok button click
    func fcAlertDoneButtonClicked(_ alertView: FCAlertView!) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "DriverHomePageVC")
    }

}

extension Driver_ViewBookingVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return driverARR.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Driver_ViewBookingTBLcell", for: indexPath) as! Driver_ViewBookingTBLcell
        
        //MARK : design of view detail button
        cell.viewdetailBtn.layer.cornerRadius = 15
        cell.viewdetailBtn.clipsToBounds = true
        
        let dic = driverARR[indexPath.row] as! [String : Any]
        
    // MARK : fill data from dictonary
        
        let pickLocation = dic["pickLocation"] as! String
        cell.pickLocationLbl.text = pickLocation
        
        let pickDate = dic["pickDate"] as! String
        cell.pickDateLbl.text = pickDate
        
        let dropLocation = dic["dropLocation"] as! String
        cell.dropLocationLbl.text = dropLocation
        
        let dropDate = dic["dropDate"] as! String
        cell.dropDateLbl.text = dropDate
        
        let totalKM = dic["totalKM"] as! String
        cell.totalkmLbl.text = totalKM
        
        
    // MARK : make action of view detail
        cell.viewdetailBtn.tag = indexPath.row
        cell.viewdetailBtn.addTarget(self, action: #selector(self.viewBtnAction), for: .touchUpInside)
        
        
        return cell
    }
    
    // MARK : set height of rpw
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 203
    }
    
    // MARK : objc action of view detail button
    @objc func viewBtnAction(sender : UIButton)
    {
        let dic = driverARR[sender.tag] as! [String : Any]
        
        let id = dic["book_id"] as! String
        let Bookcar = dic["car_id"] as! String
        let Booksp = dic["sp_id"] as! String
        let BookUser = dic["user_id"] as! String
        
        let stb = self.storyboard?.instantiateViewController(withIdentifier: "Driver_BookingDetailVC") as! Driver_BookingDetailVC
        
        stb.book = id
        stb.car = Bookcar
        stb.sp = Booksp
        stb.user = BookUser
        
        self.navigationController?.pushViewController(stb, animated: true)
    }
    
    
}
