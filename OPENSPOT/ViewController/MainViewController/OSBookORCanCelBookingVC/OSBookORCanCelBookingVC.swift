//
//  OSBookORCanCelBookingVC.swift
//  OPENSPOT
//
//  Created by Ahmed Durrani on 21/03/2018.
//  Copyright © 2018 TechEase Solution. All rights reserved.
//

import UIKit

class OSBookORCanCelBookingVC: UIViewController {

    @IBOutlet var lblBookingTime: UILabel!
    @IBOutlet var lblTypeOfSports: UILabel!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var btnAddOrCancel_Pressed: UIButton!
    var selectTime : TimeOFGround?
    var infoOfGround : GetALlGroundObj?
    var isCancelOrBook : Int?
    var timeArray : [TimeOFGround]?
  
    var timeIdOfGround = [Int]()
    var priceOfGround = [String]()
    var startAndEndTime = [String]()
    var totalGroundPrice  = 0
    
    @IBOutlet var lblClubNAme: UILabel!
    @IBOutlet var lblLocation: UILabel!
    

    var cancelBooking : BookingListObject?
    let ap = UIApplication.shared.delegate as! AppDelegate

    var bookingInfo : BookGround?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isCancelOrBook == 1 {
            btnAddOrCancel_Pressed.setTitle("Book Now", for: .normal)
            btnAddOrCancel_Pressed.backgroundColor = UIColor(red: 24/255.0, green: 163/255.0, blue: 50/255.0, alpha: 1.0)
            
            for (_ , groundInfo) in (self.timeArray?.enumerated())!{
               
                timeIdOfGround.append(groundInfo.time_id!)
                priceOfGround.append(groundInfo.price!)
                let timeAlot = (("\(groundInfo.time_from!) \n"))
                
                totalGroundPrice = totalGroundPrice + Int(groundInfo.price!)!
                startAndEndTime.append(timeAlot)
            }
            
            let timing     =  startAndEndTime.map({"\($0)"}).joined(separator: " ")

            let countOfArray = self.timeArray?.count
            let startTime = timeArray![0].time_from
            let endTime  =  timeArray![countOfArray! - 1].time_to
            
            lblBookingTime.text = (("\(startTime!) TO \(endTime!)"))
//            lblBookingTime.text = "\(timing)"
            lblTypeOfSports.text = infoOfGround?.type
            lblPrice.text = "\(totalGroundPrice) QAR"
            lblClubNAme.text = infoOfGround?.name
            lblLocation.text = infoOfGround?.location
        } else {
            btnAddOrCancel_Pressed.setTitle("CANCEL", for: .normal)
            btnAddOrCancel_Pressed.backgroundColor = UIColor(red: 199/255.0, green: 37/255.0, blue: 26/255.0, alpha: 1.0)
            lblBookingTime.text = cancelBooking?.time
            lblTypeOfSports.text = cancelBooking?.type
            lblPrice.text = cancelBooking?.location
            lblClubNAme.text = cancelBooking?.name
            lblLocation.text = cancelBooking?.location

        }
      


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnAddBookingOrCancel(_ sender: UIButton) {

        let param : [String : Any]
        let serviceURL : String?
        if isCancelOrBook == 1 {
            let groundID  = infoOfGround?.idOfGround
            let timeId    =  timeIdOfGround.map({"\($0)"}).joined(separator: ",")
            let price     =  priceOfGround.map({"\($0)"}).joined(separator: ",")
            let userID    = UserDefaults.standard.string(forKey: "id")
            
            if  ap.selectedDate == nil {
                let date = Date()
                let formatter = DateFormatter()
                
                formatter.dateFormat = "yyyy-MM-dd"
                
                ap.selectedDate   = formatter.string(from: date)
            }

            serviceURL = BOOKINGGROUND
            param = [      "ground_id"           : groundID! ,
                           "user_id"             : userID! ,
                           "time_id"             : timeId ,
                           "price"               : price ,
                           "date"                : ap.selectedDate!
                    ]
            
        } else {
            let bookingID       = cancelBooking?.booking_ids
            let dateOfBooking   = cancelBooking?.date

            serviceURL = CANCELBOOKING
            param = [      "booking_ids"           : bookingID! ,
                           "date"                  : dateOfBooking!
                    ]

        }
        WebServiceManager.post(params: param as Dictionary<String, AnyObject> , serviceName: serviceURL!, serviceType: "User Like Or Dislike" , modelType: BookGround.self, success: { (response) in
            self.bookingInfo = (response as! BookGround)
            if  self.bookingInfo?.success == true {
                if self.isCancelOrBook == 1 {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "OSBookingConfirm") as? OSBookingConfirm
                    vc?.infoOfBooking = self.bookingInfo
                    vc?.totalPriceOFGrounds = self.totalGroundPrice
                    vc?.timeArray = self.timeArray

                    self.navigationController?.pushViewController(vc!, animated: true)
                } else {
                    self.navigationController?.popToRootViewController(animated: true)

                }
                
                
            } else  {
                self.showAlert(title: "OPEN SPOT", message: (self.bookingInfo?.message)!, controller: self)
            }
            
            
            
        }, fail: { (error) in
            self.showAlert(title: "OPEN SPOT", message: error.description , controller: self)
        }, showHUD: true)
        
        
    }
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
