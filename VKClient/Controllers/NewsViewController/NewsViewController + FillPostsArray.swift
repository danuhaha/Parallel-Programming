//
//  NewsViewController + FillPostsArray.swift
//  VKClient
//
//  Created by danuhaha on 28.10.2021.
//

import UIKit
import Alamofire

extension NewsViewController {

    func getImage(from url: String) -> UIImage? {
        var image: UIImage?
        guard let imageURL = URL(string: url) else { return nil }

        guard let imageData = try? Data(contentsOf: imageURL) else { return nil }
        image = UIImage(data: imageData)

        return image
    }

    func fillPostsArray(_ postNewsInitialResponse: PostNewsInitialResponse) {
        //let dispatchGroup = DispatchGroup()

        let posts = postNewsInitialResponse.response.items
        let profiles = postNewsInitialResponse.response.profiles
        let groups = postNewsInitialResponse.response.groups

        var title = ""
        var avatar = UIImage()

        for i in posts {

            for j in profiles {
                if j.id == abs(i.source_id) {
                    title = "\(j.firstName) \(j.lastName)"
                    avatar = self.getImage(from: j.avatar)!
                }
            }
            for k in groups {
                if k.id == abs(i.source_id) {
                    title = k.name
                    avatar = self.getImage(from: k.avatar)!
                }
            }

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

            //DispatchQueue.global().async(group: dispatchGroup) {
            if i.attachments == nil || i.attachments![0].photo == nil {
                self.postsArray.append(Post(group: Group(title: title, avatar: avatar), date: strDate, postText: i.text, postImage: nil, likeCount: i.likes.count, isLiked: isLiked, commentCount: i.comments.count, repostCount: i.reposts.count, viewCount: i.views?.count ?? 0))
            } else {
                guard let photo = self.getImage(from: i.attachments![0].photo!.sizes[6].url) else { return }
                self.postsArray.append(Post(group: Group(title: title, avatar: avatar), date: strDate, postText: i.text, postImage: photo, likeCount: i.likes.count, isLiked: isLiked, commentCount: i.comments.count, repostCount: i.reposts.count, viewCount: i.views?.count ?? 0))

            }
            //}
        }
    }

    func getPostNewsInitialResponse() {

        AF.request("https://api.vk.com/method/newsfeed.get", parameters: [
            "v": "5.131",
            "filters": "post",
            "access_token": session.token
            ]).responseData { data in
            guard let data = data.value else { return }

            do {
                let response = try JSONDecoder().decode(PostNewsInitialResponse.self, from: data)
                self.fillPostsArray(response)
                self.newsTableView.reloadData()
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
