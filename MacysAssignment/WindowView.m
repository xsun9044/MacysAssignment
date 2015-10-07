//
//  WindowView.m
//  MacysAssignment
//
//  Created by Xin Sun on 10/6/15.
//  Copyright © 2015 Xin Sun. All rights reserved.
//

#import "WindowView.h"
#import "UIColor+SelfDefinedColors.h"
#import "UIView+Shape.h"

@interface WindowView ()
@property (nonatomic, strong) UILabel *warning;
@end

@implementation WindowView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self setBackgroundColor:[UIColor darkColor]];
    [self makeRoundedCornerWithRadius:7.0f];
    
    // title label
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(22, 20, frame.size.width-44, 21)];
    [title setText:@"Enter Acronyms/Initialisms"];
    [title setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size: 13.0f]];
    [title setTextColor:[UIColor goldColor]];
    [title setTextAlignment:NSTextAlignmentLeft];
    [self addSubview:title];
    
    // text field
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(22, title.frame.origin.y+title.frame.size.height+10, frame.size.width-44, 30)];
    [self.textField setBorderStyle:UITextBorderStyleNone];
    [self.textField.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.textField.layer setBorderWidth:1.0f];
    [self.textField makeRoundedCornerWithRadius:5.0f];
    [self.textField setBackgroundColor:[UIColor whiteColor]];
    [self.textField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self.textField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [self addSubview:self.textField];
    
    // warning
    self.warning = [[UILabel alloc] initWithFrame:CGRectMake(22, self.textField.frame.origin.y+self.textField.frame.size.height+10, frame.size.width-44, 21)];
    [self.warning setTextColor:[UIColor redColor]];
    [self.warning setText:@"Acronyms/Initialisms cannot be empty"];
    [self.warning setFont:[UIFont fontWithName:@"HelveticaNeue" size:11.0f]];
    [self.warning setHidden:YES];
    [self addSubview:self.warning];
    
    // btn view
    UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-45, frame.size.width, 45)];
    [btnView setBackgroundColor:[UIColor goldColor]];
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 29, 26)];
    icon.image = [[UIImage imageNamed:@"up"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [icon setTintColor:[UIColor whiteColor]];
    [icon setCenter:CGPointMake(frame.size.width/2-((29+54)/2 - 29/2), 45/2+2)];
    [btnView addSubview:icon];
    UILabel *btnTitle = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/2-(29+54)/2+29+5, 45/2-26/2, frame.size.width/2+(29+54)/2-29-5, 26)];
    [btnTitle setText:@"Search"];
    [btnTitle setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size: 17.0f]];
    [btnTitle setTextColor:[UIColor whiteColor]];
    [btnTitle setTextAlignment:NSTextAlignmentLeft];
    [btnView addSubview:btnTitle];
    self.submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, btnView.frame.size.width, btnView.frame.size.height)];
    [btnView addSubview:self.submitBtn];
    [self addSubview:btnView];
    
    return self;
}

- (void)showEmptyWarning:(BOOL)empty
{
    if (empty) {
        [self.warning setHidden:NO];
        [self.textField.layer setBorderColor:[[UIColor redColor] CGColor]];
    } else {
        [self.warning setHidden:YES];
        [self.textField.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    }
}

@end
