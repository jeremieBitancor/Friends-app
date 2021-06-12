//
//  FriendCollectionViewCell.swift
//  Friends
//
//  Created by jeremie bitancor on 6/12/21.
//

import UIKit

class FriendCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var friendPortrait: UIImageView!
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendCountry: UILabel!
    
    @IBOutlet weak var sub: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /// Add shadow effect
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 10.0
        layer.shadowOpacity = 0.25
        layer.masksToBounds = false
        sub.layer.cornerRadius = 20
        /// Make portrait circle
        friendPortrait.layer.cornerRadius = 50
        friendPortrait.layer.masksToBounds = false
        friendPortrait.clipsToBounds = true
        
    }

}
