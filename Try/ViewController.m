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
static NSString * const kNSUserDefaultsKey = @"kNSUserDefaultsKey";

@interface ViewController () <UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource, ShowDetailsDelegate, ItemTableViewCellDelegate>

@property (nonatomic) NSMutableArray *items;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewdidload VC");
    _items = [NSMutableArray array];
    //_items[0] = [@{@"item1":@"false"} mutableCopy];
//    _items[1] = [@{@"name" : @"item2"} mutableCopy];
//
    for(int i=0;i<100;i++) {
        NSMutableString *item = [NSMutableString stringWithFormat:@"item %d",i];
        [_items addObject:[@{item:@"false"}mutableCopy]];
           // [_items addObject : [@{@"name":item,@"checked":@(NO) , [NSNUmber numberWSithBool:NO]]} mutableCopy]];
    }
   // _items = [[[NSUserDefaults standardUserDefaults] objectForKey:kNSUserDefaultsKey] mutableCopy] ?: [NSMutableArray array];
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

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    _itemTableView.frame = self.view.bounds;
}

-(void)viewWillDisappear:(BOOL)animated{
   // [[NSUserDefaults standardUserDefaults] setObject:[_items copy] forKey:kNSUserDefaultsKey];
}

-(void) receiveNotification:(NSNotification*)notification{
    NSLog(@"In receiveNotification %@",[notification name]);
    NSDictionary *resultDictionary = notification.userInfo;
    
    //NSDictionary *itemToPut = @{@"name":resultDictionary[@"item"],@"checked":@"false"}.mutableCopy;
    NSDictionary *itemToPut = @{resultDictionary[@"item"]:@"false"}.mutableCopy;
    NSLog(@"In receiveNotification: %@",itemToPut[@"item"]);
    
    [self.items addObject:itemToPut];
   // [self.itemTableView reloadData];
  
    [self.itemTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.items.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [[self navigationController]popViewControllerAnimated:YES];
    
}

#pragma mark - TableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    ShowDetails *showDetail = [[ShowDetails alloc] init];
    showDetail.itemDetail = ((NSDictionary *)self.items[indexPath.row]).allKeys.firstObject;
    NSLog(@"inside didSelect %@",((NSDictionary *)self.items[indexPath.row]).allKeys.firstObject);
//    NSLog(@"indexPathRowIs %ld",(long)indexPath.row);
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
#pragma mark - ItemTableViewCellDelegates Methods

- (void) updateCellSelectedStatus:(ItemTableViewCell *)itemTableViewCell whereStatusIs:(BOOL)selectedStatusToSentBack forItem:(NSString *)data{
    NSLog(@"Delegates-ITVC: updateCellSelected :- %@",_items);
    for(int i=0;i<_items.count;i++){
        NSDictionary *dict = _items[i];
        NSString *currentKey = dict.allKeys.firstObject;
        if ([currentKey isEqualToString:data]) {
            if(selectedStatusToSentBack){
                NSDictionary *newDictionary = @{data:@"true"};
                _items[i] = newDictionary;
            }else{
                NSDictionary *newDictionary = @{data:@"false"};
                _items[i] = newDictionary;
            }
        }
    }
}
#pragma mark - ItemTableViewCellDelegates2 Methods

- (void) updateCellSelectedStatus2:(ItemTableViewCell2 *)itemTableViewCell2 whereStatusIs:(BOOL)selectedStatusToSentBack forItem:(NSString *)data{
    NSLog(@"Delegates-ITVC2: updateCellSelected:- %@",_items);
    for(int i=0;i<_items.count;i++){
        NSDictionary *dict = _items[i];
        NSString *currentKey = dict.allKeys.firstObject;
        if ([currentKey isEqualToString:data]) {
            if(selectedStatusToSentBack){
                NSDictionary *newDictionary = @{data:@"true"};
                _items[i] = newDictionary;
            }else{
                NSDictionary *newDictionary = @{data:@"false"};
                _items[i] = newDictionary;
            }
        }
    }
}
#pragma mark - ShowDetailsDelegate Methods

- (void)getUpdatedDataFrom:(ShowDetails *)showDetails whereDataIs:(NSString *)data atIndex:(long)indexOfElement{
    NSLog(@"returned Updated Data is: %@ and Index is %ld",data,indexOfElement);
    NSDictionary *currentDictionary = _items[indexOfElement];
    NSDictionary *newDictionary = @{data:currentDictionary.allValues.firstObject};
    _items[indexOfElement] = newDictionary;
    //_items[indexOfElement][@"name"] = data;
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
        cell.delegate = self;
        ItemTableViewCellModel *model = [ItemTableViewCellModel new];
        model.titleText = ((NSDictionary *)_items[indexPath.row]).allKeys.firstObject;
        model.isSelected = ((NSDictionary *)_items[indexPath.row]).allValues.firstObject;

        if([((NSDictionary *)self.items[indexPath.row]).allValues.firstObject isEqualToString:@"false"])
        {
            model.isSelected = false;
        }else{
            model.isSelected = true;
        }
       // model.isSelected = _items[indexPath.row][@"checked"];
        [cell updateCellWithModel:model];
        return cell;
    }
    ItemTableViewCell2 *cell2 = (ItemTableViewCell2 *)[tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier2 forIndexPath:indexPath];
    cell2.delegate2 = self;
    ItemTableViewCellModel2 *model = [ItemTableViewCellModel2 new];
    model.titleText = ((NSDictionary *)_items[indexPath.row]).allKeys.firstObject;
    model.isSelected = ((NSDictionary *)_items[indexPath.row]).allValues.firstObject;
    if([((NSDictionary *)self.items[indexPath.row]).allValues.firstObject isEqualToString:@"false"])
    {
        model.isSelected = false;
    }else{
        model.isSelected = true;
    }
    [cell2 updateCellWithModel:model];
    return cell2;
}


@end
