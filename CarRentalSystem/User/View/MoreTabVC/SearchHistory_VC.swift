//
//  SearchHistory_VC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 05/09/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

class SearchHistory_VC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tblOutlet: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return history.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "History_TableViewCell", for: indexPath) as! History_TableViewCell
        
        cell.mainView.layer.cornerRadius = 10
        cell.mainView.clipsToBounds = true
        
        let dic = history[indexPath.row] as! [String : Any]
        
        let pickLocation = dic["pickLocation"] as! String
        let dropLocation = dic["dropLocation"] as! String
        let pickDate = dic["pickDate"] as! String
        let dropDate = dic["dropDate"] as! String
        
        cell.pickLocation.text = pickLocation
        cell.dropLocation.text = dropLocation
        cell.pickDate.text = pickDate
        cell.dropDate.text = dropDate
        
        return cell
    }
    
    // MARK : height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 84
    }
    
    

    // MARK : to store booking data
    var history = [Any]();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getBookeddata()
        // Do any additional setup after loading the view.
    }
    
    // MARK : get detail booked data
    func getBookeddata()
    {
        let user = UserDefaults.standard.string(forKey: "user_id")
        
        let url = URL(string: "\(commConst.baseUrl)UserViewBookingData.php?user_id=\(user!)")
        
        let request = URLRequest(url: url!)
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) { (data, resp, err) in
            
            let str = String(data: data!, encoding: String.Encoding.utf8)
            print(str!)
            
            do
            {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [Any]
                self.history = json
                
                if json.count == 0
                {
                    alert.commonAlert(Msg: "No data found", uiVC: self)
                }
                else
                {
                    DispatchQueue.main.async {
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
    // MARK : back
    @IBAction func backarrowBtn(_ sender: Any) {
        
        navigateObj.navigationCommonPop(uiViewController: self)
    }
}

