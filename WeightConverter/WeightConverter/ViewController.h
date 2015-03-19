//
//  ViewController.h
//  WeightConverter
//
//  Created by Kamil Czopek on 01.02.2015.
//  Copyright (c) 2015 Kamil Czopek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Canvas.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *recognizedValue;
@property (strong, nonatomic) IBOutlet Canvas *imageView;

@end

