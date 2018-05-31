//
//  TRCityDetailViewController.h
//  transition
//
//  Created by Victor Zaikin on 27/05/2018.
//

#import <UIKit/UIKit.h>
#import "TRCitiesServiceProtocol.h"

@class TRCityModel;

@interface TRCityDetailViewController : UIViewController

@property(nonatomic) NSInteger cityId;
@property (strong, nonatomic) id<TRCitiesServiceProtocol> citiesService;

@end
