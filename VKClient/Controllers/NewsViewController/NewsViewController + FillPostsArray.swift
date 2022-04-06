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
        let posts = postNewsInitialResponse.response.items

        for i in posts {
            print(i.source_id)
            print(abs(i.source_id))

            var groupTitle = ""
            var groupPhoto = UIImage()

            if i.source_id < 0 {
                AF.request("https://api.vk.com/method/groups.getById", parameters: [
                    "v": "5.131",
                    "group_id": "\(abs(i.source_id))",
                    "access_token": session.token
                    ]).responseData { data in
                    guard let data = data.value else { return }

                    do {
                        let groupResponse = try JSONDecoder().decode(GroupResponse.self, from: data)
                        groupTitle = groupResponse.name ?? "lol"
                        groupPhoto = self.getImage(from: groupResponse.photo_200 ?? "lol") ?? UIImage()
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
            } else {
                AF.request("https://api.vk.com/method/users.get", parameters: [
                    "v": "5.131",
                    "user_ids": "\(abs(i.source_id))",
                    "access_token": session.token,
                    "fields": "photo_max"
                    ]).responseData { data in
                    guard let data = data.value else { return }

                    do {
                        let userResponse = try JSONDecoder().decode(UserIdResponse.self, from: data)
                        groupTitle = "\(userResponse.firstName) \(userResponse.lastName)"
                        groupPhoto = self.getImage(from: userResponse.avatar ?? "lol") ?? UIImage()
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

            if i.attachments != nil {
                if i.attachments![0].photo != nil {
                    guard let photo = getImage(from: i.attachments![0].photo!.sizes[6].url) else { return }
                    postsArray.append(Post(group: Group(title: groupTitle, avatar: groupPhoto), date: strDate, postText: i.text, postImage: photo, likeCount: i.likes.count, isLiked: isLiked, commentCount: i.comments.count, repostCount: i.reposts.count, viewCount: i.views!.count))
                } else {
                    postsArray.append(Post(group: Group(title: groupTitle, avatar: groupPhoto), date: strDate, postText: i.text, postImage: nil, likeCount: i.likes.count, isLiked: isLiked, commentCount: i.comments.count, repostCount: i.reposts.count, viewCount: i.views!.count))
                }
            } else {
                postsArray.append(Post(group: Group(title: groupTitle, avatar: groupPhoto), date: strDate, postText: i.text, postImage: nil, likeCount: i.likes.count, isLiked: isLiked, commentCount: i.comments.count, repostCount: i.reposts.count, viewCount: i.views!.count))
            }

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
                DispatchQueue.main.async {
                    self.newsTableView.reloadData()
                }
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
