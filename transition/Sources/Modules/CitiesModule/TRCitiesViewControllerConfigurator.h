//
//  TRCitiesViewControllerConfigurator.h
//  transition
//
//  Created by Victor Zaikin on 30/05/2018.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "TRCitiesServiceProtocol.h"

@class TRCitiesViewController, TRExpandTransitionController;

@interface TRCitiesViewControllerConfigurator : NSObject

- (void)configureViewController:(TRCitiesViewController *)viewController
              withCitiesService:(id<TRCitiesServiceProtocol>)citiesService
     expandTransitionController:(TRExpandTransitionController *)transitionsCoordinator;

@end
