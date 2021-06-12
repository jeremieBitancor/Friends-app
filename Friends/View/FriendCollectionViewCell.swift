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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
