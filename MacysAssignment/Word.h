//
//  Word.h
//  MacysAssignment
//
//  Created by Xin Sun on 10/7/15.
//  Copyright © 2015 Xin Sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Word : NSObject

@property (nonatomic, strong) NSString *meaning;
@property (nonatomic) NSInteger year;
@property (nonatomic) NSInteger freq;

- (instancetype)initWithMeaning:(NSString *)meaning andStartYear:(NSInteger)year andFreq:(NSInteger)freq;

@end
