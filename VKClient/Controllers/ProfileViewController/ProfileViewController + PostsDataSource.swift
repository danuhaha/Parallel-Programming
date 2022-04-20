//
//  ProfileViewController + PostsDataSource.swift
//  VKClient
//
//  Created by danuhaha on 30.10.2021.
//

import UIKit

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return postsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierNewsHeaderCell, for: indexPath) as? NewsHeader else { return UITableViewCell() }
            cell.configure(post: postsArray[indexPath.section])
            return cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierNewsTextCell, for: indexPath) as? NewsText else { return UITableViewCell() }
            cell.configure(post: postsArray[indexPath.section])
            return cell
        } else if indexPath.row == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierNewsPhotoCell, for: indexPath) as? NewsPhoto else { return UITableViewCell() }
            cell.configure(post: postsArray[indexPath.section])
            return cell
        } else if indexPath.row == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierNewsReactionsCell, for: indexPath) as? NewsReactions else { return UITableViewCell() }
            cell.configure(post: postsArray[indexPath.section])
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
