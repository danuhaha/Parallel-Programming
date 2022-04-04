//
//  NewsCell.swift
//  VKClient
//
//  Created by danuhaha on 26.10.2021.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var postTextLabel: UILabel!

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var postImagevView: UIImageView!

    @IBOutlet weak var likeCounterLabel: UILabel!

    var liked = false
    var likeCount = 0
    var likeImage = UIImage(systemName: "heart")

    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.cornerRadius = 25
        avatarView.layer.cornerRadius = 25
        //avatarView.layer.shadowColor = UIColor.black.cgColor
        //avatarView.layer.shadowRadius = CGFloat(1)
        //avatarView.layer.shadowOpacity = 1
        //avatarView.layer.shadowOffset = CGSize(width: 2, height: 2)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        groupNameLabel.text = nil
        dateLabel.text = nil
        postTextLabel.text = nil
        postImagevView.image = nil
        liked = false
        likeImage = UIImage(systemName: "heart")
        likeCount = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(post: Post) {
        avatarImageView.image = post.group.avatar
        groupNameLabel.text = post.group.title
        dateLabel.text = post.date
        if post.postText != nil {
            postTextLabel.text = post.postText
        } else {
            postTextLabel.removeFromSuperview()
        }
        if post.postImage != nil {
            postImagevView.image = post.postImage
        } else {
            view.removeFromSuperview()
        }
    }

    @IBAction func pressLikeButton(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        if liked {
            likeImage = UIImage(systemName: "heart")
            button.setImage(likeImage, for: .normal)
            likeCount -= 1
            liked = false
        } else {
            likeImage = UIImage(systemName: "heart.fill")
            button.setImage(likeImage, for: .normal)
            likeCount += 1
            liked = true

            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {
                button.transform = CGAffineTransform(rotationAngle: .pi / 4)
            }) { _ in
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: {
                        button.transform = CGAffineTransform.identity
                    })
            }
        }
        likeCounterLabel.text = "\(likeCount)"
    }
}
