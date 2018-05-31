//
//  TRExpandTransitionDriver.h
//  transition
//
//  Created by Victor Zaikin on 28/05/2018.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TRExpandTransitionOperation.h"

@interface TRExpandTransitionDriver : NSObject

@property (strong, nonatomic, nullable) UIViewPropertyAnimator *transitionAnimator;

- (instancetype)initWithOperation:(TRExpandTransitionOperation)operation
                          context:(id<UIViewControllerContextTransitioning>)context
                   expandingFrame:(CGRect)expandingFrame;

@end
