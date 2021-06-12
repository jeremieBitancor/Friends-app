//
//  FriendModel.swift
//  Friends
//
//  Created by jeremie bitancor on 6/12/21.
//

import Foundation

struct Friends: Codable {
    let results: [Friend]
}

struct Friend: Codable {
    let name: Name
    let location: Location
    let picture: Picture
    let email: String
    let cell: String
}

struct Name: Codable {
    let title: String
    let first: String
    let last: String
}

struct Location: Codable {
    let street: Address
    let city: String
    let state: String
    let country: String
}

struct Address: Codable {
    let number: Int
    let name: String
}

struct Picture: Codable {
    let large: String
}
