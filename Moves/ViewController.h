//
//  ViewController.h
//  Moves
//
//  Created by Eric Seo on 4/18/15.
//  Copyright (c) 2015 SeoEricc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "MainScreen.h"


@interface ViewController : UIViewController
{
    IBOutlet UITextField *UserField;
    IBOutlet UITextField *PasswordField;
    IBOutlet UIButton *SignInButton;
    IBOutlet UIActivityIndicatorView *ActivityIndicator;
    
    NSDictionary *LoginDictionary;
}

- (IBAction)LoginButton;
- (IBAction)Username:(id)sender;
- (IBAction)Password:(id)sender;
- (IBAction)FinishedUsername:(id)sender;
- (IBAction)FinishedPassword:(id)sender;




@end

