//
//  OSFacilityDetailVC.swift
//  OPENSPOT
//
//  Created by Ahmed Durrani on 18/03/2018.
//  Copyright © 2018 TechEase Solution. All rights reserved.
//

import UIKit

class OSFacilityDetailVC: UIViewController {
    @IBOutlet weak var tbleView: UITableView!
    var isBookAgainOrOther : Int?

    var selectGround : GetALlGroundObj?
    var groundTime   : GroundTime?
    var selectFav    : UserFavouriteObject?
    var userInfo : UserResponse?
    var groundDetailList : GroundDetail?
    let ap = UIApplication.shared.delegate as! AppDelegate
    var isChangeSelect : Bool?
    var timeArray : [TimeOFGround]?
    
    @IBOutlet weak var btnBooked: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        timeArray = []
        isChangeSelect = true
        getAllGroundDetail()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getAllGroundDetail() {
        
        var idOfGroud : Int?
        if isBookAgainOrOther == 1 {
            idOfGroud = self.selectGround?.idOfGround
        } else {
            idOfGroud = self.selectFav?.idOfFav

        }
        
        if  ap.selectedDate == nil {
            let date = Date()
            let formatter = DateFormatter()
            
            formatter.dateFormat = "yyyy-MM-dd"
            
            ap.selectedDate   = formatter.string(from: date)
        }

        
        let groundParam = ["ground_id"           : idOfGroud! ,
                           "date"                : ap.selectedDate!
            ] as [String : AnyObject]
        WebServiceManager.post(params: groundParam , serviceName: GETGROUNDDETAIL, serviceType: "Get SubCategorie" , modelType: GroundDetail.self, success: { (response) in
            self.groundDetailList = (response as! GroundDetail)
            
            if  self.groundDetailList?.success == true {
                self.tbleView.delegate = self
                self.tbleView.dataSource = self
                self.tbleView.reloadData()
                
            } else {
                                self.showAlert(title: "OPEN SPOT", message: (self.groundDetailList?.message)!, controller: self)
                
            }
            
            
        }, fail: { (error) in
            
            
            self.showAlert(title: "OPEN SPOT", message: error.description , controller: self)
        }, showHUD: true)
        
        
    }

