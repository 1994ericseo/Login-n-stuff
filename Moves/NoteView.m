//
//  NoteView.m
//  Moves
//
//  Created by Eric Seo on 5/4/15.
//  Copyright (c) 2015 SeoEricc. All rights reserved.
//

#import "NoteView.h"

@interface NoteView ()

@end

@implementation NoteView
@synthesize Title;
@synthesize Date;
@synthesize Note;
@synthesize Media;
@synthesize vid;

@synthesize move;



//we need this to retreive managed object context and later save the device data
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    NSString *currentTime = [dateFormatter stringFromDate:today];
    Date.text = currentTime;
    
    //[Note becomeFirstResponder];
    //[self textFieldDidBeginEditing:Title];
    
    Note.delegate = self;
    theNotes.delegate = self;
    
    //For dismissing keyboard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];

    
    
    if (move) {
        [Title setText:[move valueForKey:@"title"]];
        [Date setText:[move valueForKey:@"date"]];
        [Note setText:[move valueForKey:@"note"]];
        //NEED TO CHANGE
        //[Media setImage:[move valueForKey:@"media"]];
        vid = [move valueForKey:@"media"];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)doneAction:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (move) {
        //update existing move
        [move setValue:Title.text forKey:@"title"];
        [move setValue:Date.text forKey:@"date"];
        [move setValue:Note.text forKey:@"note"];
        //NEED TO CHANGE
        //[move setValue:Media.image forKey:@"media"];
        [move setValue:vid forKey:@"media"];
    }
    
    
    else {
        //create a new move
        NSManagedObject *newMove = [NSEntityDescription insertNewObjectForEntityForName:@"Moves" inManagedObjectContext:context];
        [newMove setValue:Title.text forKey:@"title"];
        [newMove setValue:Date.text forKey:@"date"];
        [newMove setValue:Note.text forKey:@"note"];
        //NEED TO CHANGE
        //[newMove setValue:Media.image forKey:@"media"];
        [move setValue:vid forKey:@"media"];
    }
    
    
    //TO SAVE DATA
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Save Failed! %@ %@", error, [error localizedDescription]);
    }
    
    
    
    //MAKE SURE TRANSITION IS "PUSH"
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

- (IBAction)cancelAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)textFieldDidBeginEditing:(UITextField *)textField {
    //Keyboard becomes visible
    self.view.frame = CGRectMake(self.view.frame.origin.x,
                                 self.view.frame.origin.y,
                                 self.view.frame.size.width,
                                 self.view.frame.size.height - 215 + 50);   //resize
}


-(void)dismissKeyboard {
    [Title resignFirstResponder];
    [Note resignFirstResponder];
}





-(void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"Enter notes here"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    
    theNotes.hidden = NO;
    [theNotes becomeFirstResponder];
    done.hidden = NO;
    Title.enabled = NO;
    Title.alpha = 0.2f;
    Navi.leftBarButtonItem.enabled = NO;
    Navi.rightBarButtonItem.enabled = NO;
    
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    
}

-(void)textViewDidChange:(UITextView *)textView
{
    Note.text = theNotes.text;
}


- (IBAction)finishText:(id)sender {
    [theNotes resignFirstResponder];
    theNotes.hidden = YES;
    done.hidden = YES;
    Title.enabled = YES;
    Title.alpha = 1;
    Navi.leftBarButtonItem.enabled = YES;
    Navi.rightBarButtonItem.enabled = YES;
}



- (IBAction)captureVideo:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    self.videoURL = info[UIImagePickerControllerMediaURL];
    
    vid = [self.videoURL absoluteString];
    
    //NSURL *url = [NSURL URLWithString:urlAddress];
    
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    self.videoController = [[MPMoviePlayerController alloc] init];
    
    [self.videoController setContentURL:self.videoURL];
    [self.videoController.view setFrame:CGRectMake (0, 0, 320, 460)];
    [self.view addSubview:self.videoController.view];
    
    [self.videoController play];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


@end
