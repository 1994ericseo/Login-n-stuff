//
//  SignUpViewController.m
//  Moves
//
//  Created by Eric Seo on 4/20/15.
//  Copyright (c) 2015 SeoEricc. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    ActivityIndicator.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)CreateAccount {
    if ([NewUserName.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Username Field Blank" message:@"Please Enter a Username" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
    }
    else if ([NewPassword.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password Field Blank" message:@"Please Enter a Password" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
    }
    else if ([EmailAddress.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email Field Blank" message:@"Please Enter an Email Address" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
    }
    else if (![NewPassword.text isEqualToString:ReEnterPassword.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Passwords don't match" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
    }
    else if (![EmailAddress.text isEqualToString:ReEnterEmail.text]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Email addresses don't match" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
    }
    else if ([NewUserName.text isEqualToString:NewPassword.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Username and Password cannot be the same" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
    }
    else {
        [self activateIndicator];
        [self SignUpProcess:NewUserName.text :NewPassword.text :EmailAddress.text];
    }
}


//HELPER FUNCTIONS
- (void)SignUpProcess: (NSString*)username : (NSString*)password :(NSString*)email {
    PFUser *user = [PFUser user];
    user.username = username;
    user.password = password;
    user.email = email;
    
    // other fields can be set just like with PFObject
    //user[@"phone"] = @"415-392-0202";
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
            [self deactivateIndicator];
            SuccessViewController *success = [self.storyboard instantiateViewControllerWithIdentifier:@"Success"];
            [self presentViewController:success animated:YES completion:nil];
        } else {
            [self deactivateIndicator];
            NSString *errorString = [error userInfo][@"error"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
            [alert show];
        }
    }];
}

-(void)dismissKeyboard {
    [NewUserName resignFirstResponder];
    [NewPassword resignFirstResponder];
    [ReEnterPassword resignFirstResponder];
    [EmailAddress resignFirstResponder];
    [ReEnterEmail resignFirstResponder];
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