    @IBAction func btnBooked_Pressed(_ sender: UIButton) {
        let userID = UserDefaults.standard.string(forKey: "id")
            if userID == nil  {
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let vc = mainStoryboard.instantiateViewController(withIdentifier: "OSLoginViewController") as? OSLoginViewController
                vc?.screenSelect = 1
                self.navigationController?.pushViewController(vc!, animated: true)
                
            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "OSBookORCanCelBookingVC") as! OSBookORCanCelBookingVC
                vc.timeArray = self.timeArray
                vc.infoOfGround = groundDetailList?.data
                vc.isCancelOrBook = 1
                self.navigationController?.pushViewController(vc, animated: true)
                
                
            }
        }
        
    
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        ap.selectedDate = nil
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension OSFacilityDetailVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return  1
        } else if section == 1  {
            return 1
        } else if section == 2  {
            return 1
        } else {
            
            if isChangeSelect == true {
                if ap.selectShift == 3 {
                    return (self.groundDetailList?.timeObject?.afterNoon!.count)!
                    
                } else if ap.selectShift == 2 {
                    return (self.groundDetailList?.timeObject?.noon!.count)!
                    
                } else {
                    return (self.groundDetailList?.timeObject?.morning!.count)!
                }
            } else {
                return (self.groundTime?.data!.count)!

            }
            
       
            
            
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            var cell: OSFacilityTableCell? = tableView.dequeueReusableCell(withIdentifier: "ExtraFacility") as! OSFacilityTableCell?
            if cell == nil {
                cell = OSFacilityTableCell(style: .default, reuseIdentifier: "ExtraFacility")
            }
            cell?.imagesArray = self.groundDetailList?.imagesArray

            return cell!
        } else if indexPath.section == 1 {
            var cell: OSFacilityTableCell? = tableView.dequeueReusableCell(withIdentifier: "InfoOfFacility") as! OSFacilityTableCell?
            if cell == nil {
                cell = OSFacilityTableCell(style: .default, reuseIdentifier: "InfoOfFacility")
            }
            cell?.delegate = self
            cell?.index = indexPath
            
            if isBookAgainOrOther == 2 {
                cell?.nameOfClub.text = self.selectFav?.name
                cell?.lblInfoOfClub.text = self.selectFav?.information
                cell?.locationName.text = self.selectFav?.location
                if self.selectFav?.isFav == "true" {
                    cell?.btnFavOrUnFav.isSelected = true
                } else {
                    cell?.btnFavOrUnFav.isSelected = false
                    
                }


            } else  {
                
                if self.groundDetailList?.data?.favOrUnfav  == "true" {
                    cell?.btnFavOrUnFav.isSelected = true
                } else {
                    cell?.btnFavOrUnFav.isSelected = false

                }
//                cell?.btnFavOrUnFav
                cell?.nameOfClub.text = self.selectGround?.name
                cell?.lblInfoOfClub.text = self.selectGround?.information
                cell?.locationName.text = self.selectGround?.location
            }
           
            return cell!


        } else if indexPath.section == 2 {
            var cell: OSFacilityTableCell? = tableView.dequeueReusableCell(withIdentifier: "ChangeInfo") as! OSFacilityTableCell?
            if cell == nil {
                cell = OSFacilityTableCell(style: .default, reuseIdentifier: "ChangeInfo")
            }
            
            if isBookAgainOrOther == 2 {
                cell?.lblTypeOfFootball.text = self.selectFav?.type


            } else {
                cell?.lblTypeOfFootball.text = self.selectGround?.type

            }
            cell?.delegate = self
            cell?.index = indexPath

            return cell!

        } else {
            var cell: OSFacilityTableCell? = tableView.dequeueReusableCell(withIdentifier: "PriceOfInfo") as! OSFacilityTableCell?
            if cell == nil {
                cell = OSFacilityTableCell(style: .default, reuseIdentifier: "PriceOfInfo")
            }
            
            cell?.delegate = self
            cell?.index = indexPath
            
            if self.isChangeSelect == true {
                if ap.selectShift == 3 {
                    
                    
                    let timeFrom = self.groundDetailList?.timeObject!.afterNoon![indexPath.row].time_from
                    let timeTo = self.groundDetailList?.timeObject!.afterNoon![indexPath.row].time_to
                    
                    cell?.lblTime.text = "\(timeFrom!)-\(timeTo!)"
                    
                    let price = self.groundDetailList?.timeObject!.afterNoon![indexPath.row].price
                    cell?.btnPRice.setTitle(("\(price!) QAR"), for: .normal)
                    
                    
                } else if ap.selectShift == 2 {
                    
                    let timeFrom = self.groundDetailList?.timeObject!.noon![indexPath.row].time_from
                    let timeTo = self.groundDetailList?.timeObject!.noon![indexPath.row].time_to
                    
                    cell?.lblTime.text = "\(timeFrom!)-\(timeTo!)"
                    
                    let price = self.groundDetailList?.timeObject!.noon![indexPath.row].price
                    cell?.btnPRice.setTitle(("\(price!) QAR"), for: .normal)
                    
                } else {
                    //                cell?.lblTime.text = self.groundDetailList?.timeObject!.morning![indexPath.row].time_from
                    let timeFrom = self.groundDetailList?.timeObject!.morning![indexPath.row].time_from
                    let timeTo = self.groundDetailList?.timeObject!.morning![indexPath.row].time_to
                    
                    cell?.lblTime.text = "\(timeFrom!)-\(timeTo!)"
                    let price = self.groundDetailList?.timeObject!.morning![indexPath.row].price
                    cell?.btnPRice.setTitle(("\(price!) QAR"), for: .normal)
                    
                }
            } else {
                let timeFrom = self.groundTime?.data![indexPath.row].time_from
                let timeTo = self.groundTime?.data![indexPath.row].time_to
                
                cell?.lblTime.text = "\(timeFrom!)-\(timeTo!)"
                
                let price = self.groundTime?.data![indexPath.row].price
                cell?.btnPRice.setTitle(("\(price!) QAR"), for: .normal)
            }
            
            
           
            return cell!

        }
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section ==  0 {
            
            return 180.0
        } else if indexPath.section == 1 {
            return 86.0
        } else if indexPath.section == 2 {
            return 74.0
        } else  {
            return 71.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
    }
}

