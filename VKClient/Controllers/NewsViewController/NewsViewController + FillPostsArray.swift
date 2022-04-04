//
//  NewsViewController + FillPostsArray.swift
//  VKClient
//
//  Created by danuhaha on 28.10.2021.
//

import UIKit

extension NewsViewController {
    
    func fillPostsArray() {
        let post1 = Post(group: Group(title: "Fast Food Music", avatar: UIImage(named: "ffm")!), date: "2 часа назад", postText: "Вышел новый альбом Eternal Atake от Lil Uzi Vert!", postImage: nil)
        let post2 = Post(group: Group(title: "Fast Food Music", avatar: UIImage(named: "ffm")!), date: "вчера", postText: nil , postImage: UIImage(named: "aj1")!)
        let post3 = Post(group: Group(title: "Zloy SoundCloud", avatar: UIImage(named: "zloy")!), date: "5 часов назад", postText: "Вспомним дебютный альбом Playboi Carti", postImage: UIImage(named: "dielit")!)
        posts.append(post1)
        posts.append(post2)
        posts.append(post3)
    }
   
}
