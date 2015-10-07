//
//  ViewController.m
//  MacysAssignment
//
//  Created by Xin Sun on 10/6/15.
//  Copyright © 2015 Xin Sun. All rights reserved.
//

#import "ViewController.h"
#import "WindowView.h"
#import "IOSRequest.h"
#import "Word.h"
#import "ResultTVC.h"

@interface ViewController () <UITextFieldDelegate>
@property (nonatomic, strong) WindowView *window;

@property (nonatomic, assign) CGFloat fullWidth;
@property (nonatomic, assign) CGFloat fullHeight;

@property (nonatomic, strong) NSMutableArray *dictionary;
@property (nonatomic, strong) NSString *search;
@end

@implementation ViewController

- (NSMutableArray *)dictionary
{
    if (!_dictionary) {
        _dictionary = [[NSMutableArray alloc] init];
    }
    
    return _dictionary;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fullHeight = [[UIScreen mainScreen] bounds].size.height;
    self.fullWidth = [[UIScreen mainScreen] bounds].size.width;
    
    self.window = [[WindowView alloc] initWithFrame:CGRectMake(20, self.fullHeight/3, self.fullWidth-40, 173)];
    self.window.alpha = 0;
    [self.view addSubview: self.window];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    self.window.textField.delegate = self;
    [self.window.submitBtn addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:1 animations:^{
        self.window.alpha = 1;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField.text.length == 0) {
        [self.window showEmptyWarning:YES];
    } else {
        [self.window showEmptyWarning:NO];
        [self retrieveMeaning:textField.text];
    }
    return YES;
}

#pragma mark - Actions
- (void)search:(UIButton *)sender {
    [self.window.textField resignFirstResponder];
    if (self.window.textField.text.length == 0) {
        [self.window showEmptyWarning:YES];
    } else {
        [self.window showEmptyWarning:NO];
        [self retrieveMeaning:self.window.textField.text];
    }
}

- (void)retrieveMeaning:(NSString *)string
{
    // block UI
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"Searching...";
    
    [IOSRequest getMeaningOfAcronym:string onCompletion:^(NSArray *result) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.dictionary removeAllObjects];
        if (result == nil) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Ops!"
                                                                                     message:@"Something wrong with the connection!"
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                                              style:UIAlertActionStyleDefault
                                                            handler:nil];
            [alertController addAction:confirm];
            [self presentViewController:alertController animated:YES completion:nil];
        } else {
            if (result.count == 0) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Ops!"
                                                                                         message:@"No meaning found for this acronyms!"
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *confirm = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                                                  style:UIAlertActionStyleDefault
                                                                handler:nil];
                [alertController addAction:confirm];
                [self presentViewController:alertController animated:YES completion:nil];
                
                self.window.textField.text = @"";
                
                return;
            }
            NSArray *dic = (NSArray *)((NSDictionary *)result[0])[@"lfs"];
            self.search = (NSString *)((NSDictionary *)result[0])[@"sf"];
            for (NSDictionary *tmp in dic) {
                Word *word = [[Word alloc] initWithMeaning:tmp[@"lf"] andStartYear:[tmp[@"since"] integerValue] andFreq:[tmp[@"freq"] integerValue]];
                [self.dictionary addObject:word];
            }
            self.window.textField.text = @"";
            
            [self performSegueWithIdentifier:@"show_meaning_segue" sender:self];
        }
    }];
    
    // when internet problem happens, will dismiss hud after 10s
    [HUD hide:YES afterDelay:10.0f];
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"show_meaning_segue"]) {
        UINavigationController *controller = (UINavigationController *)segue.destinationViewController;
        ResultTVC *root = [controller.viewControllers objectAtIndex:0];// root
        root.dic = self.dictionary;
        root.search = self.search;
    }
}
@end
