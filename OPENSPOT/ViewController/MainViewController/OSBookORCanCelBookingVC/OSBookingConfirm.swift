//
//  OSBookingConfirm.swift
//  OPENSPOT
//
//  Created by Ahmed Durrani on 21/03/2018.
//  Copyright © 2018 TechEase Solution. All rights reserved.
//

import UIKit

class OSBookingConfirm: UIViewController {

    @IBOutlet var lblNAme: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblTime: UILabel!
    @IBOutlet var lblDuration: UILabel!
    @IBOutlet var lblPRice: UILabel!
    let ap = UIApplication.shared.delegate as! AppDelegate

    var totalPriceOFGrounds : Int?
    var infoOfBooking : BookGround?
    var timeArray : [TimeOFGround]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let countOfArray = infoOfBooking?.groundInfo?.count
        lblNAme.text = infoOfBooking?.groundInfo![0].name
        lblDate.text = infoOfBooking?.groundInfo![0].date
//        lblTime.text = infoOfBooking?.groundInfo![countOfArray! - 1].time
        lblDuration.text = infoOfBooking?.groundInfo![0].duration
        lblPRice.text = "\(totalPriceOFGrounds!)"
        
        let countOfArrayss = self.timeArray?.count
        let startTime = timeArray![0].time_from
        let endTime  =  timeArray![countOfArrayss! - 1].time_to

        lblTime.text = (("\(startTime!) TO \(endTime!)"))

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnDone_Pressed(_ sender: UIButton) {
        ap.selectedDate = nil
        self.navigationController?.popToRootViewController(animated: true)

    }
    

}
