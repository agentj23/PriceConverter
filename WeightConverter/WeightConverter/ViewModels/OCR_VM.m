//
//  OCR_VM.m
//  WeightConverter
//
//  Created by Kamil Czopek on 01.02.2015.
//  Copyright (c) 2015 Kamil Czopek. All rights reserved.
//

#import "OCR_VM.h"
#import "G8Tesseract.h"
#import "UIImage+G8Filters.h"
#import "G8RecognitionOperation.h"

@implementation OCR_VM

- (NSString*)stringWithImage:(UIImage*)image
{
    // Languages are used for recognition (e.g. eng, ita, etc.). Tesseract engine
    // will search for the .traineddata language file in the tessdata directory.
    // For example, specifying "eng+ita" will search for "eng.traineddata" and
    // "ita.traineddata". Cube engine will search for "eng.cube.*" files.
    // See https://code.google.com/p/tesseract-ocr/downloads/list.
    
    // Create your G8Tesseract object using the initWithLanguage method:
    G8Tesseract *tesseract = [[G8Tesseract alloc] initWithLanguage:@"eng"];
    tesseract.delegate = self;
    
    // Optionaly: You could specify engine to recognize with.
    // G8OCREngineModeTesseractOnly by default. It provides more features and faster
    // than Cube engine. See G8Constants.h for more information.
    //tesseract.engineMode = G8OCREngineModeTesseractOnly;
    
    // Set up the delegate to receive Tesseract's callbacks.
    // self should respond to TesseractDelegate and implement a
    // "- (BOOL)shouldCancelImageRecognitionForTesseract:(G8Tesseract *)tesseract"
    // method to receive a callback to decide whether or not to interrupt
    // Tesseract before it finishes a recognition.
    
    // Optional: Limit the character set Tesseract should try to recognize from
    tesseract.charWhitelist = @"0123456789,.";
    
    // This is wrapper for common Tesseract variable kG8ParamTesseditCharWhitelist:
    // [tesseract setVariableValue:@"0123456789" forKey:kG8ParamTesseditCharBlacklist];
    // See G8TesseractParameters.h for a complete list of Tesseract variables
    
    // Optional: Limit the character set Tesseract should not try to recognize from
//    tesseract.charBlacklist = @"abcdefghijklmnoprstuwxyzABCDEFGHIJKLMNOPRSTUWXYZ";
    
    // Specify the image Tesseract should recognize on
    tesseract.image = [image g8_blackAndWhite];
    
    // Optional: Limit the area of the image Tesseract should recognize on to a rectangle
//    tesseract.rect = CGRectMake(20, 20, 100, 100);
    
    // Optional: Limit recognition time with a few seconds
//    tesseract.maximumRecognitionTime = 2.0;
    
    // Start the recognition
    [tesseract recognize];
    
    // Retrieve the recognized text
    NSString *recognizedString = [tesseract recognizedText];
    NSLog(@"RECOGNISED STRING%@", recognizedString);
    
    // You could retrieve more information about recognized text with that methods:
//    NSArray *characterBoxes = [tesseract recognizedBlocksByIteratorLevel:G8PageIteratorLevelSymbol];
//    NSArray *paragraphs = [tesseract recognizedBlocksByIteratorLevel:G8PageIteratorLevelParagraph];
    NSArray *characterChoices = tesseract.characterChoices;
    NSLog(@"CHARACTER CHOICES: %@", characterChoices);
//    UIImage *imageWithBlocks = [tesseract imageWithBlocks:characterBoxes drawText:YES thresholded:NO];
    
    return recognizedString;
}

// Add implementation in block

- (void)stringWithImage:(UIImage*)image onSuccess:(void (^)(NSString *recognizedString))successBlock
{
    // Create RecognitionOperation
    G8RecognitionOperation *operation = [[G8RecognitionOperation alloc] init];
    
    // Configure inner G8Tesseract object as described before
    operation.tesseract.language = @"eng+ita";
    operation.tesseract.charWhitelist = @"01234567890";
    operation.tesseract.image = [image g8_blackAndWhite];
    
    // Setup the recognitionCompleteBlock to receive the Tesseract object
    // after text recognition. It will hold the recognized text.
    operation.recognitionCompleteBlock = ^(G8Tesseract *recognizedTesseract) {
        // Retrieve the recognized text upon completion
        NSString *recognizedText = [recognizedTesseract recognizedText];
        NSArray *characterChoices = recognizedTesseract.characterChoices;
        NSLog(@"REC TEXT: %@", recognizedText);
        NSLog(@"REC CHOICES: %@", characterChoices);
        successBlock(recognizedText);
    };
    
    // Add operation to queue
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}


- (void)progressImageRecognitionForTesseract:(G8Tesseract *)tesseract {
    NSLog(@"progress: %lu", (unsigned long)tesseract.progress);
}

- (BOOL)shouldCancelImageRecognitionForTesseract:(G8Tesseract *)tesseract {
    return NO;  // return YES, if you need to interrupt tesseract before it finishes
}

@end
