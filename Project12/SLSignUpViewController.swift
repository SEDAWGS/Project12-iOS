//
//  SLSignUpView.swift
//  Project12
//
//  Created by Hicham Abou Jaoude on 2014-07-19.
//  Copyright (c) 2014 Hicham Abou Jaoude. All rights reserved.
//

import Foundation

class SLSignUpViewController: UITableViewController, UITextFieldDelegate  {
    
    var username = ""
    var password = ""
    var email = ""
    var fullname = ""
    
    enum SLSignUpSection: Int {
        case name
        case email
        case password
        case signUp
        case count
        case username
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sign Up"
        self.tableView.registerClass(SLTextFieldCell.classForCoder(), forCellReuseIdentifier: "Cell")
        self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.Interactive
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
        
        cell.textField.tag = indexPath!.section
        cell.textField.delegate = self
        
        if indexPath?.section == SLSignUpSection.username.toRaw(){
            cell.textField.placeholder = "Username"
        } else if indexPath?.section == SLSignUpSection.name.toRaw(){
            cell.textField.placeholder = "Full Name"
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
    
    func verifyInfo () -> (Bool){
        if email.utf16count == 0 || fullname.utf16count == 0 || password.utf16count == 0 {
            return false
        }
        return true
    }
    
    func signUp() -> (){
        if !verifyInfo() {
            let alert = UIAlertView()
            alert.title = "An Error Occured"
            alert.message = "Please verify you have filled all required fields"
            alert.addButtonWithTitle("OK")
            alert.show()
            return
        }
        var userObject = PFUser()
        userObject.username = email
        userObject.email = email
        userObject.password = password
        userObject["fullname"] = fullname
        userObject["sublistArray"] = NSMutableArray()
        userObject["favoritesArray"] = NSMutableArray()
        userObject.signUpInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            if !error {
                println("Signed up user <%@>" +  userObject.username)
            } else {
                let errorString = error.userInfo["error"] as NSString
                var alertView = UIAlertView()
                let alert = UIAlertView()
                alert.title = "An Error Occured"
                alert.message = errorString
                alert.addButtonWithTitle("OK")
                alert.show()
            }
        }
    }
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        signUp()
    }
    
    func textField(textField: UITextField!, shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool {
        var text = textField.text + string
        switch textField.tag {
            case SLSignUpSection.username.toRaw():
                username = text
            case SLSignUpSection.name.toRaw():
                fullname = text
            case SLSignUpSection.password.toRaw():
                password = text
            case SLSignUpSection.email.toRaw():
                email = text
            default:
                break
        }
        return true
    }

}
