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
    //Set textfied sizes
    
    //For dismissing keyboard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    ActivityIndicator.hidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)LoginButton {
    if ([UserField.text isEqualToString:@""]) {
        [UserField becomeFirstResponder];
    }
    else if ([PasswordField.text isEqualToString:@""]) {
        [PasswordField becomeFirstResponder];
    }
    else if ([[SignInButton titleLabel].text isEqualToString:@"Sign In"]) {
        [self activateIndicator];
        [PFUser logInWithUsernameInBackground:UserField.text password:PasswordField.text
                                        block:^(PFUser *user, NSError *error) {
                                            if (user) {
                                                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"is_loggedon"];
                                                
                                                [self deactivateIndicator];
                                                MainScreen *mainscreen = [self.storyboard instantiateViewControllerWithIdentifier:@"sw"];
                                                [self presentViewController:mainscreen animated:YES completion:nil];
                                            } else {
                                                [self deactivateIndicator];
                                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sign in failed" message:@"Incorrect Username or Password" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
                                                [alert show];
                                            }
                                        }];
    }
    else {
        [self SignUpProcess:UserField.text :PasswordField.text :UserField.text];
    }
}

- (IBAction)FinishedUsername:(id)sender {
    [self textFieldShouldReturn:UserField];
}

- (IBAction)FinishedPassword:(id)sender {
    if (![UserField.text isEqualToString:@""] & (![PasswordField.text isEqualToString:@""])) {
        [self textFieldShouldReturn:PasswordField];
    }
    else {
        [UserField becomeFirstResponder];
    }
    
}

- (IBAction)CreateOrSign:(id)sender {
    if ([[sender titleLabel].text isEqualToString:@"Or, create an account"]) {
        [self FadeOut:ForgotPassword];
        [CreateSignButton setTitle:@"Or, sign in" forState:UIControlStateNormal];
        [SignInButton setTitle:@"Create Account" forState:UIControlStateNormal];
        UserField.placeholder = @"Email address";
    }
    else {
        [self FadeIn:ForgotPassword];
        [CreateSignButton setTitle:@"Or, create an account" forState:UIControlStateNormal];
        [SignInButton setTitle:@"Sign In" forState:UIControlStateNormal];
        UserField.placeholder = @"Email or username";
    }
    
}


#pragma mark HELPER FUNCTIONS


-(void)SignUpProcess: (NSString*)username : (NSString*)password :(NSString*)email {
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
            MainScreen *mainscreen = [self.storyboard instantiateViewControllerWithIdentifier:@"mainscreen"];
            [self presentViewController:mainscreen animated:YES completion:nil];
        } else {
            [self deactivateIndicator];
            NSString *errorString = [error userInfo][@"error"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
            [alert show];
        }
    }];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == UserField) {
        [textField resignFirstResponder];
        [PasswordField becomeFirstResponder];
    } else if (textField == PasswordField) {
        [self LoginButton];
    }
    return YES;
}

- (void)FadeIn:(UIButton *)button {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [button setAlpha:1.0];
    [UIView commitAnimations];
    
}

- (void)FadeOut:(UIButton *)button {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [button setAlpha:0];
    [UIView commitAnimations];
}



@end
