//
//  TRExpandTransitionDriver.m
//  transition
//
//  Created by Victor Zaikin on 28/05/2018.
//

#import "TRExpandTransitionDriver.h"

@interface TRExpandTransitionDriver()

@property (nonatomic) TRExpandTransitionOperation operation;

@property (nonatomic) CGRect expandingFrame;

@property (nonatomic) id<UIViewControllerContextTransitioning> context;

@end

@implementation TRExpandTransitionDriver

#pragma mark - Init methods

typedef void (^AnimationsBlock)(void);
typedef void (^CompletionBlock)(UIViewAnimatingPosition finalPosition);

- (id<UITimingCurveProvider>)timingCurveProvider {
    return [[UISpringTimingParameters alloc] initWithMass:kTransitionTimingCurveMass
                                                stiffness:kTransitionTimingCurveStiffness
                                                  damping:kTransitionTimingCurveDamping
                                          initialVelocity:CGVectorMake(kTransitionTimingInitialVelocity, kTransitionTimingInitialVelocity)];
}

- (instancetype)initWithOperation:(TRExpandTransitionOperation)operation
                          context:(id<UIViewControllerContextTransitioning>)context
                   expandingFrame:(CGRect)expandingFrame {
    self = [super init];

    if (self) {
        self.operation = operation;
        self.context = context;
        self.expandingFrame = expandingFrame;

        [self animateTransitionPreparation];

        self.transitionAnimator = [[UIViewPropertyAnimator alloc] initWithDuration:0.5 timingParameters:[self timingCurveProvider]];

        AnimationsBlock animationsBlock = ^void() {
            [self animateTransition];
        };

        CompletionBlock completionBlock = ^void(UIViewAnimatingPosition finalPosition) {
            BOOL success = ![self.context transitionWasCancelled];

            switch (self.operation) {
                case TRExpandTransitionOperationDismissing: {
                    if (success) {
                        UIView *toView = [self.context viewForKey:UITransitionContextToViewKey];
                        [toView removeFromSuperview];
                    }

                    break;
                }

                case TRExpandTransitionOperationPresenting: {
                    if (!success) {
                        UIView *toView = [self.context viewForKey:UITransitionContextToViewKey];
                        [toView removeFromSuperview];
                    }

                    break;
                }
            }

            [self.context completeTransition:success];
        };

        [self.transitionAnimator addAnimations:animationsBlock];
        [self.transitionAnimator addCompletion:completionBlock];
    }

    return self;
}

- (void)animateTransitionPreparation {
    UIView *containerView = [self.context containerView];

    UIView *fromView = [self.context viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [self.context viewForKey:UITransitionContextToViewKey];

    switch (self.operation) {
        case TRExpandTransitionOperationDismissing: {
            [containerView insertSubview:toView belowSubview:fromView];

            break;
        }

        case TRExpandTransitionOperationPresenting: {
            toView.layer.cornerRadius = kExpandingCellCornerRadius;

            toView.frame = self.expandingFrame;
            toView.backgroundColor = [UIColor clearColor];

            [containerView addSubview:toView];

            break;
        }
    }
}

- (void)animateTransition {
    switch (self.operation) {
        case TRExpandTransitionOperationDismissing: {
            UIView *fromView = [self.context viewForKey:UITransitionContextFromViewKey];

            fromView.layer.cornerRadius = kExpandingCellCornerRadius;
            [fromView setFrame:self.expandingFrame];

            break;
        }

        case TRExpandTransitionOperationPresenting: {
            UIViewController *toViewController = [self.context viewControllerForKey:UITransitionContextToViewControllerKey];
            UIView *toView = [self.context viewForKey:UITransitionContextToViewKey];

            CGRect toViewFinalFrame = [self.context finalFrameForViewController:toViewController];

            [toView setFrame:toViewFinalFrame];
            toView.layer.cornerRadius = 0.0;
            toView.backgroundColor = [UIColor whiteColor];

            break;
        }
    }
}

#pragma mark - Constants

static CGFloat const kExpandingCellCornerRadius = 20.0;

static CGFloat const kTransitionTimingCurveMass = 10.0;
static CGFloat const kTransitionTimingCurveStiffness = 900.0;
static CGFloat const kTransitionTimingCurveDamping = 150.0;
static CGFloat const kTransitionTimingInitialVelocity = 1.0;

@end
