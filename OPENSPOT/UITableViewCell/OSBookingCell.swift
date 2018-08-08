//
//  OSBookingCell.swift
//  OPENSPOT
//
//  Created by Ahmed Durrani on 17/03/2018.
//  Copyright © 2018 TechEase Solution. All rights reserved.
//

import UIKit

protocol CancelOrBookingClub {
    func isCancelOrBookingCalled(checkCell : OSBookingCell , indexPath : IndexPath)
    func isBookingAgain(checkCell : OSBookingCell , indexPath : IndexPath)

}

class OSBookingCell: UITableViewCell {
    
    @IBOutlet var imgeOgGround: UIImageView!
    @IBOutlet var nameOfClub: UILabel!
    
    @IBOutlet var lblInfoOfClub: UILabel!
    
    @IBOutlet var locationName: UILabel!
    
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var btnFav: UIButton!
    @IBOutlet var btnBookAgainPressed: UIButton!

    

    var delegate: CancelOrBookingClub?
    var index: IndexPath?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnCancelOrBookingPressed(_ sender: UIButton) {
        self.delegate?.isCancelOrBookingCalled(checkCell : self  , indexPath : index!)
     
    }
    
    @IBAction func btnBookAgainPressed(_ sender: UIButton) {
        self.delegate?.isBookingAgain(checkCell : self  , indexPath : index!)
        
        
    }
}
