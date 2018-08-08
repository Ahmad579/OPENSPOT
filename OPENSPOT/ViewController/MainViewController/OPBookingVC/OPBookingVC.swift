//
//  OPBookingVC.swift
//  OPENSPOT
//
//  Created by Ahmed Durrani on 17/03/2018.
//  Copyright © 2018 TechEase Solution. All rights reserved.
//

import UIKit

class OPBookingVC: UIViewController {
    
    @IBOutlet var loginPopView: CardView!

    @IBOutlet weak var tbleView: UITableView!
    var bookingList : BookingList?
    var favouriteList : UserFavourite?

    @IBOutlet var btnBooking   : UIButton!
    @IBOutlet var btnFavourite : UIButton!
    var index: Int?
    var isBookingOrFavSeleted : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isBookingOrFavSeleted = true
        tbleView.register(UINib(nibName: "OSBookingCell", bundle: nil), forCellReuseIdentifier: "OSBookingCell")
        // Do any additional setup after loading the view.
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let userID = UserDefaults.standard.string(forKey: "id")
         if userID == nil  {
            loginPopView.isHidden = false
        
        } else {
            loginPopView.isHidden = true

            getALLBookingList()

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
    
    @IBAction func btnBooking_Pressed(_ sender: UIButton) {
        isBookingOrFavSeleted = true

        btnBooking.backgroundColor = UIColor(red: 24/255.0, green: 163/255.0, blue: 50/255.0, alpha: 1.0)
        btnFavourite.backgroundColor = UIColor.clear
        getALLBookingList()
    }
    
    @IBAction func btnFavourite_Pressed(_ sender: UIButton) {
        isBookingOrFavSeleted = false

        btnFavourite.backgroundColor = UIColor(red: 24/255.0, green: 163/255.0, blue: 50/255.0, alpha: 1.0)
        btnBooking.backgroundColor = UIColor.clear
        getFavouriteList()

        
    }
    
    func getALLBookingList() {
        
//        let idOfGround = self.selectGround?.idOfGround
        
        let userID = UserDefaults.standard.string(forKey: "id")

//        localUserData.id!
        let groundParam = [ "user_id"        : userID!
            ] as [String : AnyObject]
        WebServiceManager.post(params: groundParam , serviceName: GETBOOKINGLIST, serviceType: "Booking List" , modelType: BookingList.self, success: { (response) in
            self.bookingList = (response as! BookingList)
            
            if  self.bookingList?.success == true {
                self.tbleView.delegate = self
                self.tbleView.dataSource = self
                self.tbleView.reloadData()
                
            } else {
                self.showAlert(title: "OEPNSPOT", message: (self.bookingList?.message)!, controller: self)
//                self.tbleView.delegate = self
//                self.tbleView.dataSource = self
                self.tbleView.reloadData()

            }
            
            
        }, fail: { (error) in
            
            
            self.showAlert(title: "OEPNSPOT", message: error.description , controller: self)
        }, showHUD: true)
    }
    
 
    func getFavouriteList() {
        
        let userID = UserDefaults.standard.string(forKey: "id")

        let groundParam = [ "user_id"        : userID!
                          ] as [String : AnyObject]
        WebServiceManager.post(params: groundParam , serviceName: FAVOURITELIST, serviceType: "Booking List" , modelType: UserFavourite.self, success: { (response) in
            self.favouriteList = (response as! UserFavourite)
            
            if  self.favouriteList?.success == true {
                self.tbleView.delegate = self
                self.tbleView.dataSource = self
                self.tbleView.reloadData()
                
            } else {
                self.showAlert(title: "OEPNSPOT", message: (self.favouriteList?.message)!, controller: self)
                self.tbleView.reloadData()

            }
            
            
        }, fail: { (error) in
            
            
            self.showAlert(title: "OEPNSPOT", message: error.description , controller: self)
        }, showHUD: true)
    }
    
    
//
//
   
}

extension OPBookingVC : UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        if isBookingOrFavSeleted == true {
            return (self.bookingList?.data?.count)!

        } else {
            return (self.favouriteList?.data?.count)!
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OSBookingCell") as? OSBookingCell
       
        if isBookingOrFavSeleted == true {
            cell?.delegate = self
            cell?.index = indexPath
            
            let imageOfNews = self.bookingList?.data?[indexPath.row].image?.replacingOccurrences(of: " ", with: "%20")
            WAShareHelper.loadImage(urlstring:imageOfNews! , imageView: (cell?.imgeOgGround)!, placeHolder: "")
            cell?.nameOfClub.text = self.bookingList?.data?[indexPath.row].name
            cell?.lblInfoOfClub.text = self.bookingList?.data?[indexPath.row].information
            cell?.locationName.text = self.bookingList?.data?[indexPath.row].location
            cell?.lblDate.text = self.bookingList?.data?[indexPath.row].date
//            cell?.btnFav.titleLabel?.text = "BOOK AGAIN"
            cell?.btnFav.isHidden = false
            cell?.btnBookAgainPressed.isHidden = true
            cell?.btnFav.backgroundColor = UIColor(red: 199/255.0, green: 37/255.0, blue: 26/255.0, alpha: 1.0)


            
        } else {
            let imageOfNews = self.favouriteList?.data?[indexPath.row].image?.replacingOccurrences(of: " ", with: "%20")
            WAShareHelper.loadImage(urlstring:imageOfNews! , imageView: (cell?.imgeOgGround)!, placeHolder: "")
            cell?.nameOfClub.text = self.favouriteList?.data?[indexPath.row].name
            cell?.lblInfoOfClub.text = self.favouriteList?.data?[indexPath.row].information
            cell?.locationName.text = self.favouriteList?.data?[indexPath.row].location
            cell?.lblDate.text = self.favouriteList?.data?[indexPath.row].name
            cell?.btnFav.titleLabel?.text = "CANCEL"
            cell?.btnFav.isHidden = true
            cell?.btnBookAgainPressed.isHidden = false

            cell?.btnFav.backgroundColor = UIColor(red: 24/255.0, green: 163/255.0, blue: 50/255.0, alpha: 1.0)


        }
       


        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 266.0
    }
}

extension OPBookingVC : UITableViewDataSource {
    
}

extension OPBookingVC : CancelOrBookingClub {
  
    func isCancelOrBookingCalled(checkCell : OSBookingCell , indexPath : IndexPath)  {
        
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "OSBookORCanCelBookingVC") as! OSBookORCanCelBookingVC
            vc.cancelBooking = bookingList?.data![indexPath.row]
            vc.isCancelOrBook = 2
            self.navigationController?.pushViewController(vc, animated: true)
   
    }
   
    func isBookingAgain(checkCell : OSBookingCell , indexPath : IndexPath)
    {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OSBookORCanCelBookingVC") as! OSBookORCanCelBookingVC
//        vc.cancelBooking = bookingList?.data![indexPath.row]
//        vc.isCancelOrBook = 2
//        self.navigationController?.pushViewController(vc, animated: true)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OSFacilityDetailVC") as? OSFacilityDetailVC
        vc?.selectFav = self.favouriteList?.data![indexPath.row]
        vc?.isBookAgainOrOther = 2
        self.navigationController?.pushViewController(vc!, animated: true)

    }
}

