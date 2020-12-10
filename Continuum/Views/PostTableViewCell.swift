//
//  PostTableViewCell.swift
//  Continuum
//
//  Created by Heli Bavishi on 12/8/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    
    //MARK:- Methods
    var post: Post? {
    didSet {
        updateViews()
     }
    }
    //MARK:- Helper Methods
    func updateViews() {
        guard let post = post else { return }
        postImageView.image = post.photo
        captionLabel.text = post.caption
        commentCountLabel.text = "\(post.comments.count) comments"
    }
}
