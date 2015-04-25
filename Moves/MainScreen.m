//
//  MainScreen.m
//  Moves
//
//  Created by Eric Seo on 4/22/15.
//  Copyright (c) 2015 SeoEricc. All rights reserved.
//

#import "MainScreen.h"

@interface MainScreen ()

@end

@implementation MainScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self LoadTitle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)CreateNewLog {
}

- (IBAction)LogOut {
    //[self dismissViewControllerAnimated:YES completion:NULL];
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"is_loggedon"];
    
    [PFUser logOut];
}

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
