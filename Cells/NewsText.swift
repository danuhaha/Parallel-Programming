//
//  NewsText.swift
//  VKClient
//
//  Created by danuhaha on 11.04.2022.
//

import UIKit

class NewsText: UITableViewCell {

    @IBOutlet weak var postTextView: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        postTextView.isEditable = false
        postTextView.text = nil
    }

    func configure(post: Post) {
        if post.postText != "" {
            postTextView.text = post.postText
        } else {
            postTextView.widthAnchor.constraint(equalToConstant: 0).isActive = true
            postTextView.heightAnchor.constraint(equalToConstant: 0).isActive = true
            postTextView.layoutIfNeeded()
        }
    }
}
