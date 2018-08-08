//
//  OSSearchViewController.swift
//  OPENSPOT
//
//  Created by Ahmed Durrani on 17/03/2018.
//  Copyright © 2018 TechEase Solution. All rights reserved.
//

import UIKit
import Daysquare


protocol FindSpotDelegate {
    func isChangeFilterClicked(date : String? , timeFrom : String? , timeTo : String? , duration: String? , selectSport : String?)
}

class OSSearchViewController: UIViewController , FSCalendarDataSource, FSCalendarDelegate, UIGestureRecognizerDelegate {
    
    let ap = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var calendar: FSCalendar!
    
    var checkDate : String?
    var checkTime : String?
    var checkDuration : String?
    var checkSport : String?
    var checkDateSelet : String?
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        [unowned self] in
        let panGesture = UIPanGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handleScopeGesture(_:)))
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
        }()
    
    
    @IBOutlet weak var heightOfView: NSLayoutConstraint!
    
    var delegate: FindSpotDelegate?
    
    @IBOutlet var topConstraintOfView: NSLayoutConstraint!
    @IBOutlet var calenderView: DAYCalendarView!
    @IBOutlet var datePicker: UIDatePicker!
    var selectVC : Int?
    
    @IBOutlet var lblMorning: UILabel!
    @IBOutlet var lblNoon: UILabel!
    @IBOutlet var lblAfterNoon: UILabel!

    @IBOutlet var txtLblMorning: UILabel!
    @IBOutlet var txtlblNoon: UILabel!
    @IBOutlet var txtAfterNoon: UILabel!


    @IBOutlet var btnMorning: UIButton!
    @IBOutlet var btnNoon: UIButton!
    @IBOutlet var btnAfterNoon: UIButton!
    
    @IBOutlet var btnFootbal: UIButton!
    @IBOutlet var btnBAsketBAll: UIButton!

    @IBOutlet var btnTennis: UIButton!

    @IBOutlet var btnThirtyMint_Pressed: UIButton!
    @IBOutlet var btnSixtyyMint_Pressed: UIButton!

    @IBOutlet var btnNintyMint_Pressed: UIButton!

    @IBOutlet var viewOFMorning: UIView!
    @IBOutlet var viewONoon: UIView!
    @IBOutlet var viewOFAfterNoon: UIView!

    // Local Variable
    
    var selectDate : String?
    var selectTimeFrom : String?
    var selectTimeTo : String?
    var selectDuration : String?
    var selectSport : String?
    var selectedSlot : String?
//    var selectDateInWeek : String?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if selectVC == 0 {
            topConstraintOfView.constant = 5
            
        } else {
            topConstraintOfView.constant = 50

        }
        
        if UIDevice.current.model.hasPrefix("iPad") {
            self.calendarHeightConstraint.constant = 400
        }
        
//        selectDate = nil
        if ap.selectedDate == nil {
            self.calendar.select(Date())
            self.view.addGestureRecognizer(self.scopeGesture)
            self.calendar.scope = .week
            self.calendar.accessibilityIdentifier = "calendar"

        } else {
//            self.calendar.select(Date())
            
            self.view.addGestureRecognizer(self.scopeGesture)
            self.calendar.scope = .week
            
            calendar.select(self.dateFormatter.date(from: ap.selectedDate!))
            self.calendar.accessibilityIdentifier = "calendar"
            selectDate = ap.selectedDate

        }
        
//        let date = NSDate()

//        self.calendar.minimumDate = date
        
    }
    
    deinit {
        print("\(#function)")
    }
    
  
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter.string(from: date))")
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        let dayOfWeek = getDayNameBy(stringDate: selectedDates[0])
        selectDate = selectedDates[0]
        checkDateSelet = selectedDates[0]
        ap.selectDateInWeek = dayOfWeek
        
