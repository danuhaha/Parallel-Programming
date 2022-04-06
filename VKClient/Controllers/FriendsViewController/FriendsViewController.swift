//
//  FriendsViewController.swift
//  VKClient
//
//  Created by Daniil on 16.10.2021.
//

import UIKit

class FriendsViewController: UIViewController {

    let session = Session.instance
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var searchBar: UISearchBar!

    var friendsArray = [Friend]()
    var savedFriendsArray = [Friend]()

    func arrayLetter(sourceArray: [Friend]) -> [String] {
        var resultArray = [String]()
        for item in sourceArray {
            let nameLetter = String(item.firstName.prefix(1))
            if !resultArray.contains(nameLetter.lowercased()) {
                resultArray.append(nameLetter.lowercased())
            }
        }
        return resultArray
    }

    func arrayByLetter(letter: String, sourceArray: [Friend]) -> [Friend] {
        var resultArray = [Friend]()
        for item in sourceArray {
            let nameLetter = String(item.firstName.prefix(1))
            if nameLetter.lowercased() == letter.lowercased() {
                resultArray.append(item)
            }
        }
        return resultArray
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.getFriendsInitialResponse()
        }
        
        
        savedFriendsArray = friendsArray
        tableView.register(UINib(nibName: customTableViewCell, bundle: nil), forCellReuseIdentifier:
                reuseIdentifierCustom)
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        tapRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    @objc func tapFunction() {
        self.view.endEditing(true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromFriendsToGallerySegue",
            //let sourceVC = segue.source as? FriendsViewController,
            let destinationVC = segue.destination as? GalleryViewController,
            let friend = sender as? Friend {
            destinationVC.friendId = friend.id
            destinationVC.avatar = friend.avatar
        }

    }
}


