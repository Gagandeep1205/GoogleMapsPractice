//
//  DataModal.h
//  googleMap
//
//  Created by Gagandeep Kaur on 13/07/15.
//  Copyright (c) 2015 Gagandeep Kaur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iOSRequest.h"
@interface DataModal : NSObject

-(void) callAPI :(NSString *)urlStr : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure ;

@end
