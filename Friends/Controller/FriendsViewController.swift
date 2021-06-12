//
//  ViewController.swift
//  Friends
//
//  Created by jeremie bitancor on 6/12/21.
//

import UIKit

class FriendsViewController: UIViewController, DataManagerDelegate {
    
    @IBOutlet weak var friendsCollectionView: UICollectionView!
    
    var dataManager = DataManager()
    var friends = [Friend]()
    var portrait: UIImage?
    var selectedFriend: Friend?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Fetch users data on first launch
        dataManager.fetchUsers()
        /// Set self as delegate
        dataManager.delegate = self
        /// Set collection view data source
        friendsCollectionView.dataSource = self
        /// Set collection view delegate
        friendsCollectionView.delegate = self
        /// Register a custom cell for collection view
        friendsCollectionView.register(UINib(nibName: "FriendCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FriendCell")
        
    }

    /// Get data from API using delegation
    func didGetFriends(_ friends: [Friend]) {
        /// Set data to local
        self.friends = friends
        /// Refresh table view to show the newly fetch data
        friendsCollectionView.reloadData()
    }

}

//MARK: - UICollectionView Data Source
extension FriendsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friends.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = friendsCollectionView.dequeueReusableCell(withReuseIdentifier: "FriendCell", for: indexPath) as! FriendCollectionViewCell
        
        let friend = friends[indexPath.row]
        let friendName = friend.name
        let name = " \(friendName.first)" + " \(friendName.last)"
        /// Get picture from API and set it
        if let imageUrl = URL(string: friend.picture.large) {
            cell.friendPortrait.loadImage(withUrl: imageUrl)
        }
        
        cell.friendName.text = name
        cell.friendCountry.text = friend.location.country
        return cell
    }
}

//MARK: - UICollection View Delegate
extension FriendsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       /// Set selected friend to be use on detail view
        selectedFriend = friends[indexPath.row]
        
        performSegue(withIdentifier: "ToFriendScreen", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! FriendViewController
        /// Set friend on detail view
        destinationVC.friend = selectedFriend
    }
    
}

//MARK: - UIImage View Custom Function
/// A function that get data from API and set it using UIImageView
extension UIImageView {
    
    func loadImage(withUrl url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                       
                    }
                }
            }
            
        }
    }
}