//        ap.selectedString = dayOfWeek
        self.selectDate = dayOfWeek
        if ap.selectedString == "" {
            ap.selectedString  = "\(dayOfWeek)"
        } else {
            ap.selectedString = "\(ap.selectedString),\(dayOfWeek)"
            
        }

        

        
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.dateFormatter.string(from: calendar.currentPage))")
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()

    }


    
    func getDayNameBy(stringDate: String) -> String
    {
        let df  = DateFormatter()
        df.dateFormat = "YYYY-MM-dd"
        let date = df.date(from: stringDate)!
        df.dateFormat = "EEEE"
        return df.string(from: date);
    }

    
    @IBAction func btnCross_Pressed(_ sender: UIButton) {
        
        self.dismiss(animated: false) {
            
        }
//        self.navigationController?.popViewController(animated: true)

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnMorning_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        selectedSlot = "Morning"
        ap.morningOrNoon = "Morning"
        self.checkTime = "Morning"

        ap.selectShift = 1
        if sender.isSelected == true {
            self.viewOFMorning.backgroundColor = UIColor(red: 24/255.0, green: 163/255.0, blue: 50/255.0, alpha: 1.0)
            self.viewONoon.backgroundColor = UIColor.white
            self.viewOFAfterNoon.backgroundColor = UIColor.white
            self.lblMorning.textColor = UIColor.white
            self.lblNoon.textColor = UIColor.lightGray
            self.lblAfterNoon.textColor = UIColor.lightGray
            self.txtLblMorning.textColor = UIColor.white
            self.txtlblNoon.textColor = UIColor.lightGray
            self.txtAfterNoon.textColor = UIColor.lightGray
            btnMorning.isSelected = true
            btnNoon.isSelected = false
            btnAfterNoon.isSelected = false
            
            selectTimeFrom = "7:00 am"
            selectTimeTo = "11:00 am"
//            let dict = [ "TimeFrom"         : selectTimeFrom!,
//                         "TimeTo"           : selectTimeTo!
//                ] as [String : Any]
            
            ap.selectTimeFromOrTo = "\(selectTimeFrom!) to \(selectTimeTo!)"
            
//           ap.selectedString = "\(ap.selectedString), \(ap.selectTimeFromOrTo!)"
            
            if ap.selectedString == "" {
                ap.selectedString  = "\(ap.selectTimeFromOrTo!)"
            } else {
                ap.selectedString = "\(ap.selectedString),\(ap.selectTimeFromOrTo!)"
                
            }
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showValue"), object: nil, userInfo: dict)
        }
        else {
            self.viewOFMorning.backgroundColor = UIColor.white
            self.viewONoon.backgroundColor = UIColor.white
            self.viewOFAfterNoon.backgroundColor = UIColor.white
            self.lblMorning.textColor = UIColor.lightGray
            self.lblNoon.textColor = UIColor.lightGray
            self.lblAfterNoon.textColor = UIColor.lightGray
         
            self.txtLblMorning.textColor = UIColor.lightGray
            self.txtlblNoon.textColor = UIColor.lightGray
            self.txtAfterNoon.textColor = UIColor.lightGray
            selectTimeFrom = " "
            selectTimeTo = ""



        }
        
    }
    @IBAction func btnNoon_Pressed(_ sender: UIButton) {
        
        ap.selectShift = 2
        selectedSlot = "Noon"
        ap.morningOrNoon = "Noon"
        self.checkTime = "Noon"

        sender.isSelected = !sender.isSelected
        if sender.isSelected == true {
            
            self.viewONoon.backgroundColor = UIColor(red: 24/255.0, green: 163/255.0, blue: 50/255.0, alpha: 1.0)
            self.viewOFMorning.backgroundColor = UIColor.white
            self.viewOFAfterNoon.backgroundColor = UIColor.white
            
            self.lblNoon.textColor = UIColor.white
            self.lblMorning.textColor = UIColor.lightGray
            self.lblAfterNoon.textColor = UIColor.lightGray
            self.txtlblNoon.textColor = UIColor.white
            self.txtLblMorning.textColor = UIColor.lightGray
            self.txtAfterNoon.textColor = UIColor.lightGray
            btnMorning.isSelected = false
            btnNoon.isSelected = true
            btnAfterNoon.isSelected = false
            selectTimeFrom = "12:00 am"
            selectTimeTo = "2:00 am"
            
            ap.selectTimeFromOrTo = "\(selectTimeFrom!) to \(selectTimeTo!)"
            
//            ap.selectedString = "\(ap.selectedString), \(ap.selectTimeFromOrTo!)"
            
            if ap.selectedString == "" {
                ap.selectedString  = "\(ap.selectTimeFromOrTo!)"
            } else {
                ap.selectedString = "\(ap.selectedString), \(ap.selectTimeFromOrTo!)"
                
            }

//            let dict = [ "TimeFrom"         : selectTimeFrom!,
//                         "TimeTo"      : selectTimeTo!
//                ] as [String : Any]
//
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showValue"), object: nil, userInfo: dict)
            
            
        }
        else {
            self.viewOFMorning.backgroundColor = UIColor.white
            self.viewONoon.backgroundColor = UIColor.white
            self.viewOFAfterNoon.backgroundColor = UIColor.white
            
            self.lblMorning.textColor = UIColor.lightGray
            self.lblNoon.textColor = UIColor.lightGray
            self.lblAfterNoon.textColor = UIColor.lightGray
            
            self.txtLblMorning.textColor = UIColor.lightGray
            self.txtlblNoon.textColor = UIColor.lightGray
            self.txtAfterNoon.textColor = UIColor.lightGray
            selectTimeFrom = " "
            selectTimeTo = ""

        }

    }
    
    @IBAction func btnAfterNoon_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        selectedSlot = "AfterNoon"
        
        ap.morningOrNoon = "AfterNoon"
        ap.selectShift = 3
        self.checkTime = "AfterNoon"

        if sender.isSelected == true {
            
            self.viewOFAfterNoon.backgroundColor = UIColor(red: 24/255.0, green: 163/255.0, blue: 50/255.0, alpha: 1.0)
            self.viewOFMorning.backgroundColor = UIColor.white
            self.viewONoon.backgroundColor = UIColor.white
          
            self.lblNoon.textColor = UIColor.lightGray
            self.lblMorning.textColor = UIColor.lightGray
            self.lblAfterNoon.textColor = UIColor.white
            self.txtlblNoon.textColor = UIColor.lightGray
            self.txtLblMorning.textColor = UIColor.lightGray
            self.txtAfterNoon.textColor = UIColor.white
            btnMorning.isSelected = false
            btnNoon.isSelected = false
            btnAfterNoon.isSelected = true
            selectTimeFrom = "3:00 pm"
            selectTimeTo = "5:00 pm"
            
            ap.selectTimeFromOrTo = "\(selectTimeFrom!) to \(selectTimeTo!)"
            
            if ap.selectedString == "" {
                ap.selectedString  = "\(ap.selectTimeFromOrTo!)"
            } else {
                ap.selectedString = "\(ap.selectedString), \(ap.selectTimeFromOrTo!)"

            }


            
//            let dict = [ "TimeFrom"         : selectTimeFrom!,
//                         "TimeTo"      : selectTimeTo!
//                ] as [String : Any]
//
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showValue"), object: nil, userInfo: dict)

            
        }
        else {
            self.viewOFMorning.backgroundColor = UIColor.white
            self.viewONoon.backgroundColor = UIColor.white
            self.viewOFAfterNoon.backgroundColor = UIColor.white
            self.lblMorning.textColor = UIColor.lightGray
            self.lblNoon.textColor = UIColor.lightGray
            self.lblAfterNoon.textColor = UIColor.lightGray
            
            self.txtLblMorning.textColor = UIColor.lightGray
            self.txtlblNoon.textColor = UIColor.lightGray
            self.txtAfterNoon.textColor = UIColor.lightGray
            selectTimeFrom = " "
            selectTimeTo = ""

        }
        

    }
    
    @IBAction func btnThirtyMint_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        btnThirtyMint_Pressed.isSelected = true
        btnSixtyyMint_Pressed.isSelected = false
        btnNintyMint_Pressed.isSelected = false
        
        btnThirtyMint_Pressed.backgroundColor = UIColor(red: 24/255.0, green: 163/255.0, blue: 50/255.0, alpha: 1.0)
        btnSixtyyMint_Pressed.backgroundColor = UIColor.white
        btnNintyMint_Pressed.backgroundColor = UIColor.white
        self.checkDuration = "30"
        selectDuration = "30"
        
        ap.timeDuration = "30"
        
