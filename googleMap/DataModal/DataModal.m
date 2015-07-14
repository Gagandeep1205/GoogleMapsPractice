//
//  DataModal.m
//  googleMap
//
//  Created by Gagandeep Kaur on 13/07/15.
//  Copyright (c) 2015 Gagandeep Kaur. All rights reserved.
//

#import "DataModal.h"

@implementation DataModal


- (void) callAPI :(NSString *)urlStr : (void(^)(NSDictionary * response_success))success : (void(^)(NSError * response_error))failure {
    
    [iOSRequest getJSONResponse:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&key=AIzaSyBR6fXbmioTtztYLA8N4vpzRC5Kxcovew0",urlStr] : ^(NSDictionary *response_success){
        success(response_success);
    } :^(NSError* response_error){
        failure(response_error);
    }];

}

@end