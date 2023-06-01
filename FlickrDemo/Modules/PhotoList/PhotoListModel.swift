//
//  PhotoListModel.swift
//  FlickrDemo
//
//  Created by ervinaydin on 01/06/2023.
//

import Foundation

// MARK: - PhotoModel
struct PhotoModel: Codable {
    let photos: Photos?
    let stat: String?
}

// MARK: - Photos
struct Photos: Codable {
    let page, pages, perpage, total: Int?
    let photo: [Photo]?
}

// MARK: - Photo
struct Photo: Codable, Identifiable {
    let id, owner, secret, server: String?
    let farm: Int?
    let title: String?
    let ispublic, isfriend, isfamily: Int?
    let datetaken, ownername, iconserver: String?
    let iconfarm: Int?
    let tags: String?
}

struct ImageUrlsModel: Codable {
    var raw:   String
    var full:  String
    var regular: String
    var small: String
    var thumb: String
}

struct UserModel: Codable {
    var first_name: String
    var last_name: String?
    var bio: String?
}