//        ap.selectedString = "\(ap.selectedString), \( ap.timeDuration!)"
        
        if ap.selectedString == "" {
            ap.selectedString  = "\(ap.timeDuration!)"
        } else {
            ap.selectedString = "\(ap.selectedString), \( ap.timeDuration!)"
            
        }

//        let dict = [ "duration"         : selectDuration!
//            ] as [String : Any]
//
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showHour"), object: nil, userInfo: dict)

    }
    
    @IBAction func btnSixtyMint_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        btnThirtyMint_Pressed.isSelected = false
        btnSixtyyMint_Pressed.isSelected = true
        btnNintyMint_Pressed.isSelected = false
        btnSixtyyMint_Pressed.backgroundColor = UIColor(red: 24/255.0, green: 163/255.0, blue: 50/255.0, alpha: 1.0)
        btnThirtyMint_Pressed.backgroundColor = UIColor.white
        btnNintyMint_Pressed.backgroundColor = UIColor.white
        selectDuration = "60"
        ap.timeDuration = "60"
        self.checkDuration = "60"

        if ap.selectedString == "" {
            ap.selectedString  = "\(ap.timeDuration!)"
        } else {
            ap.selectedString = "\(ap.selectedString), \( ap.timeDuration!)"
            
        }


    }
    
    @IBAction func btnNintyMint_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        btnThirtyMint_Pressed.isSelected = false
        btnSixtyyMint_Pressed.isSelected = false
        btnNintyMint_Pressed.isSelected = true
        btnNintyMint_Pressed.backgroundColor = UIColor(red: 24/255.0, green: 163/255.0, blue: 50/255.0, alpha: 1.0)
        btnThirtyMint_Pressed.backgroundColor = UIColor.white
        btnSixtyyMint_Pressed.backgroundColor = UIColor.white
        selectDuration = "90"
        ap.timeDuration = "90"
        self.checkDuration = "90"

