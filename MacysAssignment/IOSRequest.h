//
//  IOSRequest.h
//  MacysAssignment
//
//  Created by Xin Sun on 10/6/15.
//  Copyright © 2015 Xin Sun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void(^RequestCompletionHandler)(NSString*,NSError*);
typedef void(^RequestDictionaryCompletionHandler)(NSArray*);

@interface IOSRequest : NSObject

+ (void)getMeaningOfAcronym:(NSString *)acronym onCompletion:(RequestDictionaryCompletionHandler)complete;

@end
