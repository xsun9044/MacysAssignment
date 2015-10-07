//
//  WindowView.h
//  MacysAssignment
//
//  Created by Xin Sun on 10/6/15.
//  Copyright © 2015 Xin Sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WindowView : UIView
// UI for window
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, strong) UITextField *textField;

- (void)showEmptyWarning:(BOOL)empty;
@end

