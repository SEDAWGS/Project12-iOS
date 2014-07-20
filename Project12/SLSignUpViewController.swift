//
//  SLSignUpView.swift
//  Project12
//
//  Created by Hicham Abou Jaoude on 2014-07-19.
//  Copyright (c) 2014 Hicham Abou Jaoude. All rights reserved.
//

import Foundation

class SLSignUpViewController: UITableViewController  {
    
    enum SLSignUpSection: Int {
        case username = 0
        case password
        case email
        case signUp
        case count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(SLTextFieldCell.classForCoder(), forCellReuseIdentifier: "Cell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // #pragma mark - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return SLSignUpSection.count.toRaw()
    }
    
    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        var cell:SLTextFieldCell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as SLTextFieldCell
        
        if indexPath?.section == SLSignUpSection.username.toRaw(){
            cell.textField.placeholder = "Username"
        } else if indexPath?.section == SLSignUpSection.password.toRaw(){
            cell.textField.placeholder = "Password"
        } else if indexPath?.section == SLSignUpSection.email.toRaw(){
            cell.textField.placeholder = "Email Address"
        } else if indexPath?.section == SLSignUpSection.signUp.toRaw(){
            cell.textLabel.text = "Sign Up"
            cell.contentView.backgroundColor =  UIColor(red: 0.84, green: 0.25, blue: 0.92, alpha: 1)
            cell.textLabel.backgroundColor = UIColor(red: 0.84, green: 0.25, blue: 0.92, alpha: 1)
            cell.textLabel.textColor = UIColor.whiteColor()
            cell.textLabel.textAlignment = NSTextAlignment.Center
            cell.textField.hidden = true
        }
        
        return cell
    }
    
    func signUp(username:NSString, password:NSString) -> (){
        var userObject = PFUser()
        userObject.username = username
        userObject.email = username
        userObject.password = password
        userObject["sublistArray"] = NSMutableArray()
        userObject["favoritesArray"] = NSMutableArray()
        userObject.signUpInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            if !error {
                NSLog("Signed up user <%@>", userObject.username)
            } else {
                let errorString = error.userInfo["error"] as NSString
                var alertView = UIAlertController(title: "An Error Occured", message: errorString, preferredStyle: UIAlertControllerStyle.Alert)
                self.presentViewController(alertView, animated: true, completion: nil)
            }
        }
    }

}