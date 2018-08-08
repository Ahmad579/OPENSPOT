//
//  OSSignUpViewController.swift
//  OPENSPOT
//
//  Created by Ahmed Durrani on 17/03/2018.
//  Copyright © 2018 TechEase Solution. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class OSSignUpViewController: UIViewController {
    
    @IBOutlet var viewOfEmail: CardView!
    @IBOutlet var viewOfPassword: CardView!
    @IBOutlet var viewOfConfirmPass: CardView!

    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtNAme: UITextField!
    @IBOutlet var txtConfirmPass: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        
        txtEmail.addPreviousNextDoneOnKeyboardWithTarget(self, previousAction: #selector(previousAction(_:)), nextAction: #selector(nextAction(_:)), doneAction: #selector(doneAction(_:)))
        txtNAme.addPreviousNextDoneOnKeyboardWithTarget(self, previousAction: #selector(previousAction(_:)), nextAction: #selector(nextAction(_:)), doneAction: #selector(doneAction(_:)))
        
        txtConfirmPass.addPreviousNextDoneOnKeyboardWithTarget(self, previousAction: #selector(previousAction(_:)), nextAction: #selector(nextAction(_:)), doneAction: #selector(doneAction(_:)))

        UtilityHelper.setViewBorder(viewOfEmail, withWidth: 0.4, andColor: UIColor(red: 24/255.0, green: 163/255.0, blue: 50/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(viewOfPassword, withWidth: 0.4, andColor: UIColor(red: 24/255.0, green: 163/255.0, blue: 50/255.0, alpha: 1.0))
        UtilityHelper.setViewBorder(viewOfConfirmPass, withWidth: 0.4, andColor: UIColor(red: 24/255.0, green: 163/255.0, blue: 50/255.0, alpha: 1.0))


        // Do any additional setup after loading the view.
    }

    @objc func previousAction(_ sender : UITextField!) {
        if (txtEmail.isFirstResponder)
        {
            txtNAme.becomeFirstResponder()
        }
        else if (txtNAme.isFirstResponder)
        {
            txtConfirmPass.becomeFirstResponder()
        }
        
        
    }
    
    @objc func nextAction(_ sender : UITextField!) {
        
        if (txtEmail.isFirstResponder)
        {
            txtNAme.becomeFirstResponder()
        }
        else if (txtNAme.isFirstResponder)
        {
            txtConfirmPass.becomeFirstResponder()
        }
    }
    
    @objc func doneAction(_ sender : UITextField!) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnAlreadyAccount_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCreateUserThroughSocial_Pressed(_ sender: UIButton) {
        let facebookMangager = SocialMediaManager()
        facebookMangager.facebookSignup(self)
        facebookMangager.successBlock = { (response) -> Void in
        self.signupWebservice(response as! Dictionary)
        }
    }
    
    func signupWebservice(_ params: Dictionary<String, String>) {
        
        let email : String?
        let idOfFb : String?
        let firstName : String?
        let gender  : String?
        let phonenumber : String?
        let deviceType  : String?
        let deviceToken : String?
        let image : String?
        email =  params["data[User][email]"]
        idOfFb =  params["data[User][facebook_id]"]
        firstName =  params["data[User][first_name]"]
        gender     = params["data[User][gender]"]
        deviceType  = params["data[Device][device_type]"]
        deviceToken = "81dc9bdb52d04dc20036dbd8313ed055"
        image = params["data[User][picture]"]
        
        let param = [     "name"                : firstName! ,
                          "email"               :  email!,
                          "provider"            : "Facebook" ,
//                          "provider_id"         : idOfFb! ,
//                          "gender"              : gender!,
//                          "phonenumber"         : " " ,
//                          "device_type"         :deviceType! ,
//                          "device_token"        : deviceToken!,
//                          "image"               :image!
            ] as [String : Any]
        
        
        WebServiceManager.post(params:param as Dictionary<String, AnyObject> , serviceName: SOCIAL_LOGIN, serviceType: "Sign Up", modelType: UserResponse.self, success: { (response) in
            let responseObj = response as! UserResponse
            
            if responseObj.success == true {
                self.showAlertViewWithTitle(title: "OPEN SPOT", message: responseObj.message!, dismissCompletion: {
                    UserDefaults.standard.set(email , forKey: "email")
                    UserDefaults.standard.set(responseObj.data?.id , forKey: "id")
                    self.navigationController?.popViewController(animated: true)
                })
            
//                self.appDelegate.loadSideMenu()
                
            } else {
                self .showAlert(title: "OPEN SPOT", message: responseObj.message! , controller: self)
            }
            
            
            
        }, fail: { (error) in
            self.showAlert(title: "OPEN SPOT", message: error.description , controller: self)
        }, showHUD: true)
    }
    
    @IBAction func btnSignUp_Pressed(_ sender: UIButton) {
        
        let loginParam = [ "email"         : txtEmail.text!,
                           "password"      : txtConfirmPass.text! ,
                           "name"          :  txtNAme.text!
            ] as [String : Any]
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: SIGNUP, serviceType: "Sign Up", modelType: UserResponse.self, success: { (response) in
            let responseObj = response as! UserResponse
            if responseObj.success == true {
                self.showAlertViewWithTitle(title: "OPEN SPOT", message: responseObj.message! , dismissCompletion: {
                    
                    self.navigationController?.popViewController(animated: true)

                })
                
            }else {
                self .showAlert(title: "OPENSPOT", message: responseObj.message! , controller: self)
            }
            
        }, fail: { (error) in
            self.showAlert(title: "OPENSPOT", message: error.description , controller: self)
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
