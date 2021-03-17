//
//  RateUs_VC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 07/09/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit

class RateUs_VC: UIViewController {

    @IBOutlet weak var ratingControllerOutlet: RatingController!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var doneBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        design()
        // Do any additional setup after loading the view.
    }
    // MARK : func for design
    func design()
    {
        mainView.layer.cornerRadius = 15
        mainView.clipsToBounds = true
        
        doneBtn.layer.cornerRadius = 15
        doneBtn.clipsToBounds = true
    }
    
    @IBAction func rateUsButton(_ sender: Any) {
        
        print(ratingControllerOutlet.starsRating)
        
        dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
