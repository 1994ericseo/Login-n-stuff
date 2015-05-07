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
#import "NoteView.h"




@interface SlideNStuff : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIVideoEditorControllerDelegate, UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UINavigationItem *Navigation;
    IBOutlet UITextField *TitleLabel;
    
    UIImagePickerController *Imagepicker;
    UIImage *image;
    UIVideoEditorController *Videopicker;
    
    
}
@property (strong, nonatomic) IBOutlet UITableView *TableView;
@property (strong, nonatomic) NSMutableArray *movesArray;
- (IBAction)Title:(id)sender;
- (IBAction)EditChanged;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButton;




@end
