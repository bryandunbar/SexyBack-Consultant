//
//  SBCNotifyViewController.m
//  SexyBack Consultant
//
//  Created by Bryan Dunbar on 9/15/14.
//  Copyright (c) 2014 Knight, Norvell and Pater, LLC. All rights reserved.
//

#import "SBCNotifyViewController.h"
#import <Parse/Parse.h>
@interface SBCNotifyViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation SBCNotifyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)sendTapped:(id)sender {
    // Send a notification to all devices subscribed to the "Giants" channel.
    PFPush *push = [[PFPush alloc] init];
    [push setChannel:self.recepient.objectId];
    [push setMessage:self.textView.text];
    [push sendPushInBackground];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    if ([self.recepient.parseClassName isEqualToString:@"UserProfile"]) {
        self.title = @"Notify User";
    } else {
        self.title = @"Notify Party";
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
