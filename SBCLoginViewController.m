//
//  SBCLoginViewController.m
//  SexyBack Consultant
//
//  Created by Bryan Dunbar on 9/14/14.
//  Copyright (c) 2014 Knight, Norvell and Pater, LLC. All rights reserved.
//

#import "SBCLoginViewController.h"
#import <Parse/Parse.h>
#import "Constants.h"
#import "NSObject+AlertHelper.h"

@interface SBCLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *consultantId;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation SBCLoginViewController


- (IBAction)loginTapped:(id)sender {
    
    self.loginButton.hidden = YES;
    [self.activityIndicator startAnimating];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Consultant"];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    [query whereKey:@"username" equalTo:self.consultantId.text];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [self.activityIndicator stopAnimating];
        
        if (error || objects.count == 0) {
            [self showAlert:@"Oops!" detailMessage:@"That's not a valid consultant id."];
            self.loginButton.hidden = NO;
        } else {
            APP.consultant = objects[0];
            
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setValue:self.consultantId.text forKey:@"consultantid"];
            [defaults synchronize];
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.consultantId.text = [defaults valueForKey:@"consultantid"];
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
