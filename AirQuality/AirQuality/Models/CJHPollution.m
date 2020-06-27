//
//  CJHPollution.m
//  AirQuality
//
//  Created by Connor Holland on 6/26/20.
//  Copyright © 2020 Connor Holland. All rights reserved.
//

#import "CJHPollution.h"

@implementation CJHPollution

- (instancetype)initWithInt:(NSInteger)aqi
{
    self = [self init];
       if (self) {
           _airQualityIndex = aqi;
       }
       return self;
}

@end

@implementation CJHPollution (JSONConvertable)

    - (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSInteger aqi = [dictionary[@"aqius"] intValue];
    return [self initWithInt:aqi];
}

@end
