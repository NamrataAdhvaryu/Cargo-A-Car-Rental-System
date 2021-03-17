//
//  UserDropOffLocation.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 29/07/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit
import MapKit

// MARK : create protocol for pass drop off location
protocol dropOffLocationDelegate {
    
    func passDataBackdropOff(dropOff : String,Dlatitude : Double,Dlongitude : Double)
}


class UserDropOffLocation: UIViewController,UISearchBarDelegate {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var mapViewOutlet: MKMapView!
    
    // MARK : for saved drop off location from the search bar
    var SelectedDropOffLocation = ""
    var dropLatitude : Double = 0.0
    var droplongitude : Double = 0.0
    
    // MARK : create this for instance of protocol which we create "dropoffLocationDelegate"
    var delegate : dropOffLocationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        design()
       
    }
    
    //MARK : desgin of controllers
    func design()
    {
        mainView.layer.cornerRadius = 10
        mainView.clipsToBounds = true
        mainView.layer.borderWidth = 1
        mainView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        saveBtn.layer.cornerRadius = 10
        saveBtn.clipsToBounds = true
    }
    
    
    // MARK :- Serachbar delegate method
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        let geocorder = CLGeocoder()
        geocorder.geocodeAddressString(searchBar.text!) { (placemarks, err) in
            
            if err == nil
            {
                let placemark = placemarks?.first
                let annotation = MKPointAnnotation()
                annotation.coordinate = (placemark?.location?.coordinate)!
                annotation.title = searchBar.text!
                
                let span = MKCoordinateSpan(latitudeDelta: 0.075, longitudeDelta: 0.075)
                let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
                
                self.mapViewOutlet.setRegion(region, animated: true )
                self.mapViewOutlet.addAnnotation(annotation)
                self.mapViewOutlet.selectAnnotation(annotation, animated: true)
                
                print("LOcation: \(searchBar.text!)")
                let latitude = region.center.latitude
                let longitute = region.center.longitude
                print(latitude)
                print(longitute)
                self.SelectedDropOffLocation = searchBar.text!
                self.dropLatitude = latitude
                self.droplongitude = longitute
                
            
            }
            else
            {
                print("No internet")
                print(err?.localizedDescription ?? "Error")
            }
        }

    }
    // MARK : Action of save button
    @IBAction func saveBtnClick(_ sender: Any) {
        
        delegate?.passDataBackdropOff(dropOff: SelectedDropOffLocation, Dlatitude: dropLatitude, Dlongitude: droplongitude)
        navigateObj.navigationCommonPop(uiViewController: self)
        
    }
    
    // MARK : action of back button in navigation bar
    @IBAction func backAction(_ sender: Any) {
        
        navigateObj.navigationCommonPop(uiViewController: self)
    }
    
}
