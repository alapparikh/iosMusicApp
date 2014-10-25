//
//  MovieViewController.m
//  MasterMusic
//
//  Created by Alap Parikh on 10/10/14.
//  Copyright (c) 2014 Alap Parikh. All rights reserved.
//

#import "MovieViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface MovieViewController ()
@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImageView *CurrentImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Music_Monitor.jpg"]];
    CurrentImage.frame = self.view.bounds;
    [[self view] addSubview:CurrentImage];
    [CurrentImage.superview sendSubviewToBack:CurrentImage];
}

- (IBAction)playButtonPressed:(id)sender {
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"appDemo" ofType:@"mov"]];
    self.moviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:url];
    
    [self.view addSubview:self.moviePlayer.view];
    self.moviePlayer.fullscreen = YES;
    self.moviePlayer.shouldAutoplay = YES;
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