//        ap.selectedString = "\(ap.selectedString), \( ap.timeDuration!)"
        
        if ap.selectedString == "" {
            ap.selectedString  = "\(ap.timeDuration!)"
        } else {
            ap.selectedString = "\(ap.selectedString), \( ap.timeDuration!)"

        }

//        let dict = [ "duration"         : selectDuration!
//            ] as [String : Any]
//
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showHour"), object: nil, userInfo: dict)



        

    }
    
    @IBAction func btnFootBall_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        btnFootbal.isSelected = true
        btnBAsketBAll.isSelected = false
        btnTennis.isSelected = false

        btnFootbal.backgroundColor = UIColor(red: 24/255.0, green: 163/255.0, blue: 50/255.0, alpha: 1.0)
        btnBAsketBAll.backgroundColor = UIColor.white
        btnTennis.backgroundColor = UIColor.white
        selectSport = "Football"
        ap.sportSelect = "Football"
        self.checkSport = "Football"

//        ap.selectedString = "\(ap.selectedString), \( ap.sportSelect!)"
        
        
        if ap.selectedString == "" {
            ap.selectedString  = "\(ap.sportSelect!)"
        } else {
            ap.selectedString = "\(ap.selectedString), \(ap.sportSelect!)"
            
        }

//        let dict = [ "sport"         : selectSport!
//            ] as [String : Any]
//
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sportSelect"), object: nil, userInfo: dict)



    }
    @IBAction func btnBAsketBAll_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        btnBAsketBAll.backgroundColor = UIColor(red: 24/255.0, green: 163/255.0, blue: 50/255.0, alpha: 1.0)
        btnFootbal.backgroundColor = UIColor.white
        btnTennis.backgroundColor = UIColor.white
        btnFootbal.isSelected = false
        btnBAsketBAll.isSelected = true
        btnTennis.isSelected = false
        selectSport = "Basketball"
        ap.sportSelect = "Basketball"
        self.checkSport = "Basketball"

        
        if ap.selectedString == "" {
            ap.selectedString  = "\(ap.sportSelect!)"
        } else {
            ap.selectedString = "\(ap.selectedString), \(ap.sportSelect!)"
            
        }
//        ap.selectedString = "\(ap.selectedString), \( ap.sportSelect!)"


//        let dict = [ "sport"         : selectSport!
//            ] as [String : Any]
//
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sportSelect"), object: nil, userInfo: dict)




    }
    @IBAction func btnTennis_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        btnTennis.backgroundColor = UIColor(red: 24/255.0, green: 163/255.0, blue: 50/255.0, alpha: 1.0)
        btnFootbal.backgroundColor = UIColor.white
        btnBAsketBAll.backgroundColor = UIColor.white
        btnFootbal.isSelected = false
        btnBAsketBAll.isSelected = false
        btnTennis.isSelected = true
        selectSport = "Tennis"
        ap.sportSelect = "Tennis"
        self.checkSport = "Tennis"

        if ap.selectedString == "" {
            ap.selectedString  = "\(ap.sportSelect!)"
        } else {
            ap.selectedString = "\(ap.selectedString), \(ap.sportSelect!)"

        }


    }
    
    @IBAction func btnFindASpot_Pressed(_ sender: UIButton) {
        var isDateSelect : String?
        var isTimeSlot : String?
        var isDuration  : String?
        var isSportSelect  : String?
        
        
        var allString : String?
        
        if ap.selectDateInWeek == nil {
            isDateSelect = " "
        } else {
            isDateSelect = self.checkDateSelet
            allString = isDateSelect!
        }
        if self.selectedSlot == nil {
            isTimeSlot = " "
        } else {
            isTimeSlot = self.selectedSlot
        }
       
        if self.selectDuration == nil {
            isDuration = " "
        } else {
            isDuration = self.selectDuration
        }
        if self.selectSport == nil {
            isSportSelect = " "
        } else {
            isSportSelect = self.selectSport
        }
        
        if  self.ap.selectDateInWeek == nil &&  self.ap.morningOrNoon == nil &&  self.ap.timeDuration == nil &&  self.ap.sportSelect == nil {
                self.showAlert(title: "OPEN SPOT", message: "You must be select Option", controller: self)
        } else {
            self.dismiss(animated: true) {
                   self.delegate?.isChangeFilterClicked(date: isDateSelect!, timeFrom: isTimeSlot!, timeTo: isDateSelect!, duration: isDuration!  , selectSport: isSportSelect!)
            }
         
        }
       


      
        
        
    }
}
