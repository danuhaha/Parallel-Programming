//
//  NewsReactions.swift
//  VKClient
//
//  Created by danuhaha on 11.04.2022.
//

import UIKit

class NewsReactions: UITableViewCell {

    @IBOutlet weak var likeCounterLabel: UILabel!
    @IBOutlet weak var viewCounterLabel: UILabel!
    @IBOutlet weak var repostCounterLabel: UILabel!
    @IBOutlet weak var commentCounerLabel: UILabel!

    var liked = false
    var likeCount = 0
    var likeImage = UIImage(systemName: "heart")

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        liked = false
        likeImage = UIImage(systemName: "heart")
    }

    func configure(post: Post) {
        liked = post.isLiked
        likeCount = post.likeCount
        if post.isLiked {
            likeImage = UIImage(systemName: "heart.fill")
        } else {
            likeImage = UIImage(systemName: "heart")
        }
        likeCounterLabel.text = "\(post.likeCount)"
        commentCounerLabel.text = "\(post.commentCount)"
        repostCounterLabel.text = "\(post.repostCount)"
        viewCounterLabel.text = "\(post.viewCount)"
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

