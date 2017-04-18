//
//  CommentsCellController.swift
//  ecommerce
//
//  Created by Amanda Fernandes on 17/04/2017.
//  Copyright © 2017 Amanda Fernandes. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CommentsCellController: UITableViewCell {
    @IBOutlet weak var commentText: UITextView!
    @IBOutlet weak var authorsName: UILabel!
    
    var comment = [String: String]()
    
    func configureCell(comment: [String: String]) {
        self.comment = comment
        self.commentText.text = comment["text"]
        findAuthor()
    }
    
    func findAuthor() {
        if let authorUID = comment["author"] {
            DataService.dataService.REF_USERS.child(authorUID).child("name").observe(.value, with: { (snapshot) in
                
                if let author = snapshot.value as? String {
                    self.authorsName.text = "\(author) commented:"
                }
            })
            
        }
    }
}
