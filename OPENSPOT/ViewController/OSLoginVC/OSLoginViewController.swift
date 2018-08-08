//
//  OSLoginViewController.swift
//  OPENSPOT
//
//  Created by Ahmed Durrani on 15/03/2018.
//  Copyright © 2018 TechEase Solution. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class OSLoginViewController: UIViewController {
    
    var screenSelect : Int?

    @IBOutlet var viewOfEmail: CardView!
    @IBOutlet var viewOfPassword: CardView!

    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        
        txtEmail.addPreviousNextDoneOnKeyboardWithTarget(self, previousAction: #selector(previousAction(_:)), nextAction: #selector(nextAction(_:)), doneAction: #selector(doneAction(_:)))
        txtPassword.addPreviousNextDoneOnKeyboardWithTarget(self, previousAction: #selector(previousAction(_:)), nextAction: #selector(nextAction(_:)), doneAction: #selector(doneAction(_:)))
        
        UtilityHelper.setViewBorder(viewOfEmail, withWidth: 0.4, andColor: UIColor(red: 24/255.0, green: 163/255.0, blue: 50/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(viewOfPassword, withWidth: 0.4, andColor: UIColor(red: 24/255.0, green: 163/255.0, blue: 50/255.0, alpha: 1.0))
        txtEmail.text = "abdullah@gmail.com"
        txtPassword.text = "abc123"

        
    }
    
    // Mark :- Functions
     @objc func previousAction(_ sender : UITextField!) {
        if (txtEmail.isFirstResponder)
        {
            txtPassword.becomeFirstResponder()
        }
        else if (txtPassword.isFirstResponder)
        {
            txtPassword.becomeFirstResponder()
        }
       
        
    }
    
     @objc func nextAction(_ sender : UITextField!) {
        
        if (txtEmail.isFirstResponder)
        {
            txtPassword.becomeFirstResponder()
        }
        else if (txtPassword.isFirstResponder)
        {
            txtPassword.becomeFirstResponder()
        }
    }
    
     @objc func doneAction(_ sender : UITextField!) {
        self.view.endEditing(true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController()
        
        UIApplication.shared.keyWindow?.rootViewController = vc

    }
    
   
    @IBAction func btnSigIn_Pressed(_ sender: UIButton) {
    //    OPMainViewController
        
        
        let loginParam = [ "email"         : txtEmail.text!,
                           "password"      : txtPassword.text!
            ] as [String : Any]
        //
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: LOGIN, serviceType: "Login", modelType: UserResponse.self, success: { (response) in
            let responseObj = response as! UserResponse
            if responseObj.success == true {
                
                localUserData =  responseObj.data
                UserDefaults.standard.set(self.txtEmail.text! , forKey: "email")
                UserDefaults.standard.set(responseObj.data?.id , forKey: "id")
                UserDefaults.standard.set(self.txtPassword.text , forKey: "pass")
                UserDefaults.standard.set(responseObj.data?.name , forKey: "name")

               
                if self.screenSelect == 1 {
                        self.navigationController?.popViewController(animated: true)
                } else {
                    let vc = UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController()
                    
                    UIApplication.shared.keyWindow?.rootViewController = vc

                }

//                let story = UIStoryboard(name: "Home", bundle: nil)
//                let vc = story.instantiateViewController(withIdentifier: "OPMainViewController")
//                let nav = UINavigationController(rootViewController: vc)
//                nav.isNavigationBarHidden = true
//                UIApplication.shared.keyWindow?.rootViewController = nav
                

            }else {
                self .showAlert(title: "OPENSPOT", message: responseObj.message! , controller: self)
            }
            
        }, fail: { (error) in
            self.showAlert(title: "OPENSPOT", message: error.description , controller: self)
        }, showHUD: true)
     
    
        
       

        
    }
    @IBAction func btnSocialLogin_Pressed(_ sender: UIButton) {
        let facebookMangager = SocialMediaManager()
        facebookMangager.facebookSignup(self)
        facebookMangager.successBlock = { (response) -> Void in
            self.signInWebservice(response as! Dictionary)

      }
    }
    func signInWebservice(_ params: Dictionary<String, String>) {
        
        let email : String?
//        let idOfFb : String?
//        let firstName : String?
//        let gender  : String?
//        let phonenumber : String?
//        let deviceType  : String?
//        let deviceToken : String?
//        let image : String?
          email =  params["data[User][email]"]
//        idOfFb =  params["data[User][facebook_id]"]
//        firstName =  params["data[User][first_name]"]
//        gender     = params["data[User][gender]"]
//        deviceType  = params["data[Device][device_type]"]
//        deviceToken = "81dc9bdb52d04dc20036dbd8313ed055"
//        image = params["data[User][picture]"]
        
        let param = ["email"          :  email!
                    ] as [String : Any]
        
        
        WebServiceManager.post(params:param as Dictionary<String, AnyObject> , serviceName: SOCIALSIGNIN, serviceType: "Login In", modelType: UserResponse.self, success: { (response) in
            let responseObj = response as! UserResponse
            
            if responseObj.success == true {
                UserDefaults.standard.set(responseObj.data?.email , forKey: "email")
                UserDefaults.standard.set(responseObj.data?.id , forKey: "id")
                UserDefaults.standard.set(responseObj.data?.name , forKey: "name")

                let vc = UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController()
                
                UIApplication.shared.keyWindow?.rootViewController = vc

                //                self.appDelegate.loadSideMenu()
                
            } else {
                self .showAlert(title: "OPEN SPOT", message: "You must be sign Up first" , controller: self)
            }
        }, fail: { (error) in
            self.showAlert(title: "OPEN SPOT", message: error.description , controller: self)
        }, showHUD: true)

        
  }
        
        
    @IBAction func btnCreateAccount_Pressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OSSignUpViewController") as? OSSignUpViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
//
    
   
}
