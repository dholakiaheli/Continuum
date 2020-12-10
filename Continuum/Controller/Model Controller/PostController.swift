//
//  PostController.swift
//  Continuum
//
//  Created by Heli Bavishi on 12/8/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import Foundation
import UIKit

class PostController {
    
    static let shared = PostController()
    var posts: [Post] = [Post(photo: #imageLiteral(resourceName: "forest"), caption: "test")]
   // var posts: [Post] = []
    
    func addComment(text: String, post: Post, completion: @escaping (Result<Comment, PostError>) -> Void) {
        
        let comment = Comment(text: text, post: post)
        completion(.success(comment))
    }
    
    func createPostWith(image: UIImage, caption: String, completion: @escaping (Result<Post?, PostError>) -> Void) {
        let post = Post(photo: image, caption: caption)
        posts.append(post)
    }
}
