//
//  ViewController.m
//  PhotoTouch
//
//  Created by Vidya Ramamurthy on 24/12/15.
//  Copyright © 2015 BridgeLabz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   //NSURL *soundURL=[[NSBundle mainBundle]URLForResource:@"click" withExtension:@"aiff"];
    
    NSURL *soundURL=[[NSBundle mainBundle]URLForResource:@"click" withExtension:@"aiff"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &mySound);
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addButtonPresses:(id)sender {
    
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
    [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [imagePicker setDelegate:self];
    [self presentViewController:imagePicker animated:YES completion:NULL];
    
}

// moving image
-(void)panGestureRecognized:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint newPoint=[gestureRecognizer locationInView:[self view]];
    [[self view] bringSubviewToFront:[gestureRecognizer view]];
    [[gestureRecognizer view]setCenter:newPoint];
}


-(void)tapGestureRecognized:(UITapGestureRecognizer *)gestureRecognizer
{
    [[self view] bringSubviewToFront:[gestureRecognizer view]];
    [UIView animateWithDuration:0.2 animations:^{
    
        [[gestureRecognizer view]setBounds:CGRectMake(-80, -80, 100, 100)];
    }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.2 animations:^{
                             
                             [[gestureRecognizer view]setBounds:CGRectMake(0, 0, 80, 80)];
                         }];
    
    
    }];
}



-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{//ading image
    
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    UIImageView *newImageView=[[UIImageView alloc]initWithImage:image];
    [newImageView setFrame:CGRectMake(-80,-80, 80, 80)];
    [[self view]addSubview:newImageView];
    [newImageView setUserInteractionEnabled:YES];
    UIPanGestureRecognizer *panGestureRecognizer=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognized:)];//for moving
    
    [newImageView addGestureRecognizer:panGestureRecognizer];
    
    UITapGestureRecognizer *tapGestureRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecognized:)];
    
    [newImageView addGestureRecognizer:tapGestureRecognizer];
    
  [self dismissViewControllerAnimated:YES completion:^{
        AudioServicesPlaySystemSound(mySound);
      [[self view]addSubview:newImageView];
    
        [UIView animateWithDuration:0.2 animations:^{
        [newImageView setFrame:CGRectMake(arc4random_uniform(240),arc4random_uniform(300), 180, 180)];
        //[newImageView setAlpha:0.5];
    
    }];
    }];

}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}



@end
