//
//  NewsHeader.swift
//  VKClient
//
//  Created by danuhaha on 11.04.2022.
//

import UIKit

class NewsHeader: UITableViewCell {

    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.cornerRadius = 25
        avatarView.layer.cornerRadius = 25
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        groupNameLabel.text = nil
        dateLabel.text = nil
    }

    func configure(post: Post) {
        avatarImageView.image = post.group.avatar
        groupNameLabel.text = post.group.title
        dateLabel.text = post.date
    }

}
