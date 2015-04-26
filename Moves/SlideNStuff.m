//
//  SlideNStuff.m
//  Moves
//
//  Created by Eric Seo on 4/25/15.
//  Copyright (c) 2015 SeoEricc. All rights reserved.
//

#import "SlideNStuff.h"
#import "SWRevealViewController.h"

@interface SlideNStuff ()

@end

@implementation SlideNStuff

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self LoadTitle];
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
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

- (IBAction)Title:(id)sender {
    NSString *savestring = TitleLabel.text;
    [self resignFirstResponder];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:savestring forKey:@"savedstring"];
    [defaults synchronize];
}

- (void)LoadTitle {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *loadstring = [defaults objectForKey:@"savedstring"];
    [TitleLabel setText:loadstring];
}
@end
