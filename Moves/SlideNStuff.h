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
    
    IBOutlet UITextField *TitleLabel;
}

- (IBAction)Title:(id)sender;



@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButton;

@end
