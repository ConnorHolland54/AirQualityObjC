//
//  CJHCityAirQuality.h
//  AirQuality
//
//  Created by Connor Holland on 6/26/20.
//  Copyright © 2020 Connor Holland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJHWeather.h"
#import "CJHPollution.h"

NS_ASSUME_NONNULL_BEGIN

@interface CJHCityAirQuality : NSObject

@property (nonatomic, copy, readonly) NSString * city;
@property (nonatomic, copy, readonly) NSString * state;
@property (nonatomic, copy, readonly) NSString * country;

@property (nonatomic, copy, readonly) CJHWeather * weather;
@property (nonatomic, copy, readonly) CJHPollution *pollution;

-(instancetype)initWithCity:(NSString *)city state:(NSString *)state country:(NSString *)country weather:(CJHWeather *)weather pollution:(CJHPollution *)pollution;

@end

@interface CJHCityAirQuality (JSONConvertable)
- (instancetype)initWithDictionary:(NSDictionary<NSString *, id>*)dictionary;
@end

NS_ASSUME_NONNULL_END
