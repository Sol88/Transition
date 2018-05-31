//
//  TRCitiesDataDisplayManager.h
//  transition
//
//  Created by Victor Zaikin on 26/05/2018.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TRCitiesDataDisplayManagerDelegate.h"

@class TRCityModel;

@interface TRCitiesDataDisplayManager: NSObject <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) id<TRCitiesDataDisplayManagerDelegate> delegate;

- (TRCityModel *)cityAtIndexPath:(NSIndexPath *)indexPath;

- (void)addCities:(NSArray<TRCityModel *> *)cities;
- (void)removeAll;

@end
