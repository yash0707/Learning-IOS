//
//  ViewController.m
//  Try
//
//  Created by Admin on 10/02/19.
//  Copyright © 2019 Personal. All rights reserved.
//

#import "ViewController.h"
#import "ShowDetails.h"
#import "AddItemViewController.h"

@interface ViewController () <UIAlertViewDelegate>
@property (nonatomic) NSMutableArray *items;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewdidload VC");
    self.items = @[@{@"name":@"item1"},@{@"name":@"item2"}].mutableCopy;
    self.navigationItem.title=@"To-Do-List";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewitem:)];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotification:) name:@"notify1" object:nil];
    
}
- (void) receiveNotification:(NSNotification*)notification{
    NSLog(@"In receiveNotification %@",[notification name]);
    NSDictionary *resultDictionary = notification.userInfo;
    
    NSDictionary *itemToPut = @{@"name":resultDictionary[@"item"]};
    NSLog(@"In receiveNotification: %@",itemToPut[@"name"]);
    
    [self.items addObject:itemToPut];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.items.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [[self navigationController]popViewControllerAnimated:YES];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    ShowDetails *showDetail = [[ShowDetails alloc] init];
    showDetail.itemDetail = self.items[indexPath.row][@"name"];
    NSLog(@"inside didSelect %@",self.items[indexPath.row][@"name"]);
    
    showDetail.delegate = self;
    
    [[self navigationController] pushViewController:showDetail animated:YES];
    NSLog(@"crossed push line");
   
    
    
    
//    NSMutableDictionary *item = [self.items[indexPath.row] mutableCopy];
//    BOOL completed = [item[@"completed"] boolValue];
//    NSLog(@"Completed: %d",completed);
//    item[@"completed"] = @(!completed);
//    self.items[indexPath.row] = item;
//
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.accessoryType = ([item[@"completed"] boolValue])?    UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
#pragma mark - ShowDetailsDelegate Methods
- (void)getUpdatedDataFrom:(ShowDetails *)showDetails whereDataIs:(NSString *)data{
    NSLog(@"returned Updated Data is: %@",data);
    
}



#pragma mark - Adding Item
- (void) addNewitem:(UIBarButtonItem *)sender{
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"New To-Do-Item" message:@"Enter the name of new Todo Item" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add Item", nil ];
//    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
//    [alertView show];
    AddItemViewController *addItemViewController = [[AddItemViewController alloc] init];
    [[self navigationController] pushViewController:addItemViewController animated:YES];
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (buttonIndex!= alertView.cancelButtonIndex) {
//        UITextField *itemNameField = [alertView textFieldAtIndex:0];
//        NSString *itemName = itemNameField.text;
//        NSDictionary *itemToPut = @{@"name":itemName};
//        [self.items addObject:itemToPut];
//        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.items.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
//    }
//}

#pragma mark - UITableView Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"sections");
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"Rows");
    return self.items.count;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellId = @"TodoListRow";
    NSLog(@"inside cellForRowAtIndexpath");
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    //    if (cell == nil) {
    //        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    //    }
    NSDictionary *item = _items[indexPath.row];
    cell.textLabel.text = item[@"name"];
    if ([item[@"completed"] boolValue]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}
@end
