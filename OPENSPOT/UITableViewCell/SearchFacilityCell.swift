//
//  SearchFacilityCell.swift
//  OPENSPOT
//
//  Created by Ahmed Durrani on 17/03/2018.
//  Copyright © 2018 TechEase Solution. All rights reserved.
//

import UIKit

class SearchFacilityCell: UITableViewCell {
  
    
    var timeOfGround : [TimeOFGround]?

    @IBOutlet var imgeOgGround: UIImageView!
    @IBOutlet var nameOfClub: UILabel!
    
    @IBOutlet var lblInfoOfClub: UILabel!
    
    @IBOutlet var locationName: UILabel!
    
    @IBOutlet var lblType: UILabel!
    
    @IBOutlet weak var collectionViewCell: UICollectionView!
    
    
  
    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension SearchFacilityCell : UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (timeOfGround?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeCollectionCell", for: indexPath) as! TimeCollectionCell
        
        cell.lblTime.text = self.timeOfGround![indexPath.row].time_from
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeOfCell = self.collectionViewCell.frame.size.width/3 - 5
        //        let heightOfCell = self.collectionViewCell.frame.size.height/6
        
        return CGSize(width: sizeOfCell, height: 26.0)
    }
    
    
}


