//
//  Post.swift
//  VKClient
//
//  Created by danuhaha on 30.10.2021.
//

import UIKit

struct Post {
    var group = Group()
    var date = String()
    var postText: String?
    var postImage: UIImage?
    var likeCount: Int
    var isLiked: Bool
    var commentCount: Int
    var repostCount: Int
    var viewCount: Int
}
