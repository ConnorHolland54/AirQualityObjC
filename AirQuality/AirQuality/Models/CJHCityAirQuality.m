//
//  CJHCityAirQuality.m
//  AirQuality
//
//  Created by Connor Holland on 6/26/20.
//  Copyright © 2020 Connor Holland. All rights reserved.
//

#import "CJHCityAirQuality.h"

@implementation CJHCityAirQuality

- (instancetype)initWithCity:(NSString *)city state:(NSString *)state country:(NSString *)country weather:(CJHWeather *)weather pollution:(CJHPollution *)pollution
{
    self = [super init];
    if (self)
    {
        _city = city;
        _state = state;
        _country = country;
        _weather = weather;
        _pollution = pollution;
    }
    return self;
}

@end

@implementation CJHCityAirQuality (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString *city = dictionary[@"city"];
    NSString *state = dictionary[@"state"];
    NSString *country = dictionary[@"country"];
    NSDictionary *currentInfo = dictionary[@"current"];
    
    CJHWeather *weather = [[CJHWeather alloc] initWithDictionary:currentInfo[@"weather"]];
    CJHPollution *pollution = [[CJHPollution alloc] initWithDictionary:currentInfo[@"pollution"]];
    
    return [self initWithCity:city state:state country:country weather:weather pollution:pollution];
}


@end
