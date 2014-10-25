//
//  MainViewController.m
//  MasterMusic
//
//  Created by Alap Parikh on 10/10/14.
//  Copyright (c) 2014 Alap Parikh. All rights reserved.
//

#import "MainViewController.h"
#import "NameViewController.h"
#import "MovieViewController.h"
#import "TableViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface MainViewController ()
@property (strong, nonatomic) IBOutlet UIButton *loop1Button;
@property (strong, nonatomic) IBOutlet UIButton *loop2Button;
@property (strong, nonatomic) IBOutlet UIButton *loop3Button;
@property (strong, nonatomic) IBOutlet UIButton *loop4Button;
@property (strong, nonatomic) IBOutlet UIButton *loop5Button;

@property (strong, nonatomic) IBOutlet UIImageView *Bar1;
@property (strong, nonatomic) IBOutlet UIImageView *Bar2;
@property (strong, nonatomic) IBOutlet UIImageView *Bar3;
@property (strong, nonatomic) IBOutlet UIImageView *Bar4;

@property (strong, nonatomic) UIImage *barImage1;
@property (strong, nonatomic) UIImage *barImage2;
@property (strong, nonatomic) UIImage *barImage3;
@property (strong, nonatomic) UIImage *barImage4;
@property (strong, nonatomic) UIImage *barImage5;

@property (strong, nonatomic) AVAudioPlayer *audioPlayer1;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer2;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer3;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer4;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer5;

@property (strong, nonatomic) IBOutlet UILabel *DJLabel;
@property int numberOfInstruments;
@property int addictionTime;
@property int timeForCurrentLoop;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSMutableArray *imagesArray;
@property NSUInteger count;

@property (strong, nonatomic) NSArray *currentUserDetails;

@property (strong, nonatomic) TableViewController *tableViewController;
@property (strong, nonatomic) NSMutableDictionary *appData;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Music Room";
    
    self.numberOfInstruments = 0;
    self.timeForCurrentLoop = 0;
    self.addictionTime = [self.userDetails[1] intValue];
    self.imagesArray = [[NSMutableArray alloc]init];
    self.appData = [[NSUserDefaults standardUserDefaults] objectForKey:@"appData"];
    
    UIImageView *CurrentImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Music_Monitor.jpg"]];
    CurrentImage.frame = self.view.bounds;
    [[self view] addSubview:CurrentImage];
    [CurrentImage.superview sendSubviewToBack:CurrentImage];
    
    //NSLog(@"%@", self.userDetails[0]);
    // Set up all audio players
    
    NSURL *file1 = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"bass1" ofType:@"m4a"]];
    self.audioPlayer1 = [[AVAudioPlayer alloc] initWithContentsOfURL:file1 error:nil];
    self.audioPlayer1.numberOfLoops = -1; // Infinite loops
    [self.audioPlayer1 setVolume:1.0];
    [self.audioPlayer1 prepareToPlay];
    
    NSURL *file2 = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"electron_echoes1" ofType:@"m4a"]];
    self.audioPlayer2 = [[AVAudioPlayer alloc] initWithContentsOfURL:file2 error:nil];
    self.audioPlayer2.numberOfLoops = -1; // Infinite loops
    [self.audioPlayer2 setVolume:1.0];
    [self.audioPlayer2 prepareToPlay];
    
    NSURL *file3 = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"drumkit1" ofType:@"m4a"]];
    self.audioPlayer3 = [[AVAudioPlayer alloc] initWithContentsOfURL:file3 error:nil];
    self.audioPlayer3.numberOfLoops = -1; // Infinite loops
    [self.audioPlayer3 setVolume:1.0];
    [self.audioPlayer3 prepareToPlay];
    
    NSURL *file4 = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"grand_piano1" ofType:@"m4a"]];
    self.audioPlayer4 = [[AVAudioPlayer alloc] initWithContentsOfURL:file4 error:nil];
    self.audioPlayer4.numberOfLoops = -1; // Infinite loops
    [self.audioPlayer4 setVolume:1.0];
    [self.audioPlayer4 prepareToPlay];
    
    NSURL *file5 = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"french_horn1" ofType:@"m4a"]];
    self.audioPlayer5 = [[AVAudioPlayer alloc] initWithContentsOfURL:file5 error:nil];
    self.audioPlayer5.numberOfLoops = -1; // Infinite loops
    [self.audioPlayer5 setVolume:1.0];
    [self.audioPlayer5 prepareToPlay];
    
    // Button icons (selected and normal)
    
    UIImage *bassGuitarImage = [UIImage imageNamed:@"bass_guitar.png"];
    [self.loop1Button setImage:bassGuitarImage forState:UIControlStateNormal];
    [self.loop1Button setImage:[UIImage imageNamed:@"bass_guitar_highlighted.png"] forState:UIControlStateSelected];
    
    UIImage *xylophoneImage = [UIImage imageNamed:@"xylophone.png"];
    [self.loop2Button setImage:xylophoneImage forState:UIControlStateNormal];
    [self.loop2Button setImage:[UIImage imageNamed:@"xylophone_highlighted.png"] forState:UIControlStateSelected];
    
    UIImage *drumkitImage = [UIImage imageNamed:@"media_drum_kit.png"];
    [self.loop3Button setImage:drumkitImage forState:UIControlStateNormal];
    [self.loop3Button setImage:[UIImage imageNamed:@"drumkit_highlighted.png"] forState:UIControlStateSelected];
    
    UIImage *grandPianoImage = [UIImage imageNamed:@"media_synth.png"];
    [self.loop4Button setImage:grandPianoImage forState:UIControlStateNormal];
    [self.loop4Button setImage:[UIImage imageNamed:@"keyboard_highlighted.png"] forState:UIControlStateSelected];
    
    UIImage *frenchHornImage = [UIImage imageNamed:@"french_horn.png"];
    [self.loop5Button setImage:frenchHornImage forState:UIControlStateNormal];
    [self.loop5Button setImage:[UIImage imageNamed:@"french_horn_highlighted.png"] forState:UIControlStateSelected];
    
    // Images for bar graphics
    self.barImage1 = [UIImage imageNamed:@"barimage1.png"];
    self.barImage2 = [UIImage imageNamed:@"barimage2.png"];
    self.barImage3 = [UIImage imageNamed:@"barimage3.png"];
    self.barImage4 = [UIImage imageNamed:@"barimage4.png"];
    self.barImage5 = [UIImage imageNamed:@"barimage5.png"];
    
}

