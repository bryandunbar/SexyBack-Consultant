//
//  SBCAppDelegate.m
//  SexyBack Consultant
//
//  Created by Bryan Dunbar on 9/14/14.
//  Copyright (c) 2014 Knight, Norvell and Pater, LLC. All rights reserved.
//

#import "SBCAppDelegate.h"
#import <Parse/Parse.h>
@implementation SBCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // Connect to Parse
    [Parse setApplicationId:@"GmQSc8VAYnlIGSPFp3JEr8Y8diHkmyIT7El8Kk6K"
                  clientKey:@"50MSq0xuEeO1AtZLeyt4ZqfFyZ6h2AXxCsldVTtg"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];

    
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
        UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
        splitViewController.delegate = (id)navigationController.topViewController;
    }
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIViewController *controller = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        controller.modalPresentationStyle = UIModalPresentationFormSheet;
        [self.window.rootViewController presentViewController:controller animated:YES completion:^{
            
        }];
        
    });
    
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
