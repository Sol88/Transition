//
//  TRCitiesViewController.h
//  transition
//
//  Created by Victor Zaikin on 26/05/2018.
//

#import <UIKit/UIKit.h>

#import "TRCitiesServiceProtocol.h"

@class TRCitiesDataDisplayManager, TRExpandTransitionController;

@interface TRCitiesViewController : UIViewController

@property (strong, nonatomic) TRExpandTransitionController *expandTransitionController;
@property (strong, nonatomic) id<TRCitiesServiceProtocol> citiesService;
@property (strong, nonatomic) TRCitiesDataDisplayManager *citiesDataDisplayManager;

@end
