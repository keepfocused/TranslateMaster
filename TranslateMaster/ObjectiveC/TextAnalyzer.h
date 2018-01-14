//
//  QuoteGeneratorController.h
//  randomGenerator
//
//  Created by Admin on 28.08.17.
//  Copyright © 2017 Galiev Danil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextAnalyzer : NSObject

@property (strong, nonatomic) NSString* textForImport;
@property (strong, nonatomic) NSMutableArray* analyzedWords;

- (void)performTextAnalyze;

@end
