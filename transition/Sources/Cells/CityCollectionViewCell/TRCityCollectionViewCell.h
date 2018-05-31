//
//  TRCityCollectionViewCell.h
//  transition
//
//  Created by Victor Zaikin on 26/05/2018.
//

#import <UIKit/UIKit.h>

@class TRCityModel;

@interface TRCityCollectionViewCell : UICollectionViewCell

+ (CGSize)cellSize;

- (void)updateCellWithModel:(TRCityModel *)model;

@end
