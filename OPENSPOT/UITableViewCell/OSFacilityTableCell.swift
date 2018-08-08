//
//  OSFacilityTableCell.swift
//  OPENSPOT
//
//  Created by Ahmed Durrani on 18/03/2018.
//  Copyright © 2018 TechEase Solution. All rights reserved.
//

import UIKit

protocol ChangeFilter {
    func isChangeFilterClicked(checkCell : OSFacilityTableCell , indexPath : IndexPath)
    func isFavOrUnFav(checkCell : OSFacilityTableCell , indexPath : IndexPath)
    func isTimeSelectedOrNot(checkCell : OSFacilityTableCell , indexPath : IndexPath)

}


class OSFacilityTableCell: UITableViewCell {
    
    @IBOutlet weak var collectionViewCell: UICollectionView!
    var imagesArray : [GroundImages]?
    var groundDetailObj : GroundDetail?

    var delegate: ChangeFilter?
    var index: IndexPath?

    
    @IBOutlet var nameOfClub: UILabel!
    
    @IBOutlet var lblInfoOfClub: UILabel!
    
    @IBOutlet var locationName: UILabel!
    @IBOutlet var lblTypeOfFootball : UILabel!
    @IBOutlet var lblTime : UILabel!
    @IBOutlet var btnPRice : UIButton!

    @IBOutlet var imgOfHeart: UIImageView!
    @IBOutlet var btnFavOrUnFav: UIButton!
    @IBOutlet var btnTimeSelect: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnChange_Pressed(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
        self.delegate?.isChangeFilterClicked(checkCell : self  , indexPath : index!)
        
        
    }
    
    @IBAction func btnIsFavOrUnFav(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.delegate?.isFavOrUnFav(checkCell : self  , indexPath : index!)
        
        
    }
    
    @IBAction func btnTimeSelectedOrNot(_ sender: UIButton) {
         sender.isSelected = !sender.isSelected
        self.delegate?.isTimeSelectedOrNot(checkCell : self  , indexPath : index!)
        
        
    }
}

extension OSFacilityTableCell : UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (imagesArray?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        CertifcateCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OSExtraFacilityCell", for: indexPath) as! OSExtraFacilityCell
        
        let imageOfNews = self.imagesArray?[indexPath.row].image?.replacingOccurrences(of: " ", with: "%20")
        WAShareHelper.loadImage(urlstring:imageOfNews! , imageView: (cell.imgOfGrounds)!, placeHolder: "")

        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeOfCell = self.collectionViewCell.frame.size.width/2
        //        let heightOfCell = self.collectionViewCell.frame.size.height/6
        
        return CGSize(width: sizeOfCell, height: 150.0)
    }
    
    
}
