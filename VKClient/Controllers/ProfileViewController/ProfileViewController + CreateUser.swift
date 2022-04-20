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
        guard let avatar = getImage(from: userInitialResponse.response[0].avatar) else { return }
        let firsNname = userInitialResponse.response[0].firstName
        let lastName = userInitialResponse.response[0].lastName
        let name = "\(firsNname) \(lastName)"
        let status = userInitialResponse.response[0].status
        let birthday = userInitialResponse.response[0].birthday
        let hometown = userInitialResponse.response[0].city.title
        let university = userInitialResponse.response[0].universityName
        let faculty = userInitialResponse.response[0].facultyName
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
                let response = try JSONDecoder().decode(UserInitialResponse.self, from: data) 
                self.createUser(response)
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context) {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }
    }

    func fillPostsArray(_ wallInitialResponse: WallInitialResponse) {

        let posts = wallInitialResponse.response.items

        var title = self.nameLabel.text
        var avatar = self.avatarImage.image

        for i in posts {

            var isLiked = true
            if i.likes.isLiked == 0 {
                isLiked = false
            }

            let date = Date(timeIntervalSince1970: TimeInterval(i.date))
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT+3")
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "MMM d, h:mm a"
            let strDate = dateFormatter.string(from: date)

            if i.attachments == nil || i.attachments![0].photo == nil {
                self.postsArray.append(Post(group: Group(title: title!, avatar: avatar!), date: strDate, postText: i.text, postImage: nil, likeCount: i.likes.count, isLiked: isLiked, commentCount: i.comments.count, repostCount: i.reposts.count, viewCount: i.views.count))
            } else {
                guard let photo = self.getImage(from: i.attachments![0].photo!.sizes[6].url) else { return }
                self.postsArray.append(Post(group: Group(title: title!, avatar: avatar!), date: strDate, postText: i.text, postImage: photo, likeCount: i.likes.count, isLiked: isLiked, commentCount: i.comments.count, repostCount: i.reposts.count, viewCount: i.views.count))

            }
        }
    }

    func getWallInitialResponse() {

        AF.request("https://api.vk.com/method/wall.get", parameters: [
            "v": "5.131",
            "filter": "owner",
            "access_token": session.token
            ]).responseData { data in
            guard let data = data.value else { return }

            do {
                let response = try JSONDecoder().decode(WallInitialResponse.self, from: data)
                self.fillPostsArray(response)
                self.postsTableView.reloadData()
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context) {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }

        }
    }

}
