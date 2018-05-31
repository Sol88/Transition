//
//  TRCitiesDataDisplayManager.m
//  transition
//
//  Created by Victor Zaikin on 26/05/2018.
//

#import "TRCitiesDataDisplayManager.h"
#import "TRCityCollectionViewCell.h"
#import "TRCityModel.h"

@interface TRCitiesDataDisplayManager()

@property (strong, nonatomic) NSMutableArray<TRCityModel *> *cityModels;

@end

@implementation TRCitiesDataDisplayManager

#pragma mark - Inits

- (instancetype)init {
    self = [super init];

    if (self) {
        self.cityModels = [[NSMutableArray alloc] init];
    }

    return self;
}

#pragma mark -

- (TRCityModel *)cityAtIndexPath:(NSIndexPath *)indexPath {
    return self.cityModels[indexPath.item];
}

- (void)addCities:(NSArray<TRCityModel *> *)cities {
    [self.cityModels addObjectsFromArray:cities];
}

- (void)removeAll {
    [self.cityModels removeAllObjects];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.cityModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:kCityCollectionViewCellIndentifier forIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[TRCityCollectionViewCell class]]) {
        [(TRCityCollectionViewCell *)cell updateCellWithModel:self.cityModels[indexPath.item]];
    }
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate dataDisplayManager:self didSelectItemAtIndexPath:indexPath];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [TRCityCollectionViewCell cellSize];
}

#pragma mark - Constants

static NSString * const kCityCollectionViewCellIndentifier = @"TRCityCollectionViewCellID";

@end
