//
//  CJHCityAirQualityController.m
//  AirQuality
//
//  Created by Connor Holland on 6/26/20.
//  Copyright © 2020 Connor Holland. All rights reserved.
//

#import "CJHCityAirQualityController.h"

static NSString * const baseURLString = @"https://api.airvisual.com/";
static NSString * const versionComponent = @"v2";
static NSString * const countryComponent = @"countries";
static NSString * const stateComponent = @"states";
static NSString * const cityComponent = @"cities";
static NSString * const cityDetailsComponent = @"city";
static NSString * const apiKey = @"cf2e1dca-1f5f-4a30-a9de-7a98683af030";

@implementation CJHCityAirQualityController

+ (void)fetchSupportedCountries:(void (^)(NSArray<NSString *> * _Nullable))completion
{
   NSURL *baseURL = [NSURL URLWithString:baseURLString];
   NSURL *versionComp = [baseURL URLByAppendingPathComponent:versionComponent];
   NSURL *countryComp = [versionComp URLByAppendingPathComponent:countryComponent];
   NSURLComponents *components = [NSURLComponents componentsWithURL:countryComp resolvingAgainstBaseURL:true];
   NSURLQueryItem *key = [NSURLQueryItem queryItemWithName:@"key" value:apiKey];
   components.queryItems = @[key];
   NSURL *finalURL = components.URL;
   NSLog(@"%@", finalURL);

    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        if (error)
        {
            NSLog(@"There was an error fetching the countries - %@, %@", error, [error localizedDescription]);
            return completion(nil);
        }
        
        if (!data)
        {
            NSLog(@"We dont have data");
        }
        
        NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSDictionary *dataDict = topLevelDictionary[@"data"];
        NSMutableArray *countries = [NSMutableArray new];
        for (NSDictionary *countryDict in dataDict)
        {
            NSString *country = [[NSString alloc] initWithString:countryDict[@"country"]];
            [countries addObject:country];
        }
        completion(countries);
    }]resume];
}

+ (void)fetchSupportedStatesInCountry:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    //https://api.airvisual.com/v2/states?country=USA&key=cf2e1dca-1f5f-4a30-a9de-7a98683af030
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *versionComp = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL *stateComp = [versionComp URLByAppendingPathComponent:stateComponent];
    NSURLComponents *components = [NSURLComponents componentsWithURL:stateComp resolvingAgainstBaseURL:true];
    NSURLQueryItem  *countryQueryItem = [NSURLQueryItem queryItemWithName:@"country" value:country];
    NSURLQueryItem *key = [NSURLQueryItem queryItemWithName:@"key" value:apiKey];
    components.queryItems = @[countryQueryItem, key];
    NSURL *finalURL = components.URL;
    NSLog(@"%@", finalURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData *  data, NSURLResponse * response, NSError * error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            return completion(nil);
        }
        
        if (!data) {
            NSLog(@"We dont have data");
            return completion(nil);
        }
        
        NSDictionary *topLevel = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        NSArray *postData = topLevel[@"data"];
        NSMutableArray *statesArray = [NSMutableArray new];
        
        for (NSDictionary *stateDictionary in postData) {
            NSString *state = [[NSString alloc] initWithString:stateDictionary[@"state"]];
            [statesArray addObject:state];
        }
        completion(statesArray);
    }]resume];
}

+ (void)fetchSupportedCitiesInState:(NSString *)state country:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    //https://api.airvisual.com/v2/cities?state=Colorado&country=USA&key=cf2e1dca-1f5f-4a30-a9de-7a98683af030
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *versionComp = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL *cityComp = [versionComp URLByAppendingPathComponent:cityComponent];
    NSURLComponents *components = [NSURLComponents componentsWithURL:cityComp resolvingAgainstBaseURL:true];
    NSURLQueryItem  *stateQueryItem = [NSURLQueryItem queryItemWithName:@"state" value:state];
    NSURLQueryItem  *countryQueryItem = [NSURLQueryItem queryItemWithName:@"country" value:country];
    NSURLQueryItem *key = [NSURLQueryItem queryItemWithName:@"key" value:apiKey];
    components.queryItems = @[stateQueryItem, countryQueryItem, key];
    NSURL *finalURL = components.URL;
    NSLog(@"%@", finalURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            return completion(nil);
        }
        
        if (!data) {
            NSLog(@"We dont have data");
            return completion(nil);
        }
        
        NSDictionary *topLevel = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        NSArray *postData = topLevel[@"data"];
        NSMutableArray *citiesArray = [NSMutableArray new];
        
        for (NSDictionary *stateDictionary in postData) {
            NSString *state = [[NSString alloc] initWithString:stateDictionary[@"city"]];
            [citiesArray addObject:state];
        }
        completion(citiesArray);
    }]resume];
}

+ (void)fetchDataForCity:(NSString *)city state:(NSString *)state country:(NSString *)country completion:(void (^)(CJHCityAirQuality * _Nullable))completion
{
    //https://api.airvisual.com/v2/city?city=Broomfield&state=Colorado&country=USA&key=cf2e1dca-1f5f-4a30-a9de-7a98683af030
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *versionComp = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL *cityDetailComp = [versionComp URLByAppendingPathComponent:cityDetailsComponent];
    NSURLComponents *components = [NSURLComponents componentsWithURL:cityDetailComp resolvingAgainstBaseURL:true];
    NSURLQueryItem  *cityQueryItem = [NSURLQueryItem queryItemWithName:@"city" value:city];
    NSURLQueryItem  *stateQueryItem = [NSURLQueryItem queryItemWithName:@"state" value:state];
    NSURLQueryItem  *countryQueryItem = [NSURLQueryItem queryItemWithName:@"country" value:country];
    NSURLQueryItem *key = [NSURLQueryItem queryItemWithName:@"key" value:apiKey];
    components.queryItems = @[cityQueryItem, stateQueryItem, countryQueryItem, key];
    NSURL *finalURL = components.URL;
    NSLog(@"%@", finalURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            return completion(nil);
        }
        
        if (data) {
            NSDictionary *topLevel = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSDictionary *dataDictionary = topLevel [@"data"];
            CJHCityAirQuality *cityAqi = [[CJHCityAirQuality alloc] initWithDictionary:dataDictionary];
            completion(cityAqi);
        }
    }]resume];
}

@end
