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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self LoadTitle];
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    //dismiss keyboard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    AddView.alpha = 0;
    AddView.hidden = YES;
    
    //set navigation color
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
    [Imagepicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:Imagepicker animated:YES completion:NULL];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
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
    cameraUI.allowsEditing = NO;
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
    [Imagepicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
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

    [UIView commitAnimations];
    
    
}

- (IBAction)EditChanged {
    NSString *savestring = TitleLabel.text;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:savestring forKey:@"savedstring"];
    [defaults synchronize];
}

- (void)LoadTitle {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *loadstring = [defaults objectForKey:@"savedstring"];
    [TitleLabel setText:loadstring];
}

-(void)dismissKeyboard {
    [TitleLabel resignFirstResponder];
}
@end
