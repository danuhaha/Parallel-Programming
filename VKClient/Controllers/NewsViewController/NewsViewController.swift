//
//  NewsViewController.swift
//  VKClient
//
//  Created by danuhaha on 26.10.2021.
//

import UIKit

class NewsViewController: UIViewController {
    @IBOutlet weak var newsTableView: UITableView!

    let session = Session.instance
    

    var postsArray = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getPostNewsInitialResponse()
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.register(UINib(nibName: newsHeaderCell, bundle: nil), forCellReuseIdentifier: reuseIdentifierNewsHeaderCell)
        newsTableView.register(UINib(nibName: newsTextCell, bundle: nil), forCellReuseIdentifier: reuseIdentifierNewsTextCell)
        newsTableView.register(UINib(nibName: newsPhotoCell, bundle: nil), forCellReuseIdentifier: reuseIdentifierNewsPhotoCell)
        newsTableView.register(UINib(nibName: newsReactionsCell, bundle: nil), forCellReuseIdentifier: reuseIdentifierNewsReactionsCell)
        newsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }


}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//class PostArray {
//    private var posts = [Post]()
//    private let syncQueue = DispatchQueue(label: "PostArraySyncQueue",
//        attributes: .concurrent)
//
//    func append(_ post: Post) {
//        syncQueue.async(flags: .barrier) {
//            self.posts.append(post) }
//    }
//
//    subscript(_ index: Int) -> Post {
//      get {
//        return posts[index]
//      }
//      set {
//        posts[index] = newValue
//      }
//    }
//
//    func count() -> Int {
//        return posts.count
//    }
//}
