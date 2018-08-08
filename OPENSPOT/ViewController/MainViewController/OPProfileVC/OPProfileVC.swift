//
//  OPProfileVC.swift
//  OPENSPOT
//
//  Created by Ahmed Durrani on 17/03/2018.
//  Copyright © 2018 TechEase Solution. All rights reserved.
//

import UIKit

class OPProfileVC: UIViewController {
    var index: Int?

    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblEmail: UILabel!

    @IBOutlet var loginPopView: CardView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let userID = UserDefaults.standard.string(forKey: "id")
        if userID == nil  {
            loginPopView.isHidden = false
            
        } else {
            loginPopView.isHidden = true
            let name = UserDefaults.standard.string(forKey: "name")
            let email = UserDefaults.standard.string(forKey: "email")
            
            
            lblName.text =  name!
            lblEmail.text = email!
        }
        
    }

    @IBAction func btnLoginWithEmail_Pressed(_ sender: UIButton) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "OSLoginViewController") as? OSLoginViewController
        vc?.screenSelect = 1
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @IBAction func btnLoginWithFacebook_PRessed(_ sender: UIButton) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "OSLoginViewController") as? OSLoginViewController
        vc?.screenSelect = 1
        self.navigationController?.pushViewController(vc!, animated: true)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnChangePassword_Pressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OSChnagePAsswordVC") as? OSChnagePAsswordVC
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @IBAction func btnSignOut_Pressed(_ sender: UIButton) {
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        UserDefaults.standard.set(nil  , forKey : "id")
        UserDefaults.standard.set(nil  , forKey : "user_token")
        UserDefaults.standard.set(nil  , forKey : "password")
        UserDefaults.standard.set(nil  , forKey : "email")
        localUserData = nil
//        UIApplication.shared.keyWindow?.rootViewController = vc
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "OSLoginViewController") as? OSLoginViewController
        self.navigationController?.pushViewController(vc!, animated: true)

    }
    
  

}
