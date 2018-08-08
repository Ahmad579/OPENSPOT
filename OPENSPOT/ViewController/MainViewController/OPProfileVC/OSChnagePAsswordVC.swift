//
//  OSChnagePAsswordVC.swift
//  OPENSPOT
//
//  Created by Ahmed Durrani on 21/03/2018.
//  Copyright © 2018 TechEase Solution. All rights reserved.
//

import UIKit

class OSChnagePAsswordVC: UIViewController {
    
    @IBOutlet var txtPAssword: UITextField!

    var userInfo : UserResponse?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnChangePassword(_ sender: UIButton) {
        
        let userID = UserDefaults.standard.string(forKey: "id")

        let groundParam = [ "user_id"        : userID! ,
                            "password"       : txtPAssword.text!
                        ] as [String : AnyObject]
        
        WebServiceManager.post(params: groundParam , serviceName: CHANGEPASS, serviceType: "Booking List" , modelType: BookingList.self, success: { (response) in
            self.userInfo = (response as! UserResponse)
            
            if  self.userInfo?.success == true {
                self.navigationController?.popToRootViewController(animated: true)
                
            } else {
                self.showAlert(title: "OEPNSPOT", message: (self.userInfo?.message)!, controller: self)
            }
            
            
        }, fail: { (error) in
            
            
            self.showAlert(title: "OEPNSPOT", message: error.description , controller: self)
        }, showHUD: true)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
