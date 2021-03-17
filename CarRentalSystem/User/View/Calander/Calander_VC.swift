//
//  Calander_VC.swift
//  CarRentalSystem
//
//  Created by Namrata Akash on 27/08/20.
//  Copyright © 2020 Namrata Akash. All rights reserved.
//

import UIKit
import FSCalendar

protocol dateRangeDelegate
{
    func dateRange(dateArr: [Any])
}

class Calander_VC: UIViewController,FSCalendarDelegate,FSCalendarDataSource {

    // for pass data back pick up location
    var delegate : dateRangeDelegate?

    @IBOutlet weak var doneBTN: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var subview: UIView!
    // MARK : outelt of FS calander
    var calender : FSCalendar!
    var formatter = DateFormatter()
    
    var DateRange = [Any]();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        design()
        fscal()
        
    }
    
    func design()
    {
        mainView.clipsToBounds = true
        mainView.layer.cornerRadius = 10
        
        doneBTN.clipsToBounds = true
        doneBTN.layer.cornerRadius = 10
        
        
    }
    
    // MARK : create fscalender
    func fscal()
    {
        calender = FSCalendar(frame: self.subview.bounds)
        calender.scrollDirection = .horizontal
        self.subview.addSubview(calender)
        
        calender.delegate = self
        calender.dataSource = self
        calender.allowsMultipleSelection = true
    }
    
    // MARK : delegate method of fscalnder
    
    // mark : select date
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        formatter.dateStyle = .long
        
        for d in calendar.selectedDates
        {
            DateRange.append(d)
            //print(calendar.selectedDates)
            calendar.deselect(d)
            
            //print(DateRange)
        }
        
    }
    
    
    // MARK : deselect date
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        calendar.deselect(date)
        calendar.reloadData()
        
    }
    
    // if selected date is less than current date then unselected that perticuler date
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        
        return Date()
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        
       if calendar.selectedDates.contains(date)
       {
            return UIColor.green
        }
        
        return appearance.selectionColor
    }
   
    // MARK : NEW button click
    
    @IBAction func buttonClick(_ sender: Any)
    {
        delegate?.dateRange(dateArr: DateRange)
       dismiss(animated: true, completion: nil)

    }
    
}



