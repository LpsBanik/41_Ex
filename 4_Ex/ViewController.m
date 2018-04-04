//
//  ViewController.m
//  4_Ex
//
//  Created by AcerHack on 28.03.18.
//  Copyright © 2018 AcerHack. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, readwrite) NSArray <NSString*> *section;
@property (nonatomic, readwrite) NSArray <NSArray <NSString*>*> *strings;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.section = @[@"Navigation actions", @"Log actions"];
    
    self.strings = @[@[@"Back", @"Push", @"Present modal"], @[@"Log section number", @"Log row number", @"Log table frame", @"Log cell frame"]];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentifier"];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    NSLog(@"view contoller on stack = %ld", [self.navigationController.viewControllers count]);
    NSLog(@"index on stack = %ld", [self.navigationController.viewControllers indexOfObject:self]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.section.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    NSString *sectionName = [self.section objectAtIndex:section];
    
    return sectionName;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.strings[section].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];
   
    cell.textLabel.text = self.strings[indexPath.section][indexPath.row];
    
    
    if (indexPath.section == 0) {
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ((indexPath.section == 0) && (indexPath.row == 0)) {
       
        if (self.presentingViewController) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    if ((indexPath.section == 0) && (indexPath.row == 1)) {
        
        ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if ((indexPath.section == 0) && (indexPath.row == 2)) {
        
        ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
        
        [self.navigationController presentViewController:vc animated:YES completion:nil];
    }
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                NSLog(@"Log section number = %ld", indexPath.section);
                break;
            case 1:
                NSLog(@"Log row number = %ld", indexPath.row);
                break;
            case 2:
                NSLog(@"Log table frame = %@", NSStringFromCGRect(self.tableView.frame));
                break;
            case 3:
                NSLog(@"Log cell frame = %@", NSStringFromCGRect([[self.tableView cellForRowAtIndexPath:indexPath] frame]));
                break;
            default:
                break;
        }
    }
}

@end
