//
//  IOSRequest.h
//  ApiCalling
//
//  Created by Gagandeep Kaur on 06/07/15.
//  Copyright (c) 2015 Gagandeep Kaur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

@interface iOSRequest : NSObject

+(void)getJSONResponse :(NSString *)urlStr : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure ;

+(void)postMutliPartData : (NSString *)urlStr : (NSDictionary *)parameters : (NSData *)data : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure;

+(void)postEmoticons : (NSString *)url parameters:(NSDictionary *)dparameters  success: (void (^) (NSDictionary *responseStr))success failure: (void (^) (NSError *error))failure;

@end
