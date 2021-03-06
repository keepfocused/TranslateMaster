//
//  QuoteGeneratorController.m
//  randomGenerator
//
//  Created by Admin on 28.08.17.
//  Copyright © 2017 Galiev Danil. All rights reserved.
//

#import "TextAnalyzer.h"
#import "WordData.h"


@interface TextAnalyzer ()

@property (strong, nonatomic) NSMutableArray* sortedArray;

@property (strong, nonatomic) NSMutableArray* tempArrayForSort;


@end

@implementation TextAnalyzer

- (void)performTextAnalyze {


    self.sortedArray = [NSMutableArray array];
    
    
    NSString* content = self.textForImport;


    NSArray* splitByLines = [content componentsSeparatedByString:@"\n"];

   // NSLog(@"separated string = %@", splitByLines);

    NSMutableArray* editedText = [NSMutableArray array];

    for (NSString* str in splitByLines) {

    //NSLog(@"first obj = %@",str);

        NSString* tempStr2 = str;

    while (([tempStr2 containsString:@"."]  ||
            [tempStr2 containsString:@""""] ||
            [tempStr2 containsString:@","]  ||
            [tempStr2 containsString:@"//"] ||
            [tempStr2 containsString:@"("]  ||
            [tempStr2 containsString:@"*"]  ||
            [tempStr2 containsString:@"_"]  ||
            [tempStr2 containsString:@">"]  ||
            [tempStr2 containsString:@"<"]  ||
            [tempStr2 containsString:@"\\"] ||
            [tempStr2 containsString:@"}"]  ||
            [tempStr2 containsString:@"{"]  ||
            [tempStr2 containsString:@":"]  ||
            [tempStr2 containsString:@"="]  ||
            [tempStr2 containsString:@"?"])) {

            NSString* tempStr = str;

            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"." withString:@""];
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"," withString:@""];
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"""" withString:@""];
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"//" withString:@""];
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"(" withString:@""];
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@")" withString:@""];
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"*" withString:@""];
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"_" withString:@""];
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@">" withString:@""];
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"<" withString:@""];
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"\\" withString:@""];
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"{" withString:@""];
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"}" withString:@""];
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@":" withString:@""];
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"=" withString:@""];
            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"?" withString:@""];




        tempStr2 = tempStr;

            [editedText addObject:tempStr];
        }
   }


    NSString* combinedString = [editedText componentsJoinedByString:@" "];

    combinedString = [combinedString capitalizedString];

    //NSLog(@"combined string = %@", combinedString);

    NSArray* singleWords = [combinedString componentsSeparatedByString:@" "];

    NSMutableArray* tempArray1 = [NSMutableArray array];

    for (NSString* str in singleWords)
    {

        if ([str length] >= 3) {
            [tempArray1 addObject:str];

        }
    }

    singleWords = tempArray1;

   // NSLog(@" single words array = %@", singleWords);

    NSMutableArray* tempArray = [[NSMutableArray alloc] init];
    NSMutableArray* repeatedWords = [NSMutableArray array];



    for (NSString* comparingWord in singleWords) {

        if ([tempArray count] > 0) {

            for (NSString* alreadyContainedWord in tempArray) {

                if ([alreadyContainedWord isEqualToString:comparingWord]) {
                    [repeatedWords addObject:comparingWord];
                }
            }

            [tempArray addObject:comparingWord];



        } else [tempArray addObject:comparingWord];

    }

    //NSString* monoString = [repeatedWords componentsJoinedByString:@" "];

    NSMutableArray* sortedArray = [NSMutableArray array];

    sortedArray = [repeatedWords sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];

    NSMutableArray* arrayWithWordData = [NSMutableArray array];

    NSLog(@"count of array = %ld", (unsigned long)[sortedArray count]);




    NSInteger count = 0;

    for (int i = 0; i < [sortedArray count] - 1; i++) {

        if ([[sortedArray objectAtIndex:i] isEqualToString:[sortedArray objectAtIndex:i + 1]])  {

            count++;
        }

        else
        {
            WordData* word = [[WordData alloc] init];
            word.word = [sortedArray objectAtIndex:i];
            word.repeatsCount = count;
            count = 0;
            [arrayWithWordData addObject:word];
        }
    }

    NSLog(@"count of array before sort = %ld", [arrayWithWordData count]);



    [self sortArray:arrayWithWordData];













    


//    for (WordData* word in arrayWithWordData) {
//
//
//        NSLog(@" %@ : %ld", word.word, (long)word.repeatsCount);
//    }

    NSLog(@"count of array after sort = %ld", [arrayWithWordData count]);

    for (WordData* word in arrayWithWordData) {

        NSLog(@"%@ : %ld",word.word, word.repeatsCount);
    }
    
    //self.analyzedWords = [NSMutableArray array];
    
    
    
    self.analyzedWords = arrayWithWordData;
    
//    NSLog(@"call sort method");
//    
//    self.tempArrayForSort = [NSMutableArray array];
//    
//    [self sortArray:sortedArray];
//    
//    
//    NSLog(@"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
//    
//    NSLog(@"sorted array = \n");
//    
//    
//    for (WordData* word in arrayWithWordData) {
//        
//        NSLog(@"%@ : %ld", word.word, word.repeatsCount);
//    }
//    
//    for (WordData* word in self.tempArrayForSort) {
//        
//        NSLog(@"%@ : %ld", word.word, word.repeatsCount);
//    }
    
    
    

    
}

- (NSMutableArray*) sortArray:(NSMutableArray*)arrayForSort
{
    
    NSMutableArray* tempArray = [NSMutableArray array];
    
    tempArray = arrayForSort;

    for (int i = 0; i < [tempArray count] - 1 ; i++) {
        if ([[tempArray objectAtIndex:i] repeatsCount] < [[tempArray objectAtIndex:i + 1] repeatsCount]) {

            WordData* biggerObj = [tempArray objectAtIndex:i + 1];
            WordData* lessObj = [tempArray objectAtIndex:i];
            //NSLog(@"before replace obj i : %@ obji +1 : %@", lessObj.word, biggerObj.word);
            [tempArray replaceObjectAtIndex:i withObject:[tempArray objectAtIndex:i + 1]];
            //NSLog(@"after replace obj i : %@ obji + 1 : %@", [[arrayForSort objectAtIndex:0] word],[[arrayForSort objectAtIndex:i + 1]word] );
            self.tempArrayForSort = tempArray;
            [self sortArray:self.tempArrayForSort];
        } else continue;

    }
    
    return tempArray;

}







@end
