//
//  SlideNStuff.h
//  Moves
//
//  Created by Eric Seo on 4/25/15.
//  Copyright (c) 2015 SeoEricc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <CoreData/CoreData.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "NavigationViewController.h"




@interface SlideNStuff : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIVideoEditorControllerDelegate>
{
    IBOutlet UINavigationItem *Navigation;
    IBOutlet UITextField *TitleLabel;
    IBOutlet UIView *AddView;
    
    IBOutlet UIButton *PhotoButton;
    
    UIImagePickerController *Imagepicker;
    UIImage *image;
    UIVideoEditorController *Videopicker;
    
    
}




- (IBAction)GotoPhoto;
- (IBAction)GotoVideo;
- (IBAction)TakeFromLibrary:(id)sender;
- (IBAction)Title:(id)sender;
- (IBAction)AddStuff:(id)sender;
- (IBAction)Cancel:(id)sender;
- (IBAction)EditChanged;





@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButton;

@end
