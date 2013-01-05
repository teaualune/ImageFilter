//
//  IFViewController.h
//  ImageFilter
//
//  Created by Teaualune Tseng on 12/12/25.
//  Copyright (c) 2012年 Teaualune Tseng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IFViewController : UIViewController
{
    CIFilter *colorControl;
    CIImage *mainImage;
}

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIButton *firstFilterButton;
@property (weak, nonatomic) IBOutlet UIButton *secondFilterButton;

@property (weak, nonatomic) IBOutlet UISlider *saturationSlider;
@property (weak, nonatomic) IBOutlet UISlider *brightnessSlider;
@property (weak, nonatomic) IBOutlet UISlider *contrastSlider;

@property (weak, nonatomic) IBOutlet UILabel *saturationLabel;
@property (weak, nonatomic) IBOutlet UILabel *brightnessLabel;
@property (weak, nonatomic) IBOutlet UILabel *contrastLabel;

-(IBAction)changeSaturation:(id)sender;
-(IBAction)changeBrightness:(id)sender;
-(IBAction)changeContrast:(id)sender;

@end
