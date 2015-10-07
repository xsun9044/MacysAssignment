//
//  IOSRequest.m
//  MacysAssignment
//
//  Created by Xin Sun on 10/6/15.
//  Copyright © 2015 Xin Sun. All rights reserved.
//

#import "IOSRequest.h"
#import "AFNetworking.h"
#import "NSString+WebService.h"

@implementation IOSRequest

#define BASE_URL @"http://www.nactem.ac.uk/software/acromine/dictionary.py" // URL for dictionary

#define NUM_RETRIES_COMMUNICATE 3 // try 3 times

+ (void)requestPath:(NSString *)requestPath numTimes:(NSUInteger)ntimes onCompletion:(RequestCompletionHandler)complete
{
    if (ntimes <= 0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        complete(nil, [[NSError alloc] initWithDomain:@"CONNECT FAIL" code:502 userInfo:nil]);
    } else {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        NSURL *baseURL = [NSURL URLWithString:requestPath];
        NSDictionary *parameters = @{@"format": @"json"};
        
        AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
        [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [client setDefaultHeader:@"Accept" value:@"application/json"];
        
        [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/plain"]];
        
        [client getPath:requestPath
             parameters:parameters
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    if (complete) {
                        complete(responseObject, nil);
                    }
                }
                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog (@"Error retrieving info %@", [NSString stringWithFormat:@"%@", error]);
                    [self requestPath:requestPath numTimes:ntimes-1 onCompletion:complete];
                    
                    
                }
         ];
        
    }
}

+ (void)getMeaningOfAcronym:(NSString *)acronym
               onCompletion:(RequestDictionaryCompletionHandler)complete
{
    acronym = [acronym URLEncode];
    NSString *detailPath = [NSString stringWithFormat:@"%@?sf=%@",BASE_URL,acronym];
    NSLog(@"%@", detailPath);
    [IOSRequest requestPath:detailPath numTimes:NUM_RETRIES_COMMUNICATE onCompletion:^(NSString *result, NSError *error) {
        if (error) {
            if (complete) complete(nil);
        } else {
            if (complete) complete((NSArray *)result);
        }
    }];
    
}

@end