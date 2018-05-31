//
//  TRCityDetailViewControllerConfigurator.h
//  transition
//
//  Created by Victor Zaikin on 30/05/2018.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "TRCitiesServiceProtocol.h"

@class TRCityDetailViewController, TRExpandTransitionController;

@interface TRCityDetailViewControllerConfigurator : NSObject

- (void)configureViewController:(TRCityDetailViewController *)viewController
                     withCityId:(NSInteger)cityId
     expandTransitionController:(TRExpandTransitionController *)expandTransitionController
                  citiesService:(id<TRCitiesServiceProtocol>)citiesService;

@end
