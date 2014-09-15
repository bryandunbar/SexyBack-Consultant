//
//  SBCMasterViewController.h
//  SexyBack Consultant
//
//  Created by Bryan Dunbar on 9/14/14.
//  Copyright (c) 2014 Knight, Norvell and Pater, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@class SBCDetailViewController;

@interface SBCMasterViewController : UITableViewController

@property (strong, nonatomic) SBCDetailViewController *detailViewController;

@end
