//
//  OCR_VM.h
//  WeightConverter
//
//  Created by Kamil Czopek on 01.02.2015.
//  Copyright (c) 2015 Kamil Czopek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "G8TesseractDelegate.h"

@interface OCR_VM : NSObject <G8TesseractDelegate>

- (NSString*)stringWithImage:(UIImage*)image;
- (void)stringWithImage:(UIImage*)image onSuccess:(void (^)(NSString *recognizedString))successBlock;

@end
