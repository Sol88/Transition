//
// Created by Victor Zaikin on 26/05/2018.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>

@interface TRCityModel : NSObject

@property (nonatomic) NSInteger uid;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *detailInformation;
@property (strong, nonatomic) UIImage *image;

@end
