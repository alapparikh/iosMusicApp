//
//  ViewController.m
//  MasterMusic
//
//  Created by Alap Parikh on 10/10/14.
//  Copyright (c) 2014 Alap Parikh. All rights reserved.
//

#import "ViewController.h"
#import "NameViewController.h"

@interface ViewController ()
@property (strong, nonatomic) NSMutableDictionary *appData;
@property (strong, nonatomic) IBOutlet UITextField *stageName;
@property (strong, nonatomic) NSDictionary *dictionary;
@property (strong, nonatomic) NameViewController *nameViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *CurrentImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Music_Monitor.jpg"]];
    CurrentImage.frame = self.view.bounds;
    [[self view] addSubview:CurrentImage];
    [CurrentImage.superview sendSubviewToBack:CurrentImage];
    
    [super viewDidLoad];
    
    self.appData = [[NSUserDefaults standardUserDefaults] objectForKey:@"appData"];
    
    if (self.appData == nil){
        self.appData = [[NSMutableDictionary alloc]init];
    }
}

- (IBAction)nameButtonPressed:(id)sender {
    
    if ([self.stageName.text length] == 0){
        NSLog(@"Enter name");
    }
    else {
        
        NSArray *myArray = [self.appData objectForKey:self.stageName.text];
        //NSLog(@"Array: %@", myArray);
        
        if (myArray == nil){
            NSString *myString = @"0";
            myArray = @[self.stageName.text, myString];
            [self.appData setObject:myArray forKey:self.stageName.text];
            
            [[NSUserDefaults standardUserDefaults] setObject:self.appData forKey:@"appData"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        //NSLog(@"%@", myArray[1]);
        
        self.nameViewController = [[NameViewController alloc]init];
        
        self.nameViewController.userDetails = [myArray mutableCopy];
    
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.nameViewController];
        [self presentViewController:navController animated:YES completion:^{
            //  NSLog(@"the thing finished presenting");
        }];
    }
    
    //[self presentViewController:nameViewController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
