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
#import "ItemTableViewCell.h"
#import "ItemTableViewCell2.h"

static NSString * const kCellReuseIdentifier = @"kCellReuseIdentifier";
static NSString * const kCellReuseIdentifier2 = @"kCellReuseIdentifier2";

@interface ViewController () <UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource, ShowDetailsDelegate>

@property (nonatomic) NSMutableArray *items;
@property (strong, nonatomic) UITableView *itemTableView;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewdidload VC");
    
    _items = [NSMutableArray array];
//    _items[0] = [@{@"name" : @"item1"} mutableCopy];
//    _items[1] = [@{@"name" : @"item2"} mutableCopy];
    
    for(int i=0;i<100;i++) {
        NSMutableString *item = [NSMutableString stringWithFormat:@"item %d",i];
        [_items addObject : [@{@"name":item} mutableCopy]];
    }
    
    self.navigationItem.title=@"To-Do-List";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewitem:)];
    
    _itemTableView = [[UITableView alloc] init];
    _itemTableView.delegate = self;
    _itemTableView.dataSource = self;
    [self.itemTableView registerClass:[ItemTableViewCell class] forCellReuseIdentifier:kCellReuseIdentifier];
    [self.itemTableView registerClass:[ItemTableViewCell2 class] forCellReuseIdentifier:kCellReuseIdentifier2];
    [self.view addSubview:_itemTableView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotification:) name:@"notify1" object:nil];
    
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    _itemTableView.frame = self.view.bounds;
}

- (void) receiveNotification:(NSNotification*)notification{
    NSLog(@"In receiveNotification %@",[notification name]);
    NSDictionary *resultDictionary = notification.userInfo;
    
    NSDictionary *itemToPut = @{@"name":resultDictionary[@"item"]}.mutableCopy;
    NSLog(@"In receiveNotification: %@",itemToPut[@"name"]);
    
    [self.items addObject:itemToPut];
    [self.itemTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.items.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [[self navigationController]popViewControllerAnimated:YES];
    
}

#pragma mark - TableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    ShowDetails *showDetail = [[ShowDetails alloc] init];
    showDetail.itemDetail = self.items[indexPath.row][@"name"];
    NSLog(@"inside didSelect %@",self.items[indexPath.row][@"name"]);
    NSLog(@"indexPathRowIs %ld",(long)indexPath.row);
    showDetail.indexItem = (long)indexPath.row;
    showDetail.delegate = self;
    
    [[self navigationController] pushViewController:showDetail animated:YES];
    NSLog(@"crossed push line");
   
//    NSMutableDictionary *item = [self.items[indexPath.row] mutableCopy];
//    BOOL completed = [item[@"completed"] boolValue];
//    NSLog(@"Completed: %d",completed);
//    item[@"completed"] = @(!completed);
//    self.items[indexPath.row] = item;
//33
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.accessoryType = ([item[@"completed"] boolValue])?    UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - ShowDetailsDelegate Methods

- (void)getUpdatedDataFrom:(ShowDetails *)showDetails whereDataIs:(NSString *)data atIndex:(long)indexOfElement{
    NSLog(@"returned Updated Data is: %@ and Index is %ld",data,indexOfElement);
    _items[indexOfElement][@"name"] = data;
    [self.itemTableView reloadData];
    
}

#pragma mark - Adding Item

- (void) addNewitem:(UIBarButtonItem *)sender{
    AddItemViewController *addItemViewController = [[AddItemViewController alloc] init];
    [[self navigationController] pushViewController:addItemViewController animated:YES];
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
    if(indexPath.row % 2 == 0){
        ItemTableViewCell *cell = (ItemTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
        ItemTableViewCellModel *model = [ItemTableViewCellModel new];
        model.titleText = _items[indexPath.row][@"name"];
        [cell updateCellWithModel:model];
        return cell;
    }
    ItemTableViewCell2 *cell2 = (ItemTableViewCell2 *)[tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier2 forIndexPath:indexPath];
    ItemTableViewCellModel2 *model = [ItemTableViewCellModel2 new];
    model.titleText = _items[indexPath.row][@"name"];
    [cell2 updateCellWithModel:model];
    return cell2;
}

@end
