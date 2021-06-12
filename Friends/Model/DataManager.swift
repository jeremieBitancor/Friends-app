//
//  DataManager.swift
//  Friends
//
//  Created by jeremie bitancor on 6/12/21.
//

import Foundation

protocol DataManagerDelegate {
    func didGetFriends(_ friends: [Friend])
}

class DataManager {
    
    var delegate: DataManagerDelegate?
    
    /// Fetch data
    func fetchUsers() {
        
        if let url = URL(string: "https://randomuser.me/api/?results=10") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(Friends.self, from: safeData)
                            DispatchQueue.main.async {
                                /// Set data using delegation
                                self.delegate?.didGetFriends(results.results)
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
