//
//  WallResponse.swift
//  VKClient
//
//  Created by danuhaha on 20.04.2022.
//

import Foundation
import UIKit

struct WallInitialResponse: Codable {
    let response: WallResponse
}

struct WallResponse: Codable {
    let items: [WallItems]
}

struct WallItems: Codable {
    let date: Int
    let text: String
    let attachments: [WallAttachments]?
    let comments: WallComments
    let likes: WallLikes
    let reposts: WallReposts
    let views: WallViews
}

struct WallAttachments: Codable {
    let photo: WallPhoto?
}

struct WallPhoto: Codable {
    let sizes: [WallPhotoSizes]
}

struct WallPhotoSizes: Codable {
    let url: String
}

struct WallComments: Codable{
    let count: Int
}

struct WallLikes: Codable{
    let count: Int
    let isLiked: Int
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case isLiked = "user_likes"
    }
}

struct WallViews: Codable{
    let count: Int
}

struct WallReposts: Codable{
    let count: Int
}
