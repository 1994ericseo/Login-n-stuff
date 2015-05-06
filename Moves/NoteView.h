//
//  NoteView.h
//  Moves
//
//  Created by Eric Seo on 5/4/15.
//  Copyright (c) 2015 SeoEricc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface NoteView : UIViewController


@property (strong, nonatomic) IBOutlet UILabel *Date;
@property (strong, nonatomic) IBOutlet UITextField *Title;
@property (strong, nonatomic) IBOutlet UITextView *Note;
@property (strong, nonatomic) IBOutlet UIImageView *Media;

@property (strong) NSManagedObject *move;
- (IBAction)doneAction:(id)sender;
- (IBAction)cancelAction:(id)sender;

@end
