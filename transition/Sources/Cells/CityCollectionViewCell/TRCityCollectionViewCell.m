//
//  TRCityCollectionViewCell.m
//  transition
//
//  Created by Victor Zaikin on 26/05/2018.
//

#import "TRCityCollectionViewCell.h"
#import "TRCityModel.h"

@interface TRCityCollectionViewCell()

#pragma mark - IBOutlets

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *titleLabelBackgroundView;

@end

@implementation TRCityCollectionViewCell

#pragma mark -

+ (CGSize)cellSize {
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;

    return CGSizeMake(screenWidth - 2 * kCellSideOffset, kCellHeight);
}

#pragma mark - Update methods

- (void)updateCellWithModel:(TRCityModel *)model {
    self.titleLabel.text = model.name;
    self.imageView.image = model.image;
}

#pragma mark - UICollectionView methods overload

- (void)awakeFromNib {
    [super awakeFromNib];

    self.titleLabelBackgroundView.backgroundColor = [UIColor clearColor];

    self.layer.masksToBounds = NO;

    [self addBlurUnderTitleLabel];

    CGSize cellSize = [TRCityCollectionViewCell cellSize];
    CGRect bezierBounds = CGRectMake(0, 0, cellSize.width, cellSize.height);

    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:bezierBounds cornerRadius:kCellCornerRadius];

    [self roundCellCornersWithPath:bezierPath.CGPath];
}

- (void)setHighlighted:(BOOL)highlighted {
    if (highlighted) {
        [self zoomDownCell];
    } else {
        [self zoomIdentityCell];
    }
}

- (void)prepareForReuse {
    [super prepareForReuse];

    self.imageView.image = nil;
    self.titleLabel.text = nil;
}

#pragma mark - Configure methods

- (void)addBlurUnderTitleLabel {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];

    visualEffectView.frame = self.titleLabelBackgroundView.bounds;
    visualEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    [self.titleLabelBackgroundView insertSubview:visualEffectView
                                    belowSubview:self.titleLabel];
}

- (void)roundCellCornersWithPath:(CGPathRef)path {
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];

    maskLayer.path = path;

    self.contentView.layer.mask = maskLayer;
    self.contentView.layer.shouldRasterize = YES;
    self.contentView.layer.rasterizationScale = UIScreen.mainScreen.scale;
}

#pragma mark - Zoom

- (void)zoomDownCell {
    [UIView animateWithDuration:kCellAnimationDuration animations:^{
        self.layer.transform = CATransform3DMakeScale(kCellZoomDown, kCellZoomDown, 1.0);
    }];
}

- (void)zoomIdentityCell {
    [UIView animateWithDuration:kCellAnimationDuration animations:^{
        self.layer.transform = CATransform3DIdentity;
    }];
}

#pragma mark - Constants

static CGFloat const kCellCornerRadius = 20.0;

static CGFloat const kCellSideOffset = 16.0;
static CGFloat const kCellHeight = 250;

static NSTimeInterval const kCellAnimationDuration = 0.25;
static CGFloat const kCellZoomDown = 0.95;

@end
