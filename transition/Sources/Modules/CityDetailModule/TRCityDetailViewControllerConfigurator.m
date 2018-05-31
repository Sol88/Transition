//
//  TRCityDetailViewControllerConfigurator.m
//  transition
//
//  Created by Victor Zaikin on 30/05/2018.
//

#import "TRCityDetailViewControllerConfigurator.h"
#import "TRCityDetailViewController.h"
#import "TRExpandTransitionController.h"

@implementation TRCityDetailViewControllerConfigurator

- (void)configureViewController:(TRCityDetailViewController *)viewController
                     withCityId:(NSInteger)cityId
 expandTransitionController:(TRExpandTransitionController *)expandTransitionController
                  citiesService:(id<TRCitiesServiceProtocol>)citiesService
{
    viewController.cityId = cityId;
    viewController.citiesService = citiesService;
    viewController.transitioningDelegate = expandTransitionController;
}

@end
