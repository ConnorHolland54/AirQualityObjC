//
//  CJHCityAirQualityController.h
//  AirQuality
//
//  Created by Connor Holland on 6/26/20.
//  Copyright © 2020 Connor Holland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJHCityAirQuality.h"

NS_ASSUME_NONNULL_BEGIN

@interface CJHCityAirQualityController : NSObject

+ (void)fetchSupportedCountries:(void(^)(NSArray<NSString *>*))completion;

+ (void)fetchSupportedStatesInCountry: (NSString *)country completion:(void(^)(NSArray<NSString *> *))completion;

+ (void)fetchSupportedCitiesInState:(NSString*)state country:(NSString *)country completion:(void(^)(NSArray<NSString *> *))completion;

+ (void)fetchDataForCity:(NSString*)city state:(NSString *)state country:(NSString *)country completion:(void(^)(CJHCityAirQuality *))completion;

@end

NS_ASSUME_NONNULL_END
