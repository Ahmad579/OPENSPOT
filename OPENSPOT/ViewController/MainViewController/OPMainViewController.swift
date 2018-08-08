//
//  OPMainViewController.swift
//  OPENSPOT
//
//  Created by Ahmed Durrani on 17/03/2018.
//  Copyright © 2018 TechEase Solution. All rights reserved.
//

import UIKit

class OPMainViewController: UIViewController {

    var previousVC: UIViewController?
    var showingIndex: Int = 0
    var pageVC: UIPageViewController?
    @IBOutlet var viewBottom: UIView!
    @IBOutlet var btnSearch: UIButton!
    @IBOutlet var btnBooking: UIButton!
    @IBOutlet var btnProfile: UIButton!
    
    @IBOutlet var viewOfPopUp: CardView!
    
    @IBOutlet var imgOfSearch: UIImageView!
    @IBOutlet var imgOfBooking: UIImageView!

    @IBOutlet var imgOfProfile: UIImageView!
    
    
    var isSearchPressed  : Bool?
    var isBookingPressed  : Bool?
    var isProfilePressed  : Bool?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPager()
        self.btnSearch.isSelected = true
        self.btnBooking.isSelected = false
        self.btnProfile.isSelected = false
        self.imgOfSearch.image = UIImage(named: "search")
        self.imgOfBooking.image = UIImage(named: "calendar")
        self.imgOfProfile.image = UIImage(named: "UnSelectedProfile")

        isSearchPressed = true
        isBookingPressed = true
        isProfilePressed = true

        // Do any additional setup after loading the view.
    }
    
    func setPager() {
        pageVC = storyboard?.instantiateViewController(withIdentifier: "PageMenuDetail") as! UIPageViewController?
        //        pageVC?.dataSource = self
        //        pageVC?.delegate = self
        
        
        let startVC = viewControllerAtIndex(tempIndex: 0)
        _ = startVC.view
        
        pageVC?.setViewControllers([startVC], direction: .forward, animated: false, completion: nil)
        pageVC?.view.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEGHT)
        self.addChildViewController(pageVC!)
        self.view.addSubview((pageVC?.view)!)
        self.view.bringSubview(toFront: self.viewBottom)

        self.pageVC?.didMove(toParentViewController: self)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewControllerAtIndex(tempIndex: Int) -> UIViewController {
        
        if tempIndex == 0 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "OPSearchingVC" ) as! OPSearchingVC
            vc.index = 0
            return vc
        }else if tempIndex == 1 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "OPBookingVC") as! OPBookingVC
            vc.index = 1
            return vc
        }
        else  {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "OPProfileVC" ) as! OPProfileVC

            vc.index = 2
            return vc
        }
        
        
        
        
    }
    
    @IBAction func buttonSearch_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        self.btnSearch.isSelected = true
        self.btnBooking.isSelected = false
        self.btnProfile.isSelected = false
        
        isBookingPressed = true
        isProfilePressed = true

        self.imgOfSearch.image = UIImage(named: "search")
        self.imgOfBooking.image = UIImage(named: "calendar")
        self.imgOfProfile.image = UIImage(named: "UnSelectedProfile")
        if isSearchPressed == true {
            let startVC = viewControllerAtIndex(tempIndex: 0)
            _ = startVC.view
            pageVC?.setViewControllers([startVC], direction:(showingIndex == 4) ? .forward : .reverse, animated: false , completion: nil)
            isSearchPressed = false
        }

      
    }
    
    @IBAction func btnBooking_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        self.btnSearch.isSelected = false
        self.btnBooking.isSelected = true
        self.btnProfile.isSelected = false
        
        
        self.imgOfSearch.image = UIImage(named: "search_light")
        self.imgOfBooking.image = UIImage(named: "booking_white")
        self.imgOfProfile.image = UIImage(named: "UnSelectedProfile")
        isProfilePressed = true
        isSearchPressed = true
        
//        let userID = UserDefaults.standard.string(forKey: "id")
        
        if isBookingPressed == true {
            let startVC = viewControllerAtIndex(tempIndex: 1)
            _ = startVC.view
            viewOfPopUp.isHidden = true
            pageVC?.setViewControllers([startVC], direction:(showingIndex == 4) ? .forward : .reverse, animated: false, completion: nil)
            isBookingPressed = false
        }
      
        

    
    }
    
    @IBAction func btnProfile_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        self.btnSearch.isSelected = false
        self.btnBooking.isSelected = false
        self.btnProfile.isSelected = true

        
        self.imgOfSearch.image = UIImage(named: "search_light")
        self.imgOfBooking.image = UIImage(named: "calendar")
        self.imgOfProfile.image = UIImage(named: "profile_white")
        isBookingPressed = true
        isSearchPressed = true
        
        if isProfilePressed == true {
        let startVC = viewControllerAtIndex(tempIndex: 2)
        _ = startVC.view
//        viewOfPopUp.isHidden = true
        
        pageVC?.setViewControllers([startVC], direction:(showingIndex == 4) ? .forward : .reverse, animated: false, completion: nil)
        isProfilePressed = false
//        let userID = UserDefaults.standard.string(forKey: "id")
//
//        if userID == nil  {
//            viewOfPopUp.isHidden = false
//
////
//
//        } else {
//            let startVC = viewControllerAtIndex(tempIndex: 2)
//            _ = startVC.view
//            viewOfPopUp.isHidden = true
//
//            pageVC?.setViewControllers([startVC], direction:(showingIndex == 4) ? .forward : .reverse, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func btnConnectWithEmail_Pressed(_ sender: UIButton) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "OSLoginViewController")
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func bottomBarPressed(_ sender: UIButton) {
        if showingIndex != sender.tag {
            
            if sender.tag == 0
            {
//                viewOfServices.isHidden = false
//                viewOfReviews.isHidden  = true
//                viewOfLocation.isHidden = true
            }
            else if sender.tag == 1
            {
//                viewOfServices.isHidden = true
//                viewOfReviews.isHidden  = false
//                viewOfLocation.isHidden = true
            }  else if sender.tag == 2 {
//                viewOfLocation.isHidden = false
//                viewOfServices.isHidden = true
//                viewOfReviews.isHidden  = true
            }
            
            showingIndex = sender.tag
            let startVC = viewControllerAtIndex(tempIndex: sender.tag)
            _ = startVC.view
            pageVC?.setViewControllers([startVC], direction:(showingIndex == 4) ? .forward : .reverse, animated: true, completion: nil)
            
        }
        
    }
    
}
