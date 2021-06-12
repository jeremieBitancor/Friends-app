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
        /// Roundcorners
        layer.cornerRadius = 20
        /// Make portrait circle
        friendPortrait.layer.cornerRadius = friendPortrait.frame.height / 2
        friendPortrait.layer.masksToBounds = false
        friendPortrait.clipsToBounds = true
        
    }

}
