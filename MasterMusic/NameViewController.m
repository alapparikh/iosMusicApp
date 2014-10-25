//
//  NameViewController.m
//  MasterMusic
//
//  Created by Alap Parikh on 10/10/14.
//  Copyright (c) 2014 Alap Parikh. All rights reserved.
//

#import "NameViewController.h"
#import "MainViewController.h"

@interface NameViewController ()
@property (strong, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (strong, nonatomic) IBOutlet UILabel *timeSpentLabel;
@property (strong, nonatomic) IBOutlet UILabel *DJLabel;
@property (strong, nonatomic) MainViewController *mainViewController;

@end

@implementation NameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                   style:UIBarButtonItemStyleDone target:self
                                                                  action:@selector(dismiss)];
    
    UIImageView *CurrentImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Music_Monitor.jpg"]];
    CurrentImage.frame = self.view.bounds;
    [[self view] addSubview:CurrentImage];
    [CurrentImage.superview sendSubviewToBack:CurrentImage];
    
    UIColor *navigationColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    [self.navigationController.navigationBar setTintColor:navigationColor];
    //self.navigationController.navigationBar.tintColor = navigationColor;
    
    self.navigationItem.rightBarButtonItem = doneButton;
    doneButton.tintColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    
    self.timeSpentLabel.text = [NSString stringWithFormat:@"You have been addicted for %@ seconds", self.userDetails[1]];
    self.timeSpentLabel.textAlignment = NSTextAlignmentCenter;
    self.DJLabel.text = [NSString stringWithFormat:@"Welcome, DJ %@", self.userDetails[0]];
    self.DJLabel.textAlignment = NSTextAlignmentCenter;
    
    //NSLog(@"%@", myArray[0]);
}
- (IBAction)startButtonPressed:(id)sender {
    
    self.mainViewController = [[MainViewController alloc]init];
    self.mainViewController.userDetails = self.userDetails;
    [self.navigationController pushViewController:self.mainViewController animated:YES];
}

- (void) dismiss {
    [self dismissViewControllerAnimated:YES completion:^{
        // NSLog(@"Aaaaaaand...it's gone.");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
