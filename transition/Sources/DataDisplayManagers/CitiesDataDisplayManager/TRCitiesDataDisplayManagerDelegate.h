//
//  TRCitiesDataDisplayManagerDelegate.h
//  transition
//
//  Created by Victor Zaikin on 30/05/2018.
//

@class TRCitiesDataDisplayManager, TRCityModel;

@protocol TRCitiesDataDisplayManagerDelegate

- (void)dataDisplayManager:(TRCitiesDataDisplayManager *)dataDisplayManager didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end