extension OSFacilityDetailVC : ChangeFilter {
    
    
    func isTimeSelectedOrNot(checkCell: OSFacilityTableCell, indexPath: IndexPath) {
        
        if isChangeSelect == true {
            let timeId = self.groundDetailList?.timeObject?.morning![indexPath.row].time_id
            
            if checkCell.btnPRice.isSelected == false  {
                checkCell.btnPRice.isSelected = true
                if ap.selectShift == 3 {
                    
                    if timeArray?.count == 0  {
                        timeArray?.append((self.groundDetailList?.timeObject!.afterNoon![indexPath.row])!)
                        self.btnBooked.isHidden = false
                    } else {
                       self.btnBooked.isHidden = false
                        checkCell.btnPRice.isSelected = true
                        timeArray?.append((self.groundDetailList?.timeObject!.afterNoon![indexPath.row])!)
                    }
                    
                }
                
                else if ap.selectShift == 2 {
                    
                    if timeArray?.count == 0  {
                        timeArray?.append((self.groundDetailList?.timeObject!.noon![indexPath.row])!)
                        self.btnBooked.isHidden = false
                    } else {
                        self.btnBooked.isHidden = false
                        checkCell.btnPRice.isSelected = true
                        timeArray?.append((self.groundDetailList?.timeObject!.noon![indexPath.row])!)
                        
                    }
                    
                } else {
                    
                    if timeArray?.count == 0  {
                        timeArray?.append((self.groundDetailList?.timeObject!.morning![indexPath.row])!)
                        self.btnBooked.isHidden = false
                    } else {
                        self.btnBooked.isHidden = false
                        checkCell.btnPRice.isSelected = true
                        timeArray?.append((self.groundDetailList?.timeObject!.morning![indexPath.row])!)
                        
                    }
                    //                return (self.groundDetailList?.timeObject?.morning!.count)!
                }
                
                
            } else {
                checkCell.btnPRice.isSelected = false
                
                if let index = self.timeArray?.index(where: {$0.time_id == timeId}) {
                    self.timeArray?.remove(at: index)
                    if self.timeArray?.count == 0 {
                        self.btnBooked.isHidden = true
                        
                    } else {
                        self.btnBooked.isHidden = false
                        
                    }
                    
                } else {
                    print("Check")
                }
                
            }
        } else {
            let timeId = self.groundTime?.data![indexPath.row].time_id
            if checkCell.btnPRice.isSelected == false  {
                checkCell.btnPRice.isSelected = true
                    if timeArray?.count == 0  {
                        timeArray?.append((self.groundTime?.data![indexPath.row])!)
                        self.btnBooked.isHidden = false
                    } else {
                        self.btnBooked.isHidden = false
                        checkCell.btnPRice.isSelected = true
                        timeArray?.append((self.groundTime?.data![indexPath.row])!)
                    }
                    
                
            } else {
                checkCell.btnPRice.isSelected = false
                
                if let index = self.timeArray?.index(where: {$0.time_id == timeId}) {
                    self.timeArray?.remove(at: index)
                    if self.timeArray?.count == 0 {
                        self.btnBooked.isHidden = true
                        
                    } else {
                        self.btnBooked.isHidden = false
                        
                    }
                    
                } else {
                    print("Check")
                }
                
            }
        
        }
        
    }
    
    func isChangeFilterClicked(checkCell : OSFacilityTableCell , indexPath : IndexPath)  {
        let vc: OSSearchViewController? = storyboard?.instantiateViewController(withIdentifier: "OSSearchViewController") as? OSSearchViewController
        
        ap.selectDateInWeek = nil
        ap.morningOrNoon = nil
        ap.timeDuration = nil
        ap.sportSelect = nil

        vc?.selectVC = 0
        vc?.delegate = self
        
        self.timeArray = []
        if #available(iOS 10.0, *) {
            vc?.modalPresentationStyle = .overCurrentContext
        } else {
            vc?.modalPresentationStyle = .currentContext
        }
//        vc?.providesPresentationContextTransitionStyle = true
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        transition.type = kCATransitionMoveIn
        transition.subtype = kCATransitionFromTop
        navigationController?.view.layer.add(transition, forKey: nil)
        
