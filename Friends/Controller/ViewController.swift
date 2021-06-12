//
//  ViewController.swift
//  Friends
//
//  Created by jeremie bitancor on 6/12/21.
//

import UIKit

class ViewController: UIViewController, DataManagerDelegate {
    
    @IBOutlet weak var friendsCollectionView: UICollectionView!
    var dataManager = DataManager()
    var friends = [Friend]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.fetchUsers()
        dataManager.delegate = self
        
        friendsCollectionView.dataSource = self
        friendsCollectionView.delegate = self
        friendsCollectionView.register(UINib(nibName: "FriendCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FriendCell")
        
    }

    func didGetFriends(_ friends: [Friend]) {
        self.friends = friends
        friendsCollectionView.reloadData()
    }

}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friends.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = friendsCollectionView.dequeueReusableCell(withReuseIdentifier: "FriendCell", for: indexPath) as! FriendCollectionViewCell
        
        let friend = friends[indexPath.row]
        let friendName = friend.name
        let name = " \(friendName.first)" + " \(friendName.last)"
        
        if let imageUrl = URL(string: friend.picture.large) {
            cell.friendPortrait.loadImage(withUrl: imageUrl)
            
        }
        cell.friendName.text = name
        cell.friendCountry.text = friend.location.country
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

extension UIImageView {
    
    func loadImage(withUrl url: URL ) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        /// Completion handler to stop the activity indicator
//                        finished()
                    }
                }
            }
            
        }
    }
}
