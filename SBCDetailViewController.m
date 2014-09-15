//
//  SBCDetailViewController.m
//  SexyBack Consultant
//
//  Created by Bryan Dunbar on 9/14/14.
//  Copyright (c) 2014 Knight, Norvell and Pater, LLC. All rights reserved.
//

#import "SBCDetailViewController.h"
#import "SBCNotifyViewController.h"
#import <Parse/Parse.h>
@interface SBCDetailViewController () {
    NSMutableArray *_objects;
}

@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (strong, nonatomic) UIButton *tappedNotifyButton;
- (void)configureView;
@end

@implementation SBCDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    [self fetchData];
}

-(void)fetchData {
    
    PFQuery *query = [PFQuery queryWithClassName:@"UserProfile"];
    [query whereKey:@"party" equalTo:self.detailItem];
    [query orderByAscending:@"name"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        _objects = [NSMutableArray arrayWithArray:objects];
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Party";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(notifyParty:)];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(fetchData) forControlEvents:UIControlEventValueChanged];

	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tappedNotifyButton = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userCell" forIndexPath:indexPath];
    
    PFObject *object = _objects[indexPath.row];
    
    UILabel *nameLabel = (UILabel*)[cell viewWithTag:1000];
    UILabel *freqGoalLabel = (UILabel*)[cell viewWithTag:2000];
    UILabel *qualGoalLabel = (UILabel*)[cell viewWithTag:3000];
    UILabel *pointsLabel = (UILabel*)[cell viewWithTag:4000];
    
    nameLabel.text = object[@"name"];
    freqGoalLabel.text = object[@"sexFrequencyGoal"];
    qualGoalLabel.text = object[@"sexQualityGoal"];
    pointsLabel.text = [NSString stringWithFormat:@"%d", [object[@"rewardsPoints"] intValue]];
    return cell;
}


-(void)notifyParty:(id)sender {
    self.tappedNotifyButton = nil;
    [self performSegueWithIdentifier:@"notifySegue" sender:sender];
}
- (IBAction)notifyTapped:(id)sender {
    
    UIButton *button = (UIButton*)sender;
    self.tappedNotifyButton = button;
    [self performSegueWithIdentifier:@"notifySegue" sender:sender];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"notifySegue"]) {
        
        SBCNotifyViewController *notifyVC = (SBCNotifyViewController*)segue.destinationViewController;
        
        // Notifying a person
        if (self.tappedNotifyButton) {
            CGPoint convertedPoint = [self.tappedNotifyButton.superview convertPoint:self.tappedNotifyButton.center toView:self.tableView];
            NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:convertedPoint];
            PFObject *object = _objects[indexPath.row];
            notifyVC.recepient = object;
        } else {
            //Notifying the whole party
            notifyVC.recepient = self.detailItem;
        }
        

        
    }
    
}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        
//        PFObject *object = _objects[indexPath.row];
//        [_objects removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        
//        [object deleteInBackground];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//    }
//}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Parties", @"Parties");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
