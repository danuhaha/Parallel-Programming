//
//  NewsPhoto.swift
//  VKClient
//
//  Created by danuhaha on 11.04.2022.
//

import UIKit

class NewsPhoto: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var postImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        postImageView.image = nil
    }

    func configure(post: Post) {
        if post.postImage != nil {
            postImageView.image = post.postImage
            let ratio = post.postImage!.size.width / post.postImage!.size.height
            view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: ratio).isActive = true
            view.layoutIfNeeded()
        } else {
            view.widthAnchor.constraint(equalToConstant: 0).isActive = true
            view.heightAnchor.constraint(equalToConstant: 0).isActive = true
            view.layoutIfNeeded()
        }
    }
}
