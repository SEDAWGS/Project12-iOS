//
//  SLSignUpView.swift
//  Project12
//
//  Created by Hicham Abou Jaoude on 2014-07-19.
//  Copyright (c) 2014 Hicham Abou Jaoude. All rights reserved.
//

import Foundation

protocol SLSignUpViewControllerDelegate {
    func signUpViewControllerDidCancelSignUp(signUpViewController: SLSignUpViewController)
}

class SLSignUpViewController: UITableViewController, UITextFieldDelegate  {
    
    var delegate: SLSignUpViewControllerDelegate?
    
    var username = ""
    var password = ""
    var confirmPassword = ""
    var email = ""
    var fullname = ""
    
    enum SLSignUpSection: Int {
        case name = 0
        case email
        case password
        case signUp
        case count
        case username
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sign Up"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: Selector("signUpCancelled"))
        
        self.tableView.registerClass(SLTextFieldCell.classForCoder(), forCellReuseIdentifier: "Cell")
        self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.Interactive
    }
    
    func signUpCancelled() {
        delegate?.signUpViewControllerDidCancelSignUp(self)
    }
    
    // #pragma mark - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return SLSignUpSection.count.toRaw()
    }
    
    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        if section == SLSignUpSection.password.toRaw() {
            return 2
        }
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
            if indexPath?.row == 0{
                cell.textField.placeholder = "Password"
            } else {
                cell.textField.placeholder = "Confirm Password"
                 cell.textField.tag = -1
            }
        } else if indexPath?.section == SLSignUpSection.email.toRaw(){
            cell.textField.placeholder = "Email Address"
        } else if indexPath?.section == SLSignUpSection.signUp.toRaw(){
            cell.textLabel.text = "Sign Up"
            cell.contentView.backgroundColor =  UIColor(red: 0.12, green: 0.57, blue: 1, alpha: 1)
            cell.textLabel.backgroundColor = UIColor(red: 0.12, green: 0.57, blue: 1, alpha: 1)
            cell.textLabel.textColor = UIColor.whiteColor()
            cell.textLabel.textAlignment = NSTextAlignment.Center
            cell.textField.hidden = true
        }
        
        return cell
    }
    
    func verifyInfo () -> (Bool){
        if email.utf16count == 0 || fullname.utf16count == 0 || password.utf16count == 0 || confirmPassword.utf16count == 0 || (password != confirmPassword) {
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
            case -1:
                confirmPassword = text
            default:
                break
        }
        return true
    }

}
