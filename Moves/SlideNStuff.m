//
//  SlideNStuff.m
//  Moves
//
//  Created by Eric Seo on 4/25/15.
//  Copyright (c) 2015 SeoEricc. All rights reserved.
//

#import "SlideNStuff.h"
#import "SWRevealViewController.h"

@interface SlideNStuff ()
@end

@implementation SlideNStuff
@synthesize TableView;
@synthesize movesArray;
@synthesize barButton;



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
    
    self.revealViewController.panGestureRecognizer.enabled = NO;
    
    
    
    
    
    [self LoadTitle];
    barButton.target = self.revealViewController;
    barButton.action = @selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    //dismiss keyboard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    AddView.alpha = 0;
    AddView.hidden = YES;
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"UpdateMove"]) { //set the transition identifier to UpdateCar
        NSManagedObject *selectedMove = [movesArray objectAtIndex:[[self.TableView indexPathForSelectedRow] row]];
        NoteView *destViewController = segue.destinationViewController;
        destViewController.move = selectedMove;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self initialView];
    
    //here we get the moves from the persistent data source (or the database)
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Moves"];
    movesArray = [[moc executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.TableView reloadData];
    
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



#pragma Go to Photo
- (IBAction)GotoPhoto {
    Imagepicker = [[UIImagePickerController alloc] init];
    Imagepicker.delegate = self;
    Imagepicker.allowsEditing = YES;
    [Imagepicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:Imagepicker animated:YES completion:NULL];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    //SAVE THE PHOTO
    /*NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
     [defaults setObject:image forKey:@"savedpicture"];
     [defaults synchronize]; */
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:NULL];
}


#pragma Go to Video
- (IBAction)GotoVideo {
    [self startCameraControllerFromViewController:self usingDelegate:self];
    //[self presentViewController:Videopicker animated:YES completion:NULL];
}


-(BOOL)startCameraControllerFromViewController:(UIViewController*)controller
                                 usingDelegate:(id )delegate {
    // 1 - Validattions
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil)) {
        return NO;
    }
    // 2 - Get image picker
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    // Displays a control that allows the user to choose movie capture
    cameraUI.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    //cameraUI.allowsEditing = NO;
    cameraUI.allowsEditing = YES;
    cameraUI.delegate = delegate;
    
    // 3 - Display image picker
    [controller presentModalViewController: cameraUI animated: YES];
    return YES;
}

-(void)video:(NSString*)videoPath didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo {
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Video Saving Failed"
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Video Saved" message:@"Saved To Photo Album"
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma From Library
- (IBAction)TakeFromLibrary:(id)sender {
    Imagepicker = [[UIImagePickerController alloc] init];
    Imagepicker.delegate = self;
    Imagepicker.allowsEditing = YES;
    Imagepicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    Imagepicker.mediaTypes =[UIImagePickerController availableMediaTypesForSourceType:Imagepicker.sourceType];
    [self presentViewController:Imagepicker animated:YES completion:NULL];
}



#pragma Title
- (IBAction)Title:(id)sender {
    [self resignFirstResponder];
}

- (IBAction)AddStuff:(id)sender {
    AddView.hidden = NO;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [AddView setAlpha:1.0];
    //[self.view setAlpha:0.8f];
    [UIView commitAnimations];
    //make all buttons Disabled plz
    Navigation.leftBarButtonItem.enabled = NO;
    Navigation.rightBarButtonItem.enabled = NO;
    TitleLabel.userInteractionEnabled = NO;
    TitleLabel.alpha = 0.2f;
    TableView.userInteractionEnabled = NO;
    TableView.alpha = 0.2f;
    [self.view bringSubviewToFront:AddView];
    
    //actual process
}

- (void)initialView {
    [AddView setAlpha:0];
    [self.view setAlpha:1];
    //[AddView setHidden:YES];
    self.view.userInteractionEnabled = YES;
    Navigation.leftBarButtonItem.enabled = YES;
    Navigation.rightBarButtonItem.enabled = YES;
    TitleLabel.userInteractionEnabled = YES;
    TitleLabel.alpha = 1;
    TableView.userInteractionEnabled = YES;
    TableView.alpha = 1;

}

- (IBAction)Cancel:(id)sender {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [AddView setAlpha:0];
    [self.view setAlpha:1];
    //[AddView setHidden:YES];
    self.view.userInteractionEnabled = YES;
    Navigation.leftBarButtonItem.enabled = YES;
    Navigation.rightBarButtonItem.enabled = YES;
    TitleLabel.userInteractionEnabled = YES;
    TitleLabel.alpha = 1;
    TableView.userInteractionEnabled = YES;
    TableView.alpha = 1;
    
    [UIView commitAnimations];
}

- (IBAction)EditChanged {
    NSString *savestring = TitleLabel.text;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:savestring forKey:@"savedstring"];
    [defaults synchronize];
    
    /*UITableView* table = [defaults objectForKey:@"theTable"];
     NSIndexPath *firstRow = [NSIndexPath indexPathForRow:0 inSection:0];
     UITableViewCell *cell = [table cellForRowAtIndexPath:firstRow];
     cell.textLabel.text = savestring; */
    
    
}

- (void)LoadTitle {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *loadstring = [defaults objectForKey:@"savedstring"];
    [TitleLabel setText:loadstring];
}

-(void)dismissKeyboard {
    [TitleLabel resignFirstResponder];
}





#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return movesArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //configure the cell
    NSManagedObject *move = [movesArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@", [move valueForKey:@"title"]]];
    [cell.detailTextLabel setText:[move valueForKey:@"date"]];
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //delete the object from database
        [context deleteObject:[movesArray objectAtIndex:indexPath.row]];
        
        //invoke the "save" method to commit change
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        //remove car from table view
        [movesArray removeObjectAtIndex:indexPath.row];
        [self.TableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */






@end
