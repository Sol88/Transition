//
//  TRCitiesViewControllerConfigurator.m
//  transition
//
//  Created by Victor Zaikin on 30/05/2018.
//

#import "TRCitiesViewControllerConfigurator.h"
#import "TRCitiesViewController.h"
#import "TRCitiesDataDisplayManager.h"

@implementation TRCitiesViewControllerConfigurator

- (void)configureViewController:(TRCitiesViewController *)viewController
              withCitiesService:(id<TRCitiesServiceProtocol>)citiesService
     expandTransitionController:(TRExpandTransitionController *)transitionsCoordinator {

    viewController.citiesService = citiesService;
    viewController.expandTransitionController = transitionsCoordinator;
    viewController.citiesDataDisplayManager = [[TRCitiesDataDisplayManager alloc] init];
}

@end
