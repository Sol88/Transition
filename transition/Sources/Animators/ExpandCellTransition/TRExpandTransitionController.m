//
//  TRExpandCellTransitionController.m
//  transition
//
//  Created by Victor Zaikin on 28/05/2018.
//

#import "TRExpandTransitionController.h"
#import "TRExpandTransitionDriver.h"
#import "TRExpandTransitionOperation.h"

@interface TRExpandTransitionController()

@property (strong, nonatomic, nullable) TRExpandTransitionDriver *transitionDriver;

@property (nonatomic) TRExpandTransitionOperation operation;

@end

@implementation TRExpandTransitionController

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.operation = TRExpandTransitionOperationPresenting;

    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.operation = TRExpandTransitionOperationDismissing;

    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    self.transitionDriver = [[TRExpandTransitionDriver alloc] initWithOperation:self.operation
                                                                        context:transitionContext
                                                                 expandingFrame:self.expandingFrame];

    [self.transitionDriver.transitionAnimator startAnimation];
}


- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return self.transitionDriver.transitionAnimator.duration;
}

@end
