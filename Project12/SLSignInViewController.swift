//
//  SLSignInViewController.swift
//  Project12
//
//  Created by Justin Sacbibit on 2014-07-20.
//  Copyright (c) 2014 Hicham Abou Jaoude. All rights reserved.
//

import UIKit

protocol SLSignInViewControllerDelegate {
    func signInViewControllerDidCancelSignIn(signInViewController: SLSignInViewController)
}

class SLSignInViewController: UITableViewController, UITextFieldDelegate {
    
    var delegate: SLSignInViewControllerDelegate?
    
    var email = ""
    var password = ""
    
    enum SLSignInSection: Int {
        case email = 0
        case password
        case signIn
        case count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sign In"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: Selector("signInCancelled"))
        self.navigationController.setToolbarHidden(true, animated: false)
        self.tableView.registerClass(SLTextFieldCell.classForCoder(), forCellReuseIdentifier: "Cell")
    }
    
    func signInCancelled() {
        delegate?.signInViewControllerDidCancelSignIn(self)
    }
    
    // #pragma mark - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return SLSignInSection.count.toRaw()
    }
    
    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        if (section == SLSignInSection.signIn.toRaw()) {
            return 2
        }
        
        return 1
    }
    
    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        var cell:SLTextFieldCell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as SLTextFieldCell
        
        cell.textField.tag = indexPath!.section
        cell.textField.delegate = self
        
        if indexPath?.section == SLSignInSection.email.toRaw() {
            cell.textField.placeholder = "Email Address"
        } else if indexPath?.section == SLSignInSection.password.toRaw() {
            cell.textField.placeholder = "Password"
        } else if indexPath?.section == SLSignInSection.signIn.toRaw() {
            if indexPath?.row == 0 {
                cell.textLabel.text = "Sign In"
            } else if indexPath?.row == 1 {
                cell.textLabel.text = "Forgot Password"
            }
            cell.contentView.backgroundColor =  UIColor(red: 0.84, green: 0.25, blue: 0.92, alpha: 1)
            cell.textLabel.backgroundColor = UIColor(red: 0.84, green: 0.25, blue: 0.92, alpha: 1)
            cell.textLabel.textColor = UIColor.whiteColor()
            cell.textLabel.textAlignment = NSTextAlignment.Center
            cell.textField.hidden = true
        }
        
        return cell
    }
    
    func signIn() -> () {
        PFUser.logInWithUsernameInBackground(email, password: password) {
            (user: PFUser!, error: NSError!) -> Void in
            
        }
    }
    
    func forgotPassword() -> () {
        PFUser.requestPasswordResetForEmailInBackground(email)
    }
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath?.row == 0 {
            signIn()
        } else if indexPath?.row == 1 {
            forgotPassword()
        }
    }
    
    func textField(textField: UITextField!, shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool {
        var text = textField.text + string
        switch textField.tag {
        case SLSignInSection.email.toRaw():
            email = text
        case SLSignInSection.password.toRaw():
            password = text
        default:
            break
        }
        return true
    }
}
