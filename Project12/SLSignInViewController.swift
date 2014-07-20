//
//  SLSignInViewController.swift
//  Project12
//
//  Created by Justin Sacbibit on 2014-07-20.
//  Copyright (c) 2014 Hicham Abou Jaoude. All rights reserved.
//

import UIKit

class SLSignInViewController: UITableViewController, UITextFieldDelegate {
    
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
        self.tableView.registerClass(SLTextFieldCell.classForCoder(), forCellReuseIdentifier: "Cell")
    }
    
    // #pragma mark - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return SLSignInSection.count.toRaw()
    }
    
    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
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
        } else if indexPath?.section == SLSignInSection.signIn.toRaw(){
            cell.textLabel.text = "Sign In"
            cell.contentView.backgroundColor =  UIColor(red: 0.84, green: 0.25, blue: 0.92, alpha: 1)
            cell.textLabel.backgroundColor = UIColor(red: 0.84, green: 0.25, blue: 0.92, alpha: 1)
            cell.textLabel.textColor = UIColor.whiteColor()
            cell.textLabel.textAlignment = NSTextAlignment.Center
            cell.textField.hidden = true
        }
        
        return cell
    }
    
    func signIn() -> (){
        PFUser.logInWithUsernameInBackground(email, password: password) {
            (user: PFUser!, error: NSError!) -> Void in
            
        }
    }
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        signIn()
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
