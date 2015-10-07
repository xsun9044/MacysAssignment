//
//  Word.h
//  MacysAssignment
//
//  Created by Xin Sun on 10/7/15.
//  Copyright © 2015 Xin Sun. All rights reserved.
//

#import "Word.h"
@interface Word()
@end

@implementation Word

- (instancetype)initWithMeaning:(NSString *)meaning andStartYear:(NSInteger)year andFreq:(NSInteger)freq {
    self = [super init];
    if (self) {
        self.meaning = meaning;
        self.year = year;
        self.freq = freq;
    }
    
    return self;
}

@end
