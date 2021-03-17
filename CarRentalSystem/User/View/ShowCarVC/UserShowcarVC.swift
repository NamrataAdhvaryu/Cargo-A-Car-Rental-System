//
//  UserShowcarVC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 16/06/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit


import UILoadControl

class UserShowcarVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UISearchBarDelegate{
    
    
    
    @IBOutlet weak var searchOutlet: UISearchBar!
    // array for store search value
    
    var searchArr = [Any]()
    var flag : Bool = false
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if flag == true
        {
            return searchArr.count
        }
        else
        {
            return carData.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowCarTableCell1", for: indexPath) as! ShowCarTableCell1
        
        
        cell.layer.cornerRadius = 30
        cell.bookstatusBtn.isHidden = true
       
    if flag == true
    {
        
        cell.ContinueBtn.tag = indexPath.row
        
        let dic = searchArr[indexPath.row] as? [String : Any]
        
        //for name
        let name = dic!["car_name"] as? String
        let model = dic!["car_model"] as? String
        let modelNo = dic!["car_modelNo"] as? String
        
        cell.carNameOutlet.text = " \(name!) \(model!) \(modelNo!)"
        
        // for passanger capacity
        
        let passanger = dic!["car_passCapacity"] as? String
        cell.pasangerLbl.text = passanger
        
        
        // for ac
        let ac = dic!["car_AC"] as? String
        cell.acLable.text = ac
        
        // for transmisson
        let insurance = dic!["car_insurance"] as? String
        cell.insuranceLabel.text = insurance
        
        // for steering
        let steering = dic!["car_SteeringType"] as? String
        cell.streeingLable.text = steering
        
        // for image
        let imgpath = dic!["car_image"] as? String
        let fullpath = "\(commConst.baseUrl)\(imgpath!)";
        let url = URL(string: fullpath)
        do
        {
            let data = try Data(contentsOf: url!)
            cell.carImageOutlet.image = UIImage(data: data)
        }
        catch
        {
            print("Error in downloading image")
        }
        
        // MARK : for car booked status
        let bookStatus = dic!["car_bookedStatus"] as! String
        if bookStatus == "Booked"
        {
            cell.bookstatusBtn.isHidden = false
            cell.ContinueBtn.titleLabel?.text = "Booked";
            cell.ContinueBtn.isEnabled = false
            cell.ContinueBtn.alpha = 0.5
            
        }
        
        //cell.ContinueBtn.tag = indexPath.row
        cell.ContinueBtn.addTarget(self, action: #selector(self.ContinueBtnTap), for: .touchUpInside)
    }
        else
    {
        
        cell.ContinueBtn.tag = indexPath.row
        
        let dic = carData[indexPath.row] as? [String : Any]
        
        
        //for name
        let name = dic!["car_name"] as? String
        let model = dic!["car_model"] as? String
        let modelNo = dic!["car_modelNo"] as? String
        
        cell.carNameOutlet.text = " \(name!) \(model!) \(modelNo!)"
        
        // for passanger capacity
        
        let passanger = dic!["car_passCapacity"] as? String
        cell.pasangerLbl.text = passanger
        
        
        // for ac
        let ac = dic!["car_AC"] as? String
        cell.acLable.text = ac
        
        // for transmisson
        let insurance = dic!["car_insurance"] as? String
        cell.insuranceLabel.text = insurance
        
        // for steering
        let steering = dic!["car_SteeringType"] as? String
        cell.streeingLable.text = steering
        
        // for image
        let imgpath = dic!["car_image"] as? String
        let fullpath = "\(commConst.baseUrl)\(imgpath!)";
        let url = URL(string: fullpath)
        do
        {
            let data = try Data(contentsOf: url!)
            cell.carImageOutlet.image = UIImage(data: data)
        }
        catch
        {
            print("Error in downloading image")
        }
        
        // MARK : for car booked status
        let bookStatus = dic!["car_bookedStatus"] as! String
        if bookStatus == "Booked"
        {
            cell.bookstatusBtn.isHidden = false
           cell.ContinueBtn.titleLabel?.text = "Booked";
            cell.ContinueBtn.isEnabled = false
            cell.ContinueBtn.alpha = 0.5
        }
        else
        {
            cell.ContinueBtn.titleLabel?.text = "Continue>>";
            cell.ContinueBtn.isEnabled = true
            cell.ContinueBtn.alpha = 1
        }
        
        cell.ContinueBtn.tag = indexPath.row
        cell.ContinueBtn.addTarget(self, action: #selector(self.ContinueBtnTap), for: .touchUpInside)
        }
        
        
        return cell
    }
    
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 455
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let rotationTransformation = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
        cell.layer.transform = rotationTransformation
        cell.alpha = 0.5
        
        UIView.animate(withDuration: 1.0) {
            
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return 458;
        
    }
    
    

    var carData = [Any]()
    
    @IBOutlet weak var tblOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewCar()
        
        // for load control in tableview
        
        tblOutlet.loadControl = UILoadControl(target: self, action: #selector(self.LoadCOntrol))
        // Do any additional setup after loading the view.
    }
    
// delegate method of uiScrollView
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.loadControl?.update()
    }
    // objc method of load control
    @objc func LoadCOntrol(sender : AnyObject?)
    {
            //... Manage response
            self.tblOutlet.loadControl?.endLoading() //Update UILoadControl frame to the new UIScrollView bottom.
            self.tblOutlet.reloadData()
    }
    
   
   func viewCar()
   {
    
        let url = URL(string: "\(commConst.baseUrl)getAllcar.php")
    
        let request = URLRequest(url: url!)
    
    let session = URLSession.shared;
    let dataTask = session.dataTask(with: request) { (data, resp, err) in
        
       // let readStr = String(data: data!, encoding: String.Encoding.utf8)
       // print(readStr!)
        
        do
        {
            let jsonCarData = try JSONSerialization.jsonObject(with: data!, options: []) as?[Any]
            
            self.carData = jsonCarData!
            
            DispatchQueue.main.async {
                
                self.tblOutlet.reloadData()
            }
            
        }
        catch
        {
            print("error")
        }
        
    }
    dataTask.resume()
   }
    
    // delegate function for searchbar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.characters.count == 0
        {
            flag = false
            tblOutlet.reloadData()
        }
        else
        {
            flag = true
            self.filtertext(searchtext: searchText)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        flag = true
        self.filtertext(searchtext: searchBar.text!)
    }
    
    func filtertext(searchtext : String)
    {
        let namePredicate = NSPredicate(format: "self.car_name contains[c] %@||self.car_model contains[c] %@||self.car_modelNo contains[c] %@||self.car_passCapacity contains[c] %@||self.car_passCapacity contains[c] %@||self.car_AC contains[c] %@||self.car_insurance contains[c] %@||self.car_SteeringType contains[c] %@",searchtext,searchtext,searchtext,searchtext,searchtext,searchtext,searchtext,searchtext)
        
        searchArr = carData.filter{ namePredicate.evaluate(with: $0)
        }
        
        tblOutlet.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        flag = false
        searchBar.text = ""
        self.filtertext(searchtext: searchBar.text!)
    }
    
    // btn action of tableview cell
    // continue btn objc method
    @objc func ContinueBtnTap(sender : UIButton)
    {
        let dic = carData[sender.tag] as! [String : Any]
        let id = dic["car_id"] as! String
       // let bookStatus = dic["car_bookedStatus"] as! String
        
            // navigate to VC "ShowCarContinueVC"
            let stb = self.storyboard?.instantiateViewController(withIdentifier: "ShowCarContinueVC") as! ShowCarContinueVC
            stb.getCarid  = id
            self.navigationController?.pushViewController(stb, animated: true)
            
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        
        navigateObj.navigationCommonPop(uiViewController: self)
    }
    
}



