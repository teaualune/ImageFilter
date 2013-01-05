//
//  IFViewController.m
//  ImageFilter
//
//  Created by Teaualune Tseng on 12/12/25.
//  Copyright (c) 2012年 Teaualune Tseng. All rights reserved.
//

#import "IFViewController.h"

@interface IFViewController ()

-(IBAction)firstFilter:(id)sender;
-(IBAction)secondFilter:(id)sender;

-(void) applyNewFilter;

@end

@implementation IFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    colorControl = [CIFilter filterWithName:@"CIColorControls"];
    [colorControl setValue:[[CIImage alloc] initWithImage:[UIImage imageNamed:@"if_ex.jpg"]] forKey:@"inputImage"];
    [colorControl setValue:@1 forKey:@"inputSaturation"];
    [colorControl setValue:@0 forKey:@"inputBrightness"];
    [colorControl setValue:@1 forKey:@"inputContrast"];
    
    [self applyNewFilter];
    
    // set up two filters
    CIFilter *filter = [CIFilter filterWithName:@"CIColorControls"];
    CIContext *context = [CIContext contextWithOptions:nil];
    [filter setValue:[[CIImage alloc] initWithImage:[UIImage imageNamed:@"if_ex.jpg"]] forKey:@"inputImage"];
    CIImage *output = [filter valueForKey:@"outputImage"];
    
    [filter setValue:@0 forKey:@"inputSaturation"];
    [filter setValue:@0 forKey:@"inputBrightness"];
    [filter setValue:@1 forKey:@"inputContrast"];
    [self.firstFilterButton setBackgroundImage: [UIImage imageWithCGImage:[context createCGImage:[filter valueForKey:@"outputImage"] fromRect:output.extent]] forState:UIControlStateNormal];
    
    [filter setValue:@0.9 forKey:@"inputSaturation"];
    [filter setValue:@0.5 forKey:@"inputBrightness"];
    [filter setValue:@0.9 forKey:@"inputContrast"];
    [self.secondFilterButton setBackgroundImage: [UIImage imageWithCGImage:[context createCGImage:[filter valueForKey:@"outputImage"] fromRect:output.extent]] forState:UIControlStateNormal];    
    
    // add observers
    [colorControl addObserver:self forKeyPath:@"inputSaturation" options:NSKeyValueObservingOptionNew context:NULL];
    [colorControl addObserver:self forKeyPath:@"inputBrightness" options:NSKeyValueObservingOptionNew context:NULL];
    [colorControl addObserver:self forKeyPath:@"inputContrast" options:NSKeyValueObservingOptionNew context:NULL];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)firstFilter:(id)sender
{
    [colorControl setValue:@0 forKey:@"inputSaturation"];
    [colorControl setValue:@0 forKey:@"inputBrightness"];
    [colorControl setValue:@1 forKey:@"inputContrast"];
    [self applyNewFilter];
}

-(IBAction)secondFilter:(id)sender
{
    [colorControl setValue:@0.9 forKey:@"inputSaturation"];
    [colorControl setValue:@0.5 forKey:@"inputBrightness"];
    [colorControl setValue:@0.9 forKey:@"inputContrast"];
    [self applyNewFilter];
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"inputSaturation"]) {
    
        self.saturationLabel.text = [NSString stringWithFormat:@"%.1f", [[colorControl valueForKey:@"inputSaturation"] floatValue]];
        self.saturationSlider.value = [[colorControl valueForKey:@"inputSaturation"] floatValue];
        
    } else if ([keyPath isEqualToString:@"inputBrightness"]) {
        
        self.brightnessLabel.text = [NSString stringWithFormat:@"%.1f", [[colorControl valueForKey:@"inputBrightness"] floatValue]];
        self.brightnessSlider.value = [[colorControl valueForKey:@"inputBrightness"] floatValue];
    
    } else if ([keyPath isEqualToString:@"inputContrast"]) {
        
        self.contrastLabel.text = [NSString stringWithFormat:@"%.1f", [[colorControl valueForKey:@"inputContrast"] floatValue]];
        self.contrastSlider.value = [[colorControl valueForKey:@"inputContrast"] floatValue];
    }
    
    [self applyNewFilter];
}


-(IBAction)changeSaturation:(id)sender
{
    [colorControl setValue:[NSNumber numberWithFloat:((UISlider *) sender).value] forKey:@"inputSaturation"];
}

-(IBAction)changeBrightness:(id)sender
{
    [colorControl setValue:[NSNumber numberWithFloat:((UISlider *) sender).value] forKey:@"inputBrightness"];
}

-(IBAction)changeContrast:(id)sender
{
    [colorControl setValue:[NSNumber numberWithFloat:((UISlider *) sender).value] forKey:@"inputContrast"];
}

-(void) applyNewFilter
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *output = [colorControl valueForKey:@"outputImage"];
    self.mainImageView.image = [UIImage imageWithCGImage:[context createCGImage:output fromRect:output.extent]];
}

@end
