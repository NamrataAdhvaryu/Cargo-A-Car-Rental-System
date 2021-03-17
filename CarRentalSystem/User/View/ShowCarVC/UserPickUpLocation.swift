//
//  UserPickUpLocation.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 29/07/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit
import MapKit

protocol pickUpLocationDelegate {
    func passdataBackPickUp(pickUp : String,latitude : Double,longitude : Double)
    
}


class UserPickUpLocation: UIViewController,UISearchBarDelegate {

    @IBOutlet weak var mapKitOutlet: MKMapView!
     var locationManager = CLLocationManager()
    
    // for pass data back pick up location
    var delegate : pickUpLocationDelegate?
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    
    
    var SelectPickUpLocation = ""
    var Latitude : Double = 0.0
    var Longitude : Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBarOutlet.delegate = self
        design()
        
    }
    func design()
    {
        mainView.layer.cornerRadius = 10
        mainView.clipsToBounds = true
        mainView.layer.borderWidth = 1
        mainView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        
        searchView.layer.cornerRadius = 10
        searchView.clipsToBounds = true
        
        
        saveBtn.layer.cornerRadius = 10
        saveBtn.clipsToBounds = true
    }
    
    
    // MARK : Search Bar delegate method
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBarOutlet.resignFirstResponder()
        let geocorder = CLGeocoder()
        geocorder.geocodeAddressString(searchBarOutlet.text!) { (placemarks, err) in
            
            if err == nil{
                
                let placemark = placemarks?.first
                let annonation = MKPointAnnotation()
                annonation.coordinate = (placemark?.location?.coordinate)!
                annonation.title = searchBar.text
                
                let span = MKCoordinateSpan(latitudeDelta: 0.075, longitudeDelta: 0.075)
                
                let region = MKCoordinateRegion(center: annonation.coordinate, span: span)
                
                self.mapKitOutlet.setRegion(region, animated: true)
                self.mapKitOutlet.addAnnotation(annonation)
                self.mapKitOutlet.selectAnnotation(annonation, animated: true)
                print("Location : \(searchBar.text!)")
               let latitude =  region.center.latitude
                let longitute = region.center.longitude
                print(latitude)
                print(longitute)
                
                self.SelectPickUpLocation = searchBar.text!
                self.Latitude = latitude
                self.Longitude = longitute
                
            }
            else
            {
                alert.commonAlert(Msg: "Can not get your cuurent location", uiVC: self)
            }
        }
    }

    @IBAction func saveBtnClick(_ sender: Any) {
        
        
        delegate?.passdataBackPickUp(pickUp: SelectPickUpLocation, latitude: Latitude, longitude: Longitude)
        navigateObj.navigationCommonPop(uiViewController: self)
    }
    
    @IBAction func back(_ sender: Any) {
        
        navigateObj.navigationCommonPop(uiViewController: self)
    }
    
}

