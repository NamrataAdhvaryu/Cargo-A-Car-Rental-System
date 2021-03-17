//
//  UserBookVC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 15/06/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

var pickUpdate = "";
var dropOffdate = "";

var selecteddate = [Any]();

class UserBookVC: UIViewController{
    

    @IBOutlet weak var uiviewFromDate: UIView!
    @IBOutlet weak var uiviewToDate: UIView!
    @IBOutlet weak var txtFromDate: UILabel!
    @IBOutlet weak var txtToDate: UILabel!
    @IBOutlet weak var reselectBtn: UIButton!
    
    @IBOutlet weak var searchBtnClick: UIButton!
    var formatter = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designControllrs()
        reselectBtn.isHidden = true

    }
    
    func designControllrs()
    {
        uiviewFromDate.layer.cornerRadius = 10
        uiviewFromDate.clipsToBounds = true
        uiviewFromDate.layer.borderWidth = 1
        uiviewFromDate.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3687555018)
        
        uiviewToDate.layer.cornerRadius = 10
        uiviewToDate.clipsToBounds = true
        uiviewToDate.layer.borderWidth = 1
        uiviewToDate.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3687555018)
        
        txtFromDate.layer.cornerRadius = 10
        txtFromDate.clipsToBounds = true
       
        txtToDate.layer.cornerRadius = 10
        txtToDate.clipsToBounds = true
        
        searchBtnClick.layer.cornerRadius = 10
        searchBtnClick.clipsToBounds = true
        
    }
   
    @IBAction func SEARCHAction(_ sender: Any) {
        
        if searchBtnClick.titleLabel?.text == "Select Date"
        {
            let stb = self.storyboard?.instantiateViewController(withIdentifier: "Calander_VC") as! Calander_VC
            
            stb.delegate = self
            stb.modalPresentationStyle = .popover
            
            self.present(stb, animated: false, completion: nil)
            
            searchBtnClick.setTitle("SEARCH", for: .normal)
            reselectBtn.isHidden = false
            
        }
        else
        {
            if txtFromDate.text == "" && txtToDate.text == ""
            {
                alert.commonAlert(Msg: "Please Select Date", uiVC: self)
            }
            else
            {
                navigateObj.navigationCommonPush(uiViewController: self, identifier: "UserShowcarVC")
                
            }
        }
    }
    
    @IBAction func clickOfReselect(_ sender: Any) {
        
        let stb = self.storyboard?.instantiateViewController(withIdentifier: "Calander_VC") as! Calander_VC
        
        stb.delegate = self
        stb.modalPresentationStyle = .popover
        
        self.present(stb, animated: false, completion: nil)
    }
    
    @IBAction func back(_ sender: Any) {
        
        navigateObj.navigationCommonPop(uiViewController: self)
    }
}
// MARK : GET DATA FROM THE POPUP VIEW CONTROLLER
extension UserBookVC : dateRangeDelegate
{
    func dateRange(dateArr: [Any]) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        selecteddate = dateArr
        print(selecteddate)
        
        print(selecteddate)
        
        let date1 = formatter.string(from: dateArr.first as! Date)
        txtFromDate.text = "    \(date1)"
        pickUpdate = date1
        
        let date2 = formatter.string(from: dateArr.last as! Date)
        txtToDate.text = "    \(date2)"
        dropOffdate = date2
    
    }
}
