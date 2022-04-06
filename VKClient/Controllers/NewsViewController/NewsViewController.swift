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
        newsTableView.register(UINib(nibName: newsCell, bundle: nil), forCellReuseIdentifier: reuseIdentifierNewsCell)
    }
    

}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
