//
//  ViewController.m
//  Try
//
//  Created by Admin on 10/02/19.
//  Copyright © 2019 Personal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIAlertViewDelegate>
@property (nonatomic) NSMutableArray *items;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.items = @[@{@"name":@"item1"},@{@"name":@"item2"}].mutableCopy;
    self.navigationItem.title=@"To-Do-List";
    NSLog(@"viewdidload");
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewitem:)];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSMutableDictionary *item = [self.items[indexPath.row] mutableCopy];
    BOOL completed = [item[@"completed"] boolValue];
    NSLog(@"Completed: %d",completed);
    item[@"completed"] = @(!completed);
    self.items[indexPath.row] = item;
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = ([item[@"completed"] boolValue])? UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Adding Item
- (void) addNewitem:(UIBarButtonItem *)sender{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"New To-Do-Item" message:@"Enter the name of new Todo Item" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add Item", nil ];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex!= alertView.cancelButtonIndex) {
        UITextField *itemNameField = [alertView textFieldAtIndex:0];
        NSString *itemName = itemNameField.text;
        NSDictionary *itemToPut = @{@"name":itemName};
        [self.items addObject:itemToPut];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.items.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

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
