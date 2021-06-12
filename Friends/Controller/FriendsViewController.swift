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

extension FriendsViewController: UICollectionViewDataSource {
    
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

extension FriendsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(friends[indexPath.row].name.last)
//        self.delegate?.selectedData(friends[indexPath.row], portrait)
        selectedFriend = friends[indexPath.row]
        
        performSegue(withIdentifier: "ToFriendScreen", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! FriendViewController
        destinationVC.friend = selectedFriend
    }
    
}

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
