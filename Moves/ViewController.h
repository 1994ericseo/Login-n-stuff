//
//  ViewController.h
//  Moves
//
//  Created by Eric Seo on 4/18/15.
//  Copyright (c) 2015 SeoEricc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>



@interface ViewController : UIViewController
{
    IBOutlet UITextField *UserField;
    IBOutlet UITextField *PasswordField;
    IBOutlet UIButton *SignInButton;
    IBOutlet UIActivityIndicatorView *ActivityIndicator;
    IBOutlet UIButton *ForgotPassword;
    IBOutlet UIButton *CreateSignButton;
    
    NSDictionary *LoginDictionary;
}

- (IBAction)LoginButton;
- (IBAction)FinishedUsername:(id)sender;
- (IBAction)FinishedPassword:(id)sender;
- (IBAction)CreateOrSign:(id)sender;





@end

