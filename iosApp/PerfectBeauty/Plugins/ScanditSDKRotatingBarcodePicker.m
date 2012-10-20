//
//  Copyright 2010 Mirasense AG
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//
//  ScanditSDKRotatingBarcodePicker is a utility class in the demo that shows how to make the
//  ScanditSDKBarcodePicker properly change its orientation when the device is rotated by the
//  user. This class is not required when the Scandit SDK is used in portrait mode only. 
//

#import "ScanditSDKRotatingBarcodePicker.h"
#import "ScanditSDKOverlayController.h"


@implementation ScanditSDKRotatingBarcodePicker


- (id)initWithAppKey:(NSString *)scanditSDKAppKey {
    id result = [super initWithAppKey:scanditSDKAppKey];
    
    if (self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        [self adjustPickerToOrientation:AVCaptureVideoOrientationPortraitUpsideDown];
    } else if (self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        [self adjustPickerToOrientation:AVCaptureVideoOrientationLandscapeRight];
    } else if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        [self adjustPickerToOrientation:AVCaptureVideoOrientationLandscapeLeft];
    } else {
        [self adjustPickerToOrientation:AVCaptureVideoOrientationPortrait];
    }
    
    return result;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation 
                                duration:(NSTimeInterval)duration {
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        [self adjustPickerToOrientation:AVCaptureVideoOrientationPortrait];
    } else if (toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        [self adjustPickerToOrientation:AVCaptureVideoOrientationPortraitUpsideDown];
    } else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        [self adjustPickerToOrientation:AVCaptureVideoOrientationLandscapeLeft];
    } else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        [self adjustPickerToOrientation:AVCaptureVideoOrientationLandscapeRight];
    }
}

- (void)adjustPickerToOrientation:(AVCaptureVideoOrientation)orientation {
    // Change the picker's preview orientation. It is necessary to call this whenever the picker is
    // not in portrait mode or the orientation just changed.
    self.cameraPreviewOrientation = orientation;
    
    // Adjust the offset of the info banner since the dimensions are quite a bit different in
    // portrait and landscape mode.
    CGRect screen = [[UIScreen mainScreen] bounds];
    if (orientation == AVCaptureVideoOrientationLandscapeLeft
        || orientation == AVCaptureVideoOrientationLandscapeRight) {
        if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
            [self.overlayController setInfoBannerOffset:- 3 * screen.size.width / 32];
        }
    } else {
        if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
            [self.overlayController setInfoBannerOffset:0];
        }
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

@end
