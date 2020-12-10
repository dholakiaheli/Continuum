//
//  PostDetailTableViewController.swift
//  Continuum
//
//  Created by Heli Bavishi on 12/8/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import UIKit

class PostDetailTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var photoImageView: UIImageView!
    var post: Post? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Methods
    func updateViews() {
        guard let post = post else { return }
        photoImageView.image = post.photo
    }
    
    //MARK: - Actions
    
    @IBAction func followButtonTapped(_ sender: Any) {
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        guard let image = photoImageView.image,
              let comment = post?.caption
              else { return }
        let activityController = UIActivityViewController(activityItems: [image,comment], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    @IBAction func commentButtonTapped(_ sender: Any) {
        guard let post = post else { return }
        presentCommentAlertController(for: post)
    }
    func presentCommentAlertController(for post: Post) {
        
        let alert = UIAlertController(title: "Add Comment", message: "Add your Comments here", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Type your comment here.."
            textField.delegate = self
            textField.autocorrectionType = .yes
        }
        
        let commentAction = UIAlertAction(title: "Add Comment", style: .default) { (_) in
            guard let text = alert.textFields?.first?.text, !text.isEmpty,
                  let post = self.post else { return }
            
            PostController.shared.addComment(text: text, post: post) { (result) in
                switch result {
                case .success(let comment):
                    post.comments.insert(comment, at: 0)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .default)
        
        alert.addAction(commentAction)
        alert.addAction(cancelButton)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post?.comments.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath)
        
        if let post = post {
            let comment = post.comments[indexPath.row]
            
            cell.textLabel?.text = comment.text
            cell.detailTextLabel?.text = ("\(comment.timestamp)")
        }
        return cell
    }
    
    
}
