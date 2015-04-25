//
//  PhotoVideoNote.m
//  Moves
//
//  Created by Eric Seo on 4/24/15.
//  Copyright (c) 2015 SeoEricc. All rights reserved.
//

#import "PhotoVideoNote.h"

@interface PhotoVideoNote ()

@end

@implementation PhotoVideoNote

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)GotoPhoto {
    Imagepicker = [[UIImagePickerController alloc] init];
    Imagepicker.delegate = self;
    [Imagepicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:Imagepicker animated:YES completion:NULL];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [ImageView setImage:image];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

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


- (IBAction)TakeFromLibrary:(id)sender {
    Imagepicker = [[UIImagePickerController alloc] init];
    Imagepicker.delegate = self;
    [Imagepicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:Imagepicker animated:YES completion:NULL];
}

- (IBAction)BackButton {
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
