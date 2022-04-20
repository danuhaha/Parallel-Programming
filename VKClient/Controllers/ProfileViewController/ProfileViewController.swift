//
//  ProfileViewController.swift
//  VKClient
//
//  Created by danuhaha on 26.10.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let session = Session.instance

    var friendsArray = [Friend]()
    var photosArray = [UIImage]()
    var postsArray = [Post]()
    var user = User()

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var avatarImageView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var hometownLabel: UILabel!
    @IBOutlet weak var educationLabel: UILabel!
    @IBOutlet weak var photosCollectionView: UICollectionView!
    @IBOutlet weak var friendsCollectionView: UICollectionView!
    @IBOutlet weak var postsTableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.getFriendsInitialResponse()
            self.getPhotosInitialResponse()
            self.getUserInitialResponse()
            self.getWallInitialResponse()
        }
    

        friendsCollectionView.dataSource = self
        friendsCollectionView.delegate = self
        friendsCollectionView.register(UINib(nibName: friendCell, bundle: nil), forCellWithReuseIdentifier: reuseIdentifierFriendCell)

        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        photosCollectionView.register(UINib(nibName: galleryCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: reuseIdentifierGalleryCell)

        postsTableView.delegate = self
        postsTableView.dataSource = self
        postsTableView.register(UINib(nibName: newsHeaderCell, bundle: nil), forCellReuseIdentifier: reuseIdentifierNewsHeaderCell)
        postsTableView.register(UINib(nibName: newsTextCell, bundle: nil), forCellReuseIdentifier: reuseIdentifierNewsTextCell)
        postsTableView.register(UINib(nibName: newsPhotoCell, bundle: nil), forCellReuseIdentifier: reuseIdentifierNewsPhotoCell)
        postsTableView.register(UINib(nibName: newsReactionsCell, bundle: nil), forCellReuseIdentifier: reuseIdentifierNewsReactionsCell)
        postsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none

        postsTableView.isScrollEnabled = false
        photosCollectionView.isScrollEnabled = false

    }





}
