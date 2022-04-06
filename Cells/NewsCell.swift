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

    @IBOutlet weak var postTextLabel: UITextView!
    

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var postImagevView: UIImageView!

    @IBOutlet weak var likeCounterLabel: UILabel!
    @IBOutlet weak var commentCounterlabel: UILabel!
    @IBOutlet weak var repostCounterLabel: UILabel!
    @IBOutlet weak var viewCounterLabel: UILabel!

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
        postTextLabel.isEditable = false
        super.prepareForReuse()
        avatarImageView.image = nil
        groupNameLabel.text = nil
        dateLabel.text = nil
        postTextLabel.text = nil
        postImagevView.image = nil
        liked = false
        likeImage = UIImage(systemName: "heart")
        view.widthAnchor.constraint(equalToConstant: 0).isActive = true
        view.heightAnchor.constraint(equalToConstant: 0).isActive = true
        view.layoutIfNeeded()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(post: Post) {
        liked = post.isLiked
        likeCount = post.likeCount
        likeCounterLabel.text = "\(post.likeCount)"
        commentCounterlabel.text = "\(post.commentCount)"
        repostCounterLabel.text = "\(post.repostCount)"
        viewCounterLabel.text = "\(post.viewCount)"
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
            let ratio = post.postImage!.size.width / post.postImage!.size.height
            view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: ratio).isActive = true
            //view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/1).isActive = true
            view.layoutIfNeeded()
        } else {
            view.widthAnchor.constraint(equalToConstant: 0).isActive = true
            view.heightAnchor.constraint(equalToConstant: 0).isActive = true
            view.layoutIfNeeded()
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
