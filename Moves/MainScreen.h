//
//  MainScreen.h
//  Moves
//
//  Created by Eric Seo on 4/22/15.
//  Copyright (c) 2015 SeoEricc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface MainScreen : UIViewController {
    
    IBOutlet UITextField *TitleLabel;
}

- (IBAction)CreateNewLog;
- (IBAction)LogOut;
- (IBAction)Title:(id)sender;


@end
