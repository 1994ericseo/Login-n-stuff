//
//  SlideNStuff.h
//  Moves
//
//  Created by Eric Seo on 4/25/15.
//  Copyright (c) 2015 SeoEricc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideNStuff : UIViewController
{
    
    IBOutlet UINavigationItem *Navigation;
    IBOutlet UITextField *TitleLabel;
    IBOutlet UIView *AddView;
}

- (IBAction)Title:(id)sender;
- (IBAction)AddStuff:(id)sender;
- (IBAction)Cancel:(id)sender;





@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButton;

@end
