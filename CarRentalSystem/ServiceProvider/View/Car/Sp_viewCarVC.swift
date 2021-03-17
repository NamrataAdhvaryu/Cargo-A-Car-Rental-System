//
//  Sp_viewCarVC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 22/06/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit


class Sp_viewCarVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Sp_viewCarTBCell1", for: indexPath) as! Sp_viewCarTBCell1
        
        // MARK : DESIGN
        
        cell.layer.cornerRadius = 5
        cell.clipsToBounds = true
        cell.layer.borderWidth = 1
        cell.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        cell.imageCar.layer.cornerRadius = 7
        cell.imageCar.clipsToBounds = true
        
        cell.updateCarImg.layer.cornerRadius = 10
        cell.updateCarImg.clipsToBounds = true
        
        //cell.delegate = self
        cell.updateCarImg.tag = indexPath.row
        print(cell.updateCarImg.tag)
        cell.updateCarImg.addTarget(self, action: #selector(self.InfoBtnTap), for: .touchUpInside)
        
        let dic = carData[indexPath.row] as? [String : Any]
        
        //for name
        let name = dic!["car_name"] as? String
        let model = dic!["car_model"] as? String
        let modelNo = dic!["car_modelNo"] as? String
        
        cell.nameLable.text = " \(name!) \(model!) \(modelNo!)"
        
        let imgpath = dic!["car_image"] as! String
        let fullpath = "\(commConst.baseUrl)\(imgpath)"
        let url = URL(string: fullpath)
        do
        {
            let data = try Data(contentsOf: url!)
            cell.imageCar.image = UIImage(data: data)
        }
        catch
        {
            print("error in downloading image")
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 338
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
    
    @IBOutlet weak var tableViewPutlet: UITableView!
    var carData = [Any]()
    @IBOutlet weak var viewDesign: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        viewCar()
        viewDesign.isHidden = true
        tableViewPutlet.isHidden = false
        designCOntroll()
        tableViewPutlet.reloadData()
        
    }
    // MARK : OBJC method for update car image
    @objc func InfoBtnTap(sender : UIButton)
    {
        let dic = carData[sender.tag] as! [String : Any]
        let id = dic["car_id"] as! String
        let stb = self.storyboard?.instantiateViewController(withIdentifier: "SpAddCarImage_VC") as! SpAddCarImage_VC
        
       // stb.car_id = id
        stb.carID = id
       
    self.navigationController?.pushViewController(stb, animated: true)
    }
    func designCOntroll()
    {
        viewDesign.layer.cornerRadius = 10
    }

    @IBAction func addCarBtn(_ sender: Any) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "SpAddCar_VC")
    }
    
    func viewCar()
    {
    
        let ID = UserDefaults.standard.string(forKey: "sp_id")
        
        let url = URL(string: "\(commConst.baseUrl)getSPcar.php?sp_id=\(ID!)")
        
        let request = URLRequest(url: url!)
        
        let session = URLSession.shared;
        let dataTask = session.dataTask(with: request) { (data, resp, err) in
            
           // let readStr = String(data: data!, encoding: String.Encoding.utf8)
            //print(readStr!)
            
            
            do
            {
                let jsonCarData = try JSONSerialization.jsonObject(with: data!, options: []) as?[Any]
                
                print(jsonCarData?.count as Any)
                
                if jsonCarData?.count == 0
                {
                    
                    print("No car Added.")
                    alert.commonAlert(Msg: "No car Added", uiVC: self)
                    
                }
                else
                {
                    DispatchQueue.main.async {
                        
                        self.carData = jsonCarData!
                        
                        let dic = self.carData[0] as! [String : Any]
                        let id = dic["car_id"] as! String
                        print(id)
                        self.tableViewPutlet.reloadData()
                    }
                }
            }
            catch
            {
                print("error")
            }
            
        }
        dataTask.resume()
    }
    
        
    // MARK : for add new car
    @IBAction func addCarImageBtn(_ sender: Any) {
        
        navigateObj.navigationCommonPush(uiViewController: self, identifier: "SpAddCar_VC")
    }
}