- (IBAction)loop1ButtonPressed:(id)sender {
    
    if (self.loop1Button.selected == NO) {
        
        self.loop1Button.selected = YES;
        /* self.timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timerDidFire:) userInfo:nil repeats:NO]; */
        [self.audioPlayer1 play];
        [self.imagesArray addObject:self.barImage3];
        [self instrumentAdded];
        
        //NSLog(@"duration is %f",[self.audioPlayer1 duration]);
    }
    else {
        self.loop1Button.selected = NO;
        [self.audioPlayer1 pause];
        self.audioPlayer1.currentTime = 0;
        [self.imagesArray removeObject:self.barImage3];
        [self instrumentRemoved];
    }
}


- (IBAction)loop2ButtonPressed:(id)sender {
    
    if (self.loop2Button.selected == NO) {
        self.loop2Button.selected = YES;
       
        //[self.audioPlayer2 playAtTime:self.audioPlayer2.deviceCurrentTime + self.audioPlayer1.duration - self.audioPlayer1.currentTime];
        [self.audioPlayer2 play];
        [self.imagesArray addObject:self.barImage2];
        [self instrumentAdded];
        
        //NSLog(@"duration is %f",[self.audioPlayer2 duration]);
    }
    else {
        self.loop2Button.selected = NO;
        [self.audioPlayer2 pause];
        self.audioPlayer2.currentTime = 0;
        [self.imagesArray removeObject:self.barImage2];
        [self instrumentRemoved];
    }
}

- (IBAction)loop3ButtonPressed:(id)sender {
    
    if (self.loop3Button.selected == NO) {
        self.loop3Button.selected = YES;
        
        // [self.audioPlayer2 playAtTime:self.audioPlayer2.deviceCurrentTime + self.audioPlayer1.duration - self.audioPlayer1.currentTime];
        [self.audioPlayer3 play];
        [self.imagesArray addObject:self.barImage4];
        [self instrumentAdded];
        
        //NSLog(@"duration is %f",[self.audioPlayer3 duration]);
    }
    else {
        self.loop3Button.selected = NO;
        [self.audioPlayer3 pause];
        self.audioPlayer3.currentTime = 0;
        [self.imagesArray removeObject:self.barImage4];
        [self instrumentRemoved];
    }

}

- (IBAction)loop4ButtonPressed:(id)sender {
    
    if (self.loop4Button.selected == NO) {
        self.loop4Button.selected = YES;
        
        // [self.audioPlayer2 playAtTime:self.audioPlayer2.deviceCurrentTime + self.audioPlayer1.duration - self.audioPlayer1.currentTime];
        [self.audioPlayer4 play];
        [self.imagesArray addObject:self.barImage1];
        [self instrumentAdded];
        
        //NSLog(@"duration is %f",[self.audioPlayer4 duration]);
    }
    else {
        self.loop4Button.selected = NO;
        [self.audioPlayer4 pause];
        self.audioPlayer4.currentTime = 0;
        [self.imagesArray removeObject:self.barImage1];
        [self instrumentRemoved];
    }
}

