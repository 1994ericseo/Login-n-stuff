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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)CreateNewLog {
}

- (IBAction)LogOut {
    [self dismissViewControllerAnimated:YES completion:NULL];
    [PFUser logOut];
}
@end
