//
//  UIView+Shape.m
//  MacysAssignment
//
//  Created by Xin Sun on 10/6/15.
//  Copyright © 2015 Xin Sun. All rights reserved.
//

#import "UIView+Shape.h"

@implementation UIView (Shape)

- (void)makeRoundedCornerWithRadius:(CGFloat)radius
{
    [self.layer setCornerRadius:radius];
    [self.layer setMasksToBounds:YES];
}
@end
