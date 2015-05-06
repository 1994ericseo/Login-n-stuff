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
    
    [Note becomeFirstResponder];
    
    
    if (move) {
        [Title setText:[move valueForKey:@"title"]];
        [Date setText:[move valueForKey:@"date"]];
        [Note setText:[move valueForKey:@"note"]];
        //NEED TO CHANGE
        //[Media setImage:[move valueForKey:@"media"]];
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
    }
    
    
    else {
        //create a new move
        NSManagedObject *newMove = [NSEntityDescription insertNewObjectForEntityForName:@"Moves" inManagedObjectContext:context];
        [newMove setValue:Title.text forKey:@"title"];
        [newMove setValue:Date.text forKey:@"date"];
        [newMove setValue:Note.text forKey:@"note"];
        //NEED TO CHANGE
        //[newMove setValue:Media.image forKey:@"media"];
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
@end
