//
//  CommentsController.swift
//  ecommerce
//
//  Created by Amanda Fernandes on 17/04/2017.
//  Copyright © 2017 Amanda Fernandes. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CommentsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var numberOfComments: UILabel!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var bottomConstraintForKeyboard: NSLayoutConstraint!
    
    
    var product: Product!
    
    @IBAction func addCommentBtn(_ sender: Any) {
        let commentRef = DataService.dataService.REF_PRODUCTS.child(product.productID).child("comments")
        commentRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value {
                if (self.commentTextField.text != " ") {
                    let comment = self.commentTextField.text!
                    self.product.addComment(comment: comment)
                    self.commentTextField.text = ""
                    self.viewDidAppear(true)
                }
            }
        })
    }

    override func viewDidAppear(_ animated: Bool) {
        self.numberOfComments.text = String(product.comments.count)
        self.tableView.reloadData()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (product.comments.count)
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? CommentsCellController {
            let comment = product.comments[indexPath.row]
            cell.configureCell(comment: comment)
            return cell
        } else {
            return CommentsCellController()
        }
    }
    
    func keyboardWillShow(sender: NSNotification) {
        let i = sender.userInfo!
        let k = (i[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        bottomConstraintForKeyboard.constant = k - bottomLayoutGuide.length
        let s: TimeInterval = (i[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        UIView.animate(withDuration: s) { self.view.layoutIfNeeded() }
    }
    
    func keyboardWillHide(sender: NSNotification) {
        let info = sender.userInfo!
        let s: TimeInterval = (info[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        bottomConstraintForKeyboard.constant = 0
        UIView.animate(withDuration: s) { self.view.layoutIfNeeded() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
            selector: #selector(keyboardWillShow),
            name: Notification.Name.UIKeyboardWillShow,
            object: nil)
        NotificationCenter.default.addObserver(self,
            selector: #selector(keyboardWillHide),
            name: Notification.Name.UIKeyboardWillHide,
            object: nil)
    }
}
