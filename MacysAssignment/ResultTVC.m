//
//  ResultTVC.m
//  MacysAssignment
//
//  Created by Xin Sun on 10/7/15.
//  Copyright © 2015 Xin Sun. All rights reserved.
//

#import "ResultTVC.h"
#import "ResultTVCell.h"
#import "Word.h"
#import "UIColor+SelfDefinedColors.h"

@interface ResultTVC ()
@end


@implementation ResultTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.navigationItem.title = self.search;
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                            style:UIBarButtonItemStylePlain
                                                           target:self
                                                           action:@selector(backPressed:)];
    [btn setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = btn;
}

- (void)backPressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableView Delegate and Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dic.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ResultTVCell *cell = (ResultTVCell *)[tableView dequeueReusableCellWithIdentifier:@"meaning_cell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    Word *word = (Word *)[self.dic objectAtIndex:indexPath.row];
    cell.subTitle.text = [NSString stringWithFormat:@"since: %ld,  freq: %ld", (long)word.year, (long)word.freq];
    [cell.subTitle setTextColor:[UIColor goldColor]];
    cell.title.text = word.meaning;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self calculateHeightForTextPost:indexPath.row];
}

// Calulate the height of the cell based on text input
- (CGFloat)calculateHeightForTextPost:(NSUInteger)row
{
    CGFloat wid = [[UIScreen mainScreen] bounds].size.width - 18;
    // get text
    Word *word = [self.dic objectAtIndex:row];
    NSString *text = word.meaning;
    
    // get font
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0f];
    NSDictionary *attributes = @{NSFontAttributeName: font};
    
    CGSize constraint = CGSizeMake(wid, NSUIntegerMax);
    CGRect rect = [text boundingRectWithSize:constraint
                                     options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                  attributes:attributes
                                     context:nil];
    
    return 48+rect.size.height-21;
}
@end
