//
//  ViewController.m
//  WeightConverter
//
//  Created by Kamil Czopek on 01.02.2015.
//  Copyright (c) 2015 Kamil Czopek. All rights reserved.
//

#import "ViewController.h"
#import "OCR_VM.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ocrValue:(id)sender
{
    OCR_VM *ocrVM = [OCR_VM new];
//    self.recognizedValue.text = [ocrVM stringWithImage:self.imageView.image];
    [ocrVM stringWithImage:self.imageView.image onSuccess:^(NSString *text){
        self.recognizedValue.text = text;
        self.imageView.image = nil;
    }];
//    self.imageView.image = nil;
}

@end
