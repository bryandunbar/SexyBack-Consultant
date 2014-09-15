//
//  SBCAppDelegate.h
//  SexyBack Consultant
//
//  Created by Bryan Dunbar on 9/14/14.
//  Copyright (c) 2014 Knight, Norvell and Pater, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface SBCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) PFObject *consultant;
@end
