//
//  ViewController.h
//  PhotoTouch
//
//  Created by Vidya Ramamurthy on 24/12/15.
//  Copyright © 2015 BridgeLabz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolBox/AudioToolBox.h>


@interface ViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    SystemSoundID *mySound;
}

- (IBAction)addButtonPresses:(id)sender;

@end