        present(vc!, animated: true, completion: {() -> Void in
        })
        
    }
    
    func isFavOrUnFav(checkCell : OSFacilityTableCell , indexPath : IndexPath)
    {
        let groundID  = selectGround?.idOfGround
        let userID = UserDefaults.standard.string(forKey: "id")

        let param = [      "ground_id"           : groundID! ,
                           "user_id"             : userID!
            ] as [String : Any]
        
        WebServiceManager.post(params: param as Dictionary<String, AnyObject> , serviceName: USERLIKEORUNLIKE, serviceType: "User Like Or Dislike" , modelType: UserResponse.self, success: { (response) in
            self.userInfo = (response as! UserResponse)
            if  self.userInfo?.success == true {
                
                if self.userInfo?.message == "Added To favorite" {
                    checkCell.imgOfHeart.image = UIImage(named: "like")
                } else {
                    checkCell.imgOfHeart.image = UIImage(named: "heart")

                }
                self.showAlert(title: "OPEN SPOT", message: (self.userInfo?.message)!, controller: self)
                
            } else  {
                self.showAlert(title: "OPEN SPOT", message: (self.userInfo?.message)!, controller: self)
            }
            
            
            
        }, fail: { (error) in
            self.showAlert(title: "OPEN SPOT", message: error.description , controller: self)
        }, showHUD: true)
        
        
    }
}

extension OSFacilityDetailVC : FindSpotDelegate {
    
    func isChangeFilterClicked(date: String?, timeFrom: String?, timeTo: String?, duration: String?, selectSport: String?) {
            isChangeSelect = false

        self.ap.selectedDate = timeTo
        var idOfGroud : Int?
        
        var selectedDate : String?
        var selectedSlot : String?
        var selectedDuration : String?
        var isSportSelect : String?
        
        
        
        if date == " " {
            selectedDate = ""
        } else {
            selectedDate = date
            
        }
        
        if timeFrom == " " {
            selectedSlot = ""
        } else {
            selectedSlot = timeFrom
            
        }
        
        if duration == " " {
            selectedDuration = ""
        } else {
            selectedDuration = duration
            
        }
        
        if selectSport == " " {
            isSportSelect = ""
        } else {
            isSportSelect = selectSport
            
        }
        
        
        if isBookAgainOrOther == 1 {
            idOfGroud = self.selectGround?.idOfGround
        } else {
            idOfGroud = self.selectFav?.idOfFav
            
        }
        
        
        let groundParam =   [ "date"        : selectedDate!  ,
                              "slot"        : selectedSlot! ,
                              "duration"    : selectedDuration! ,
                              "sport"       : isSportSelect! ,
                              "ground_id"   : idOfGroud!

                              ] as [String : AnyObject]
//        let groundParam =   [ "date"        : date!  ,
//                              "slot"        : timeFrom ,
//                              "duration"    : duration! ,
//                              "sport"       : selectSport! ,
//                              "ground_id"   : idOfGroud!
//                            ] as [String : AnyObject]
        
        WebServiceManager.post(params: groundParam , serviceName: FILTERSINGLEGROUN, serviceType: "Filter List" , modelType: GroundTime.self, success: { (response) in
            self.groundTime = (response as! GroundTime)
            
            if  self.groundTime?.success == true {
                self.tbleView.delegate = self
                self.tbleView.dataSource = self
                self.tbleView.reloadData()
                
            } else {
                self.showAlert(title: "OEPNSPOT", message: "No Ground Found" , controller: self)
//                self.tbleView.delegate = self
//                self.tbleView.dataSource = self
                 self.tbleView.reloadData()
            }
        }, fail: { (error) in
            
            
            self.showAlert(title: "OEPNSPOT", message: error.description , controller: self)
        }, showHUD: true)
        
        
    }
    
}


