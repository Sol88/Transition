//
//  TRCityDetailViewController.m
//  transition
//
//  Created by Victor Zaikin on 27/05/2018.
//

#import "TRCityDetailViewController.h"
#import "TRCityModel.h"
#import "TRCityCollectionViewCell.h"

@interface TRCityDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UIView *cityNameBackgroundView;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightContraint;

@end

@implementation TRCityDetailViewController

#pragma mark - CityNameBackgroundView frames

- (CGRect)startCityNameBackgroundViewFrame {
    return CGRectMake(0,
                      TRCityCollectionViewCell.cellSize.height - self.cityNameBackgroundView.frame.size.height,
                      TRCityCollectionViewCell.cellSize.width,
                      self.cityNameBackgroundView.frame.size.height);
}

- (CGRect)finalCityNameBackgroundViewFrame {
    CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;

    return CGRectMake(0,
                      kImageViewHeight - self.cityNameBackgroundView.frame.size.height,
                      screenWidth,
                      kCityNameBackgroundViewHeight);
}

#pragma mark - ImageView frames

- (CGRect)startImageViewFrame {
    return CGRectMake(0, 0, TRCityCollectionViewCell.cellSize.width, TRCityCollectionViewCell.cellSize.height);
}

- (CGRect)finalImageViewFrame {
    CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;

    return CGRectMake(0, 0, screenWidth, kImageViewHeight);
}

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setup];

    [self fetchCity];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    CGFloat screenWidth = UIScreen.mainScreen.bounds.size.width;

    CGRect finalTextViewFrame = self.textView.frame;
    finalTextViewFrame.size.width = screenWidth - kTextViewLeftPadding - kTextViewRightPadding;

    self.imageView.frame = [self startImageViewFrame];
    self.textView.frame = self.imageView.frame;
    self.cityNameBackgroundView.frame = [self startCityNameBackgroundViewFrame];

    __weak typeof(self) weakSelf = self;

    void (^animation)(id<UIViewControllerTransitionCoordinatorContext> context) = ^void(id<UIViewControllerTransitionCoordinatorContext> context) {
        [weakSelf alongsideTransitionSetImageViewFrame:[weakSelf finalImageViewFrame]
                                         textViewFrame:finalTextViewFrame
                                         cityNameFrame:[weakSelf finalCityNameBackgroundViewFrame]];
    };

    [self.transitionCoordinator animateAlongsideTransitionInView:self.view animation:animation completion:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self.closeButton setHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.closeButton setHidden:YES];

    [self.imageViewHeightContraint setActive:NO];

    __weak typeof(self) weakSelf = self;

    void (^animation)(id<UIViewControllerTransitionCoordinatorContext> context) = ^void(id<UIViewControllerTransitionCoordinatorContext> context) {
        [weakSelf alongsideTransitionSetImageViewFrame:[weakSelf startImageViewFrame]
                                         textViewFrame:weakSelf.imageView.frame
                                         cityNameFrame:[weakSelf startCityNameBackgroundViewFrame]];
    };

    [self.transitionCoordinator animateAlongsideTransitionInView:self.view animation:animation completion:nil];
}

#pragma mark - Setup methods

- (void)setup {
    [self setupTextView];
    [self setupBlurEffect];
    [self setupCloseButton];
}

- (void)setupCityModel: (TRCityModel *)cityModel {
    self.cityNameLabel.text = cityModel.name;
    self.imageView.image = cityModel.image;
    self.textView.text = cityModel.detailInformation;
}

- (void)setupTextView {
    self.textView.contentInset = UIEdgeInsetsZero;
}

- (void)setupCloseButton {
    self.closeButton.layer.cornerRadius = self.closeButton.bounds.size.width * 0.5;
}

- (void)setupBlurEffect {
    self.cityNameBackgroundView.backgroundColor = [UIColor clearColor];

    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];

    effectView.frame = self.cityNameBackgroundView.bounds;
    effectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    [self.cityNameBackgroundView insertSubview:effectView belowSubview:self.cityNameLabel];
}

#pragma mark - Retrieving methods

- (void)fetchCity {
    __weak typeof(self) weakSelf = self;

    [self.citiesService fetchCityWithId:self.cityId completion:^(TRCityModel *city) {
        [weakSelf setupCityModel:city];
    }];
}

#pragma mark - Alongside animations

- (void)alongsideTransitionSetImageViewFrame:(CGRect)imageViewFrame
                               textViewFrame:(CGRect)textViewFrame
                               cityNameFrame:(CGRect)cityNameFrame {
    self.imageView.frame = imageViewFrame;
    self.textView.frame = textViewFrame;
    self.cityNameBackgroundView.frame = cityNameFrame;
}

#pragma mark - IBActions

- (IBAction)closeButtonDidTap:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Constants

static CGFloat const kTextViewLeftPadding = 20.0;
static CGFloat const kTextViewRightPadding = 20.0;

static CGFloat const kImageViewHeight = 300.0;

static CGFloat const kCityNameBackgroundViewHeight = 40.0;

@end
