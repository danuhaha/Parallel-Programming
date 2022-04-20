//
//  PostNewsResponse.swift
//  VKClient
//
//  Created by danuhaha on 06.04.2022.
//

import Foundation
import UIKit

struct PostNewsInitialResponse: Codable {
    let response: PostNewsResponse
}

struct PostNewsResponse: Codable {
    let items: [PostNewsItems]
    let profiles: [PostProfiles]
    let groups: [PostGroups]
}

struct PostProfiles: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar = "photo_100"
    }
}

struct PostGroups: Codable {
    let id: Int
    let name: String
    let avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case avatar = "photo_200"
    }
}

struct PostNewsItems: Codable {
    let source_id: Int
    let date: Int
    let text: String
    let attachments: [PostAttachments]?
    let comments: Comments
    let likes: Likes
    let reposts: Reposts
    let views: Views?
}

struct PostAttachments: Codable {
    let photo: PostPhoto?
}

struct PostPhoto: Codable {
    let sizes: [PhotoSizes]
}

struct PhotoSizes: Codable {
    let url: String
}

struct Comments: Codable{
    let count: Int
}

struct Likes: Codable{
    let count: Int
    let isLiked: Int
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case isLiked = "user_likes"
    }
}

struct Views: Codable{
    let count: Int
}

struct Reposts: Codable{
    let count: Int
}


