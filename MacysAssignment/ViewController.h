//
//  ViewController.h
//  MacysAssignment
//
//  Created by Xin Sun on 10/6/15.
//  Copyright © 2015 Xin Sun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface ViewController : UIViewController<MBProgressHUDDelegate> {
    MBProgressHUD *HUD;
}

@end

