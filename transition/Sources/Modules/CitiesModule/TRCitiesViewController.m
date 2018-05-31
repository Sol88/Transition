//
//  TRCitiesViewController.m
//  transition
//
//  Created by Victor Zaikin on 26/05/2018.
//

#import "TRCitiesViewController.h"
#import "TRCitiesDataDisplayManager.h"
#import "TRCityDetailViewController.h"
#import "TRCityModel.h"
#import "TRCityCollectionViewCell.h"
#import "TRExpandTransitionController.h"
#import "TRCityDetailViewControllerConfigurator.h"

@interface TRCitiesViewController () <TRCitiesDataDisplayManagerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic, nullable) NSIndexPath *selectedIndexPath;

@end

@implementation TRCitiesViewController

#pragma mark - UIViewController life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setup];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    __weak typeof(self) weakSelf = self;

    void (^animation)(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) = ^void(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [weakSelf.collectionView setScrollEnabled:NO];
    };

    void (^completion)(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) = ^void(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        UICollectionViewCell *cell = [weakSelf.collectionView cellForItemAtIndexPath:weakSelf.selectedIndexPath];

        [cell setHidden:NO];

        [weakSelf.collectionView setScrollEnabled:YES];
    };

    [self.transitionCoordinator animateAlongsideTransitionInView:self.view animation:animation completion:completion];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    __weak typeof(self) weakSelf = self;

    void (^animation)(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) = ^void(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        UICollectionViewCell *cell = [weakSelf.collectionView cellForItemAtIndexPath:weakSelf.selectedIndexPath];

        [cell setHidden:YES];
    };

    [self.transitionCoordinator animateAlongsideTransitionInView:self.view animation:animation completion:nil];
}

#pragma mark - Setup methods

- (void)setup {
    [self setupCollectionView];

    [self fetchCities];
}

- (void)setupCollectionView {
    self.citiesDataDisplayManager.delegate = self;

    self.collectionView.delegate = self.citiesDataDisplayManager;
    self.collectionView.dataSource = self.citiesDataDisplayManager;

    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.contentInset = UIEdgeInsetsMake(kCollectionViewContentTopInset,
                                                        kCollectionViewContentLeftInset,
                                                        kCollectionViewContentBottomInset,
                                                        kCollectionViewContentRightInset);
}

#pragma mark - Retrieving methods

- (void)fetchCities {
    __weak typeof(self) weakSelf = self;

    [self.citiesService fetchCitiesWithCompletion:^(NSArray<TRCityModel *> *cities) {
        [weakSelf.citiesDataDisplayManager removeAll];
        [weakSelf.citiesDataDisplayManager addCities:cities];

        [weakSelf.collectionView reloadData];

    }];
}

#pragma mark - TRCitiesDataDisplayManagerDelegate

- (void)dataDisplayManager:(TRCitiesDataDisplayManager *)dataDisplayManager didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TRCityModel *cityModel = [dataDisplayManager cityAtIndexPath:indexPath];

    [self openCityDetailViewControllerWithCityModel:cityModel fromIndexPath:indexPath];
}

#pragma mark - Navigation

- (void)openCityDetailViewControllerWithCityModel:(TRCityModel *)model fromIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndexPath = indexPath;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    TRCityDetailViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"TRCityDetailViewControllerID"];

    [[[TRCityDetailViewControllerConfigurator alloc] init] configureViewController:viewController
                                                                        withCityId:model.uid
                                                        expandTransitionController:self.expandTransitionController
                                                                     citiesService:self.citiesService];

    UICollectionViewLayoutAttributes *attributes = [self.collectionView layoutAttributesForItemAtIndexPath:indexPath];
    CGRect expandingFrame = [self.collectionView convertRect:attributes.frame toView:self.view];

    self.expandTransitionController.expandingFrame = expandingFrame;

    [self presentViewController:viewController animated:YES completion:nil];
}

#pragma mark - Constants

static CGFloat const kCollectionViewContentTopInset = 16.0;
static CGFloat const kCollectionViewContentBottomInset = 16.0;
static CGFloat const kCollectionViewContentLeftInset = 0.0;
static CGFloat const kCollectionViewContentRightInset = 0.0;

@end
