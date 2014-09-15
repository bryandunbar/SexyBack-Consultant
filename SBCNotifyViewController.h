//
//  SBCNotifyViewController.h
//  SexyBack Consultant
//
//  Created by Bryan Dunbar on 9/15/14.
//  Copyright (c) 2014 Knight, Norvell and Pater, LLC. All rights reserved.
//

#import "UIFormTableViewController.h"
#import <Parse/Parse.h>

@interface SBCNotifyViewController : UIFormTableViewController

@property (nonatomic,strong) PFObject *recepient;


@end
