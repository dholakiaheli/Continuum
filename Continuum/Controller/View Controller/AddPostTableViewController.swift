//
//  AddPostTableViewController.swift
//  Continuum
//
//  Created by Heli Bavishi on 12/8/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import UIKit

class AddPostTableViewController: UITableViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var captionTextField: UITextField!
    
    
    //MARK: - Properties
    var imageFromPhotoSelectorVC: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        captionTextField.text = ""
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0
    }
    
    @IBAction func addPostButtonTapped(_ sender: Any) {
        
        guard let photo = imageFromPhotoSelectorVC, let caption = captionTextField.text else { return }
        PostController.shared.createPostWith(image: photo, caption: caption) { (result) in }
        self.tabBarController?.selectedIndex = 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhotoSelectorVC" {
            let photoSelectorVC = segue.destination as? PhotoSelectorViewController
            photoSelectorVC?.delegate = self
        }
    }
    
} //End of class

extension AddPostTableViewController: PhotoSelectorViewControllerDelegate {
    func photoSelectorViewControllerSelected(image: UIImage) {
        imageFromPhotoSelectorVC = image
    }
}
