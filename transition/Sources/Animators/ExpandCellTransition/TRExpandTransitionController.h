//
//  TRExpandCellTransitionController.h
//  transition
//
//  Created by Victor Zaikin on 28/05/2018.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TRExpandTransitionController : NSObject <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

@property (nonatomic) CGRect expandingFrame;

@end
