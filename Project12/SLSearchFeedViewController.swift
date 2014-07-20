//
//  SLSearchFeedViewController.swift
//  Project12
//
//  Created by Hicham Abou Jaoude on 2014-07-20.
//  Copyright (c) 2014 Hicham Abou Jaoude. All rights reserved.
//

class SLSearchFeedViewController: UICollectionViewController, UIScrollViewDelegate, UISearchBarDelegate, SLSignUpViewControllerDelegate, SLSignInViewControllerDelegate {
    
    var lastOffset: CGFloat = 0
    var currentPage: CGFloat = 0
    var label = UILabel()
    
    var textField = UITextField()
    var searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.registerClass(SLSearchFeedCell.classForCoder(), forCellWithReuseIdentifier: "Cell")
        self.collectionView.backgroundColor = UIColor.whiteColor()
        self.collectionView.pagingEnabled = true
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = false
        
        label.font = UIFont(name: "HelveticaNeue-Light", size: 12.0)
        label = UILabel(frame: CGRectMake(0, CGRectGetMaxY(self.view.frame) - 25, CGRectGetWidth(self.view.frame), 15))
        label.textColor = UIColor.blackColor()
        label.textAlignment = NSTextAlignment.Center
        self.navigationController.view.addSubview(label)
        
        searchBar = UISearchBar(frame: CGRectMake(0, 0, 320, 64))
        searchBar.delegate = self
        var searchDisplayController = UISearchDisplayController(searchBar: searchBar, contentsController: self)
        self.navigationItem.titleView = searchBar
        self.navigationController.toolbar.barTintColor = UIColor.redColor()
        
        var buttonArray = NSMutableArray()
        var barButtonLogIn = UIBarButtonItem(title: "Log In", style: UIBarButtonItemStyle.Plain, target: self, action: "logIn")
        var barButtonSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        var barButtonSignUp = UIBarButtonItem(title: "Sign Up", style: UIBarButtonItemStyle.Plain, target: self, action: "signUp")
        buttonArray.addObject(barButtonLogIn)
        buttonArray.addObject(barButtonSpace)
        buttonArray.addObject(barButtonSignUp)
        self.setToolbarItems(buttonArray, animated: false)
        self.navigationController.setToolbarHidden(false, animated: false)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController.setToolbarHidden(false, animated: false)
    }
    
    func logIn() -> () {
        var signIn = SLSignInViewController(style: UITableViewStyle.Grouped)
        signIn.delegate = self
        self.presentViewController(UINavigationController(rootViewController: signIn), animated: true, completion: nil)
    }
    
    func signUp() -> () {
        var signUp = SLSignUpViewController(style: UITableViewStyle.Grouped)
        signUp.delegate = self
        self.presentViewController(UINavigationController(rootViewController: signUp), animated: true, completion: nil)
    }
    
    func signUpViewControllerDidCancelSignUp(signUpViewController: SLSignUpViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signInViewControllerDidCancelSignIn(signInViewController: SLSignInViewController)  {
        self.dismissViewControllerAnimated(true, completion: nil) 
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView!) -> Int {
        return 25
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar!) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar!) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar!)  {
        searchBar.resignFirstResponder()
    }
    
    override func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        return 1;
    }
    
    override func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        var cell: SLSearchFeedCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as SLSearchFeedCell;
        return cell;
    }

}
