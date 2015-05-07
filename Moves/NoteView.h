//
//  NoteView.h
//  Moves
//
//  Created by Eric Seo on 5/4/15.
//  Copyright (c) 2015 SeoEricc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <CoreData/CoreData.h>
#import "SlideNStuff.h"

@interface NoteView : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    
    IBOutlet UITextView *theNotes;
    IBOutlet UIButton *done;
    IBOutlet UINavigationItem *Navi;
}


@property (strong, nonatomic) IBOutlet UILabel *Date;
@property (strong, nonatomic) IBOutlet UITextField *Title;
@property (strong, nonatomic) IBOutlet UITextView *Note;
@property (strong, nonatomic) IBOutlet UIImageView *Media;
@property (strong, nonatomic) NSString *vid;

@property (strong) NSManagedObject *move;
- (IBAction)doneAction:(id)sender;
- (IBAction)cancelAction:(id)sender;

- (IBAction)finishText:(id)sender;




@property (strong, nonatomic) NSURL *videoURL;
@property (strong, nonatomic) MPMoviePlayerController *videoController;

- (IBAction)captureVideo:(id)sender;

@end
