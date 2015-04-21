//
//  ViewController.m
//  Moves
//
//  Created by Eric Seo on 4/18/15.
//  Copyright (c) 2015 SeoEricc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Code to dismiss Keyboard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    SignInButton.enabled = NO;
    ActivityIndicator.hidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)LoginButton:(id)sender {
    [self activateIndicator];
    [PFUser logInWithUsernameInBackground:UserField.text password:PasswordField.text
        block:^(PFUser *user, NSError *error) {
        if (user) {
            [self deactivateIndicator];
            SuccessViewController *success = [self.storyboard instantiateViewControllerWithIdentifier:@"Success"];
                        [self presentViewController:success animated:YES completion:nil];
        } else {
            [self deactivateIndicator];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sign in failed" message:@"Incorrect Username or Password" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
            [alert show];
        }
    }];
}

- (IBAction)Username:(id)sender {
    if ((![UserField.text isEqualToString:@""]) &
        (![PasswordField.text isEqualToString:@""])) {
        SignInButton.enabled = YES;
    }
    else {
        SignInButton.enabled = NO;
    }
}

- (IBAction)Password:(id)sender {
    if ((![UserField.text isEqualToString:@""]) &
        (![PasswordField.text isEqualToString:@""])) {
        SignInButton.enabled = YES;
    }
    else {
        SignInButton.enabled = NO;
    }
}

-(void)dismissKeyboard {
    [UserField resignFirstResponder];
    [PasswordField resignFirstResponder];
}

-(void)activateIndicator {
    ActivityIndicator.hidden = NO;
    [ActivityIndicator startAnimating];
}

-(void)deactivateIndicator {
    ActivityIndicator.hidden = YES;
    [ActivityIndicator stopAnimating];
}


@end
