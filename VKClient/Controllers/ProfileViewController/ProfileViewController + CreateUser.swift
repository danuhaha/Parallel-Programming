//
//  ProfileViewController + CreateUser.swift
//  VKClient
//
//  Created by danuhaha on 30.10.2021.
//

import UIKit
import Alamofire

extension ProfileViewController {

    func getImage(from url: String) -> UIImage? {
        var image: UIImage?
        guard let imageURL = URL(string: url) else { return nil }

        guard let imageData = try? Data(contentsOf: imageURL) else { return nil }
        image = UIImage(data: imageData)

        return image
    }

    func fillFriendsArray(_ friendsInitialResponse: FriendsInitialResponse) {

        let friendsCount = friendsInitialResponse.response.items.count
        let friends = friendsInitialResponse.response.items

        for i in 0...friendsCount - 1 {
            guard let avatar = getImage(from: friends[i].avatar) else { return }
            if friends[i].status != "" {
                friendsArray.append(Friend(firstName: friends[i].firstName, lastName: friends[i].lastName, avatar: avatar, status: friends[i].status, photos: [UIImage()]))
            } else {
                friendsArray.append(Friend(firstName: friends[i].firstName, lastName: friends[i].lastName, avatar: avatar, status: friends[i].domain, photos: [UIImage()]))
            }
        }

        friendsArray = friendsArray.sorted { $0.firstName.lowercased() < $1.firstName.lowercased() }
    }

    func fillPhotosArray(_ photosInitialResponse: PhotosInitialResponse) {
        let photosCount = photosInitialResponse.response.items.count
        let photos = photosInitialResponse.response.items

        for i in 0...photosCount - 1 {
            guard let photo = getImage(from: photos[i].sizes[6].url) else { return }
            photosArray.append(photo)
        }
    }

    func createUser(_ userInitialResponse: UserInitialResponse) {
        guard let avatar = getImage(from: userInitialResponse.response.avatar) else { return }
        let firsNname = userInitialResponse.response.firstName
        let lastName = userInitialResponse.response.lastName
        let name = "\(firsNname) \(lastName)"
        let status = userInitialResponse.response.status
        let birthday = userInitialResponse.response.birthday
        let hometown = userInitialResponse.response.city.title
        let university = userInitialResponse.response.universityName
        let faculty = userInitialResponse.response.facultyName
        let education = "\(university), \(faculty)"
        
        self.avatarImage.image = avatar
        self.avatarImage.layer.cornerRadius = 60
        self.avatarImageView.layer.cornerRadius = 60
        
        self.nameLabel.text = name
        self.statusLabel.text = status
        self.birthdayLabel.text = birthday
        self.hometownLabel.text = hometown
        self.educationLabel.text = education

    }

    func getFriendsInitialResponse() {

        AF.request("https://api.vk.com/method/friends.get", parameters: [
            "v": "5.131",
            "lang": "en",
            "order": "hints",
            "count": "50",
            "fields": "photo_200,status,domain",
            "access_token": session.token
            ]).responseData { data in
            guard let data = data.value else { return }

            do {
                guard let response = try? JSONDecoder().decode(FriendsInitialResponse.self, from: data) else { return }
                self.fillFriendsArray(response)
                DispatchQueue.main.async {
                    self.friendsCollectionView.reloadData()
                }
            }
        }
    }

    func getPhotosInitialResponse() {

        AF.request("https://api.vk.com/method/photos.get", parameters: [
            "v": "5.131",
            "album_id": "profile",
            "rev": "1",
            "photos_sizes": "1",
            "extended": "1",
            "count": "6",
            "access_token": session.token
            ]).responseData { data in
            guard let data = data.value else { return }

            do {
                guard let response = try? JSONDecoder().decode(PhotosInitialResponse.self, from: data) else { return }
                self.fillPhotosArray(response)
                DispatchQueue.main.async {
                    self.photosCollectionView.reloadData()
                }
            }
        }
    }

    func getUserInitialResponse() {

        AF.request("https://api.vk.com/method/users.get", parameters: [
            "v": "5.131",
            "fields": "photo_max,status,city,education,bdate",
            "access_token": session.token
            ]).responseData { data in
            guard let data = data.value else { return }

            do {
                guard let response = try? JSONDecoder().decode(UserInitialResponse.self, from: data) else { return }
                self.createUser(response)
                
            }
        }
    }

    func fillPostsArray() {
    //    let post1 = Post(group: Group(title: "Danya Gorin", avatar: UIImage(named: "profile")!), date: "2 часа назад", //postText: "Вышел новый альбом Eternal Atake от Lil Uzi Vert!", postImage: UIImage(named: "eternalAtake")!)
    //    let post2 = Post(group: Group(title: "Danya Gorin", avatar: UIImage(named: "profile")!), date: "5 часов //назад", postText: "Новая расцветка Air Jordan 1 от Travis Scott", postImage: UIImage(named: "aj1")!)
    //    let post3 = Post(group: Group(title: "Danya Gorin", avatar: UIImage(named: "profile")!), date: "вчера", //postText: "Вспомним дебютный альбом Playboi Carti", postImage: UIImage(named: "dielit")!)
    //    postsArray.append(post1)
    //    postsArray.append(post2)
    //    postsArray.append(post3)
    }

}
