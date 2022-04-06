//
//  GalleryViewController.swift
//  VKClient
//
//  Created by Daniil on 16.10.2021.
//

import UIKit
import Alamofire

class GalleryViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var photos = [UIImage]()
    var friendId = Int()
    var avatar = UIImage()

    var fullScreenView: UIView?
    var galleryView: GallerylView?

    let session = Session.instance

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.getFriendsPhotosInitialResponse()
        }

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: galleryCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: reuseIdentifierGalleryCell)
    }

    func getFriendsPhotosInitialResponse() {

        AF.request("https://api.vk.com/method/photos.get", parameters: [
            "v": "5.131",
            "album_id": "wall",
            "rev": "1",
            "photos_sizes": "1",
            "extended": "1",
            "count": "20",
            "access_token": session.token,
            "user_id": friendId
            ]).responseData { data in
            guard let data = data.value else { return }
            guard let response = try? JSONDecoder().decode(PhotosInitialResponse.self, from: data) else { return }
            self.fillPhotos(response)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }


    func fillPhotos(_ friendsPhotosInitialResponse: PhotosInitialResponse) {

        let friendPhotosCount = friendsPhotosInitialResponse.response.items.count
        let friendPhotos = friendsPhotosInitialResponse.response.items

        if friendPhotosCount > 1 {
            for i in 0...friendPhotosCount - 1 {
                guard let photo = getImage(from: friendPhotos[i].sizes[6].url) else { return }
                photos.append(photo)
            }
        } else {
            photos.append(avatar)
        }
    }

    func getImage(from url: String) -> UIImage? {
        var image: UIImage?
        guard let imageURL = URL(string: url) else { return nil }

        guard let imageData = try? Data(contentsOf: imageURL) else { return nil }
        image = UIImage(data: imageData)

        return image
    }
}
