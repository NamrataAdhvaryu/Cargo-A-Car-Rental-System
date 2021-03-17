//
//  UserMybookingVC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 11/06/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit


class UserMybookingVC: UIViewController {

    // MARK : declare array for get travel data
    var bookingdata = [Any]();
    
    // MARK : tableview outlet
    @IBOutlet weak var tblViewOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getBooking()
       
    }
    
    // MARK : get travel data of perticluer user
    
    func getBooking()
    {
        let userID = UserDefaults.standard.string(forKey: "user_id")
        
        let url = URL(string: "\(commConst.baseUrl)UserViewBookingData.php?user_id=\(userID!)")
        print(url!)
        
        let request = URLRequest(url: url!)
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, resp, err) in
            
           let str = String(data: data!, encoding: String.Encoding.utf8)
           print(str!)
            
            do
            {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                
                if jsonData.count == 0
                {
                    alert.commonAlert(Msg: "No Booking Yet", uiVC: self)
                }
                else
                {
                    DispatchQueue.main.async {
                        
                        self.bookingdata = jsonData
                        
                        self.tblViewOutlet.reloadData()
                        
                    }
                }
                
            }
            catch
            {
                print("Error in getting json data.")
            }
            
        }
        dataTask.resume()
    }
    
    
    
}

// MARK : extened UItableviewDelegate & UItableviewdataSpurce
extension UserMybookingVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookingdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewBookingTblcell", for: indexPath) as! ViewBookingTblcell
        
        // MARK : Design
        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true
        cell.mainView.layer.cornerRadius = 10
        cell.clipsToBounds = true
        
        cell.pricelbl.layer.cornerRadius = 25
        cell.pricelbl.clipsToBounds = true
        
        cell.viewDetail.layer.cornerRadius = 10
        cell.viewDetail.clipsToBounds = true
        
        // MARK : Action detail of view booking uibutton
        cell.viewDetail.tag = indexPath.row
        cell.viewDetail.addTarget(self, action: #selector(self.viewDetailAction), for: .touchUpInside)
        
        let userDic = bookingdata[indexPath.row] as! [String : Any]
        
        
        // MARK : location
        let pickupLocation = userDic["pickLocation"] as! String
        
        let dropOffLocation = userDic["dropLocation"] as! String
        
        cell.bothLocationlbl.text = "\(pickupLocation) - \(dropOffLocation)"
        
        // MARK : date Pick up
        let pickDate = userDic["pickDate"] as! String
        cell.fromDatelbl.text = pickDate
        
        // MARK : date drop off date
        let dropdate = userDic["dropDate"] as! String
        cell.toDatelbl.text = dropdate
        
        //MARK : price
        let price = userDic["spFare"] as! String
        cell.pricelbl.text = "₹ \(price)"
        
        
        return cell
    }
    
    // MARK : height of cell
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 216
    }
    
    // MARK : for animation
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        //MARK : animation 2
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        UIView.animate(withDuration: 0.75) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
        
    }
    
    // MARK : Action of View detail uibutton
    @objc func viewDetailAction(Sender : UIButton)
    {
        let userDic = bookingdata[Sender.tag] as! [String : Any]
        
        let bookID = userDic["book_id"] as! String
        
        let pickupLocation = userDic["pickLocation"] as! String
        
        let dropOffLocation = userDic["dropLocation"] as! String
        
         let pickDate = userDic["pickDate"] as! String
        
        let dropdate = userDic["dropDate"] as! String
        
        let price = userDic["spFare"] as! String
        
        let totalKm = userDic["totalKM"] as! String
        
        
        let stb = self.storyboard?.instantiateViewController(withIdentifier: "BookingDetailVC") as! BookingDetailVC
        
        stb.bookID = bookID
        stb.PickPlace = pickupLocation
        stb.dropPlace = dropOffLocation
        stb.pickdate = pickDate
        stb.dropDate = dropdate
        stb.priceSP = price
        stb.totalKM = totalKm
        self.navigationController?.pushViewController(stb, animated: true)
        
        
    }
    
    
}

