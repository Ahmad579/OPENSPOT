//
//  OPSearchingVC.swift
//  OPENSPOT
//
//  Created by Ahmed Durrani on 17/03/2018.
//  Copyright © 2018 TechEase Solution. All rights reserved.
//

import UIKit

class OPSearchingVC: UIViewController {
    
    @IBOutlet var viewOfSearch: CardView!

    @IBOutlet weak var tbleView: UITableView!
    var listOfAllGround: AllGroundList?
    var searchBarText : String?
    var index: Int?
    var showTime : String?
    var timeDuration : String?
    let ap = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet var searchBar: UITextField!

//    @IBOutlet var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        UtilityHelper.setViewBorder(viewOfSearch, withWidth: 0.4, andColor: UIColor.lightGray)

        selectDate()
        timeSelectionObserbor()

        durationObserbor()
        sportsSelection()
        

        // Do any additional setup after loading the view.
    }
    
    func selectDate(){
        NotificationCenter.default.addObserver(self, selector: #selector(OPSearchingVC.seletDate(_:)), name: NSNotification.Name(rawValue: "SelectDate"), object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        self.searchBar.text = ""

        self.searchBar.placeholder = "Search the Ground"
        getAllGroundList()

    }

    func timeSelectionObserbor(){
        NotificationCenter.default.addObserver(self, selector: #selector(OPSearchingVC.showTimeValue(_:)), name: NSNotification.Name(rawValue: "showValue"), object: nil)
    }
  
    func durationObserbor(){
        NotificationCenter.default.addObserver(self, selector: #selector(OPSearchingVC.showDuration(_:)), name: NSNotification.Name(rawValue: "showHour"), object: nil)
    }
    
    func sportsSelection(){
        NotificationCenter.default.addObserver(self, selector: #selector(OPSearchingVC.showSelectedSports(_:)), name: NSNotification.Name(rawValue: "sportSelect"), object: nil)
    }
    
    
    @objc func seletDate(_ notification: NSNotification) {
        
        let valueOfSelected = notification.userInfo
        let selectDay = valueOfSelected!["WeekInDay"]!
        searchBarText = ("\(selectDay)")
        searchBar.text = searchBarText
        
    }
    
  
    
    @objc func showTimeValue(_ notification: NSNotification) {
        print("Hello")
        
        let valueOfSelected = notification.userInfo
        let timeFrom = valueOfSelected!["TimeFrom"]!
        let timeTo = valueOfSelected!["TimeTo"]!
        
        showTime = ("\(timeFrom) to \(timeTo)")
        searchBar.text = ("\(searchBarText!), \(showTime!)")
        
    }
    
    @objc func showDuration(_ notification: NSNotification) {

        let valueOfSelected = notification.userInfo
//        let duration = valueOfSelected!["duration"]
        timeDuration = valueOfSelected!["duration"] as? String
        self.searchBar.text = ("\(searchBarText!), \(showTime!), \(timeDuration!)")
    }
 
    @objc func showSelectedSports(_ notification: NSNotification) {

        let valueOfSelected = notification.userInfo
        let sportSelected = valueOfSelected![AnyHashable("sport")]
        self.searchBar.text = ("\(searchBarText!),\(showTime!),\(timeDuration!),\(sportSelected!)")

        
    }
    
    
    func getAllGroundList() {
        
        WebServiceManager.get(params: nil, serviceName: GETALLFOOTGROUNDs, serviceType: "Categories List", modelType: AllGroundList.self, success: { (response) in
            self.listOfAllGround = (response as! AllGroundList)
            
            if  self.listOfAllGround?.success == true {
                
                for (_ , groundInfo) in (self.listOfAllGround?.data?.enumerated())! {
                   
                    let countOfTime = groundInfo.timeOfGround?.count
                    self.ap.isTimeSelect.append(countOfTime!)
                }
                
                self.tbleView.delegate = self
                self.tbleView.dataSource = self
                self.tbleView.reloadData()
                
            }
            else {
               
                
            self.showAlert(title: "OPEN SPOT", message: (self.listOfAllGround?.message)!, controller: self)
//                self.tbleView.delegate = self
//                self.tbleView.dataSource = self
                self.tbleView.reloadData()

            }
        }) { (error) in
            
         self.showAlert(title: "OPEN SPOT", message: (self.listOfAllGround?.message)!, controller: self)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnPopPresentForSearch_Pressed(_ sender: UIButton) {
      let vc: OSSearchViewController? = storyboard?.instantiateViewController(withIdentifier: "OSSearchViewController") as? OSSearchViewController
        vc?.selectVC = 0
        ap.selectDateInWeek = nil
        ap.selectTimeFromOrTo = nil
        ap.timeDuration = nil
        self.searchBar.text = ""
        ap.selectedString = ""
        self.searchBar.placeholder = "Search the Ground"

        vc?.delegate = self
       if #available(iOS 10.0, *) {
            vc?.modalPresentationStyle = .overCurrentContext
        } else {
            vc?.modalPresentationStyle = .currentContext
        }
        let transition = CATransition()
//        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromTop
//        navigationController?.view.layer.add(transition, forKey: nil)
        
           present(vc!, animated: false, completion: {() -> Void in
        })
        

        
    }
    

}

extension OPSearchingVC : UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (self.listOfAllGround?.data?.count)!
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchFacilityCell") as? SearchFacilityCell
        let imageOfNews = self.listOfAllGround?.data?[indexPath.row].image?.replacingOccurrences(of: " ", with: "%20")
        WAShareHelper.loadImage(urlstring:imageOfNews! , imageView: (cell?.imgeOgGround)!, placeHolder: "")
        cell?.nameOfClub.text = self.listOfAllGround?.data?[indexPath.row].name
        cell?.lblInfoOfClub.text = self.listOfAllGround?.data?[indexPath.row].information
        cell?.locationName.text = self.listOfAllGround?.data?[indexPath.row].location
        cell?.lblType.text = self.listOfAllGround?.data?[indexPath.row].type
        if self.listOfAllGround?.data?[indexPath.row].timeOfGround != nil {
            cell?.timeOfGround = self.listOfAllGround?.data?[indexPath.row].timeOfGround
            cell?.collectionViewCell.reloadData()

        }

        return cell!
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OSFacilityDetailVC") as? OSFacilityDetailVC
        vc?.selectGround = self.listOfAllGround?.data![indexPath.row]
        vc?.isBookAgainOrOther = 1

        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 294.0
    }
}

extension OPSearchingVC : UITableViewDataSource {
    
}

extension OPSearchingVC : FindSpotDelegate {
   
    
    func isChangeFilterClicked(date: String?, timeFrom: String?, timeTo: String?, duration: String?, selectSport: String?) {
        
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
        
        
        if ap.selectDateInWeek != nil {
            let text = self.searchBar.text
            self.searchBar.text = "\(ap.selectDateInWeek!) , \(text!)"
            
        }
        if ap.selectTimeFromOrTo != nil  {
            let text = self.searchBar.text
            self.searchBar.text = "\(ap.selectTimeFromOrTo!) , \(text!)"
        }
        if ap.timeDuration != nil  {
            let text = self.searchBar.text

            self.searchBar.text =  "\(ap.timeDuration!) , \(text!)"
//
        }
        if ap.sportSelect != nil  {
            let text = self.searchBar.text
            
            self.searchBar.text =  "\(ap.sportSelect!) , \(text!)"
            //
        }
        
        self.ap.selectedDate = timeTo
        let groundParam =   [ "date"        : selectedDate!  ,
                              "slot"        : selectedSlot ,
                              "duration"    : selectedDuration ,
                              "sport"       : isSportSelect ,
                           ] as [String : AnyObject]
      
        WebServiceManager.post(params: groundParam , serviceName: FILTERGROUND, serviceType: "Filter List" , modelType: AllGroundList.self, success: { (response) in
            self.listOfAllGround = (response as! AllGroundList)

            if  self.listOfAllGround?.success == true {
                self.tbleView.delegate = self
                self.tbleView.dataSource = self
                self.tbleView.reloadData()
                
            } else {
                self.showAlert(title: "OEPNSPOT", message: "No Grounds Found" , controller: self)
                self.tbleView.delegate = self
                self.tbleView.dataSource = self
                self.tbleView.reloadData()
            }
        }, fail: { (error) in
            
            
            self.showAlert(title: "OEPNSPOT", message: error.description , controller: self)
        }, showHUD: true)
        
        
     }
    }

