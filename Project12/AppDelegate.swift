//
//  AppDelegate.swift
//  Project12
//
//  Created by Hicham Abou Jaoude on 2014-07-19.
//  Copyright (c) 2014 Hicham Abou Jaoude. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?
    
    func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
        // Override point for customization after application launch.
        Parse.setApplicationId("LWsbarkfgcHFuK02rv0zQ3IvMfbCaicxnZN6KvnK", clientKey: "I310eHQChI64TbQz9deK1HQsVQ7SpasJpcXGgAAs")
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        application.registerForRemoteNotificationTypes(UIRemoteNotificationType.Badge | UIRemoteNotificationType.Alert | UIRemoteNotificationType.Sound)
        
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        
        var flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 50
        flowLayout.itemSize = CGSizeMake(CGRectGetWidth(UIScreen.mainScreen().bounds) - 40, CGRectGetHeight(UIScreen.mainScreen().bounds) - 64 - 70)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        var viewC = SLSearchFeedViewController(collectionViewLayout: flowLayout)
        var nav = UINavigationController(rootViewController: viewC)
        nav.hidesBottomBarWhenPushed = false
        self.window!.rootViewController = nav
        return true
    }

    func applicationWillResignActive(application: UIApplication!) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication!) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication!) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication!) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication!) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication!, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData!) {
        var currentInstallation = PFInstallation.currentInstallation();
        currentInstallation.setDeviceTokenFromData(deviceToken)
        currentInstallation.saveInBackground()
    }
    
    func application(application: UIApplication!, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]!) {
        PFPush.handlePush(userInfo)
    }


}