- (IBAction)loop5ButtonPressed:(id)sender {
    
    if (self.loop5Button.selected == NO) {
        self.loop5Button.selected = YES;
        
        // [self.audioPlayer2 playAtTime:self.audioPlayer2.deviceCurrentTime + self.audioPlayer1.duration - self.audioPlayer1.currentTime];
        [self.audioPlayer5 play];
        [self.imagesArray addObject:self.barImage5];
        [self instrumentAdded];
        //NSLog(@"duration is %f",[self.audioPlayer5 duration]);
    }
    else {
        self.loop5Button.selected = NO;
        [self.audioPlayer5 pause];
        self.audioPlayer5.currentTime = 0;
        [self.imagesArray removeObject:self.barImage5];
        [self instrumentRemoved];
    }
}

-(void) timerDidFire: (NSTimer *) timer {
    
    if (self.timeForCurrentLoop == 0){
        self.count = 1;
    }
    
    self.timeForCurrentLoop += 1;
    //NSLog(@"time: %d",self.timeForCurrentLoop%4);
    switch (self.timeForCurrentLoop%4) {
        case 0:{
            if ((self.count) >= [self.imagesArray count]) self.count = 0;
            self.Bar2.image = nil;
            self.Bar3.image = nil;
            self.Bar4.image = nil;
            [self.Bar1 setImage:[self.imagesArray objectAtIndex:self.count]];
            //NSLog(@"count, image: %f, %@",count,[self.imagesArray objectAtIndex:count]);
            self.count += 1;
            break;
        }
        case 1:{
            if ((self.count) >= [self.imagesArray count]) self.count = 0;
            [self.Bar2 setImage:[self.imagesArray objectAtIndex:self.count]];
            self.count = self.count + 1;
            break;
        }
        case 2:{
            if ((self.count) >= [self.imagesArray count]) self.count = 0;
            [self.Bar3 setImage:[self.imagesArray objectAtIndex:self.count]];
            self.count += 1;
            break;
        }
        case 3:{
            if ((self.count) >= [self.imagesArray count]) self.count = 0;
            [self.Bar4 setImage:[self.imagesArray objectAtIndex:self.count]];
            self.count += 1;
            break;
        }
        default:
            break;
    }
}

- (void) instrumentAdded {
    
    if (self.numberOfInstruments == 0){
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerDidFire:) userInfo:nil repeats:YES];
        
        [self.Bar1 setImage:[self.imagesArray objectAtIndex:0]];
    }
    
    self.numberOfInstruments += 1;
}

- (void) instrumentRemoved {
    self.numberOfInstruments -= 1;
    
    if (self.numberOfInstruments == 0){
        [self.timer invalidate];
        
        self.Bar1.image = nil;
        self.Bar2.image = nil;
        self.Bar3.image = nil;
        self.Bar4.image = nil;
        [self.imagesArray removeAllObjects];
        //self.count = 0;
        
        self.addictionTime = self.addictionTime + self.timeForCurrentLoop;
        
        NSString *time = [NSString stringWithFormat:@"%d",self.addictionTime];
        //NSArray *myArray = @[self.userDetails[0],time];
        
        [self.userDetails insertObject:time atIndex:1];
        
        [self.appData setObject:[self.userDetails copy] forKey:self.userDetails[0]];
        
        [[NSUserDefaults standardUserDefaults] setObject:self.appData forKey:@"appData"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        self.timeForCurrentLoop = 0;
    }
}

- (IBAction)timeSpentButtonPressed:(id)sender {
    
    self.tableViewController = [[TableViewController alloc]initWithStyle:UITableViewStylePlain];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.tableViewController];
    
    [self presentViewController:navController animated:YES completion:^{
       // NSLog(@"the thing finished presenting");
    }];

}

- (IBAction)videoButtonPressed:(id)sender {
    
    MovieViewController *movieViewController = [[MovieViewController alloc]init];
    [self.navigationController pushViewController:movieViewController animated:YES];
}

- (UIBezierPath*)createPath
{
    UIBezierPath* path = [[UIBezierPath alloc]init];
    [path moveToPoint:CGPointMake(100.0, 50.0)];
    [path addLineToPoint:CGPointMake(200.0,50.0)];
    [path addLineToPoint:CGPointMake(200.0, 200.0)];
    [path addLineToPoint:CGPointMake(100.0, 200.0)];
    [path closePath];
    return path;
}

- (UIColor *)randomHSBColor{

    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *randomHSBColor = [[UIColor alloc] initWithHue:hue saturation:saturation brightness:brightness alpha:1.0];
    
    return randomHSBColor;
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
