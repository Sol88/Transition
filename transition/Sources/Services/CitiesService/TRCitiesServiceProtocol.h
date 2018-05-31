//
//  TRCitiesServiceProtocol.h
//  transition
//
//  Created by Victor Zaikin on 30/05/2018.
//

@class TRCityModel;

@protocol TRCitiesServiceProtocol

- (void)fetchCitiesWithCompletion:(void (^)(NSArray<TRCityModel *> *cities)) completion;
- (void)fetchCityWithId:(NSInteger)cityId completion:(void (^)(TRCityModel *city))completion;

@end
