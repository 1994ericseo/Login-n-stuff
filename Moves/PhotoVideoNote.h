//
//  PhotoVideoNote.h
//  Moves
//
//  Created by Eric Seo on 4/24/15.
//  Copyright (c) 2015 SeoEricc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface PhotoVideoNote : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIVideoEditorControllerDelegate> {
    
    UIImagePickerController *Imagepicker;
    UIImage *image;
    UIVideoEditorController *Videopicker;
    IBOutlet UIImageView *ImageView;
}


- (IBAction)GotoPhoto;
- (IBAction)GotoVideo;
- (IBAction)TakeFromLibrary:(id)sender;
- (IBAction)BackButton;

-(BOOL)startCameraControllerFromViewController:(UIViewController*)controller
                                 usingDelegate:(id )delegate;
-(void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void*)contextInfo;




@end
