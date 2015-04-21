//
//  SignUpViewController.h
//  Moves
//
//  Created by Eric Seo on 4/20/15.
//  Copyright (c) 2015 SeoEricc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "SuccessViewController.h"

@interface SignUpViewController : UIViewController {
    
    IBOutlet UITextField *NewUserName;
    IBOutlet UITextField *NewPassword;
    IBOutlet UITextField *ReEnterPassword;
    IBOutlet UITextField *EmailAddress;
    IBOutlet UITextField *ReEnterEmail;
    IBOutlet UIActivityIndicatorView *ActivityIndicator;
    
}

- (IBAction)CreateAccount;


@end
