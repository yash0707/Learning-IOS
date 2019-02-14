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
@property (nonatomic)NSMutableArray *doneItems;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewdidload VC");
    _items = [NSMutableArray array];
    _doneItems = [NSMutableArray array];

    for(int i=0;i<5;i++) {
        NSMutableString *item = [NSMutableString stringWithFormat:@"item %d",i];
        [_items addObject:[@{item:@"false"}mutableCopy]];
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
    NSDictionary *itemToPut = @{resultDictionary[@"item"]:@"false"}.mutableCopy;
    NSLog(@"In receiveNotification: %@",itemToPut[@"item"]);
    [self.items addObject:itemToPut];
    [self.itemTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.items.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [[self navigationController]popViewControllerAnimated:YES];
}

#pragma mark - TableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    switch ([indexPath section]) {
        case 0:
            [self didSelectRowAtIndexPathHelperWithArrayAs:_items andIndexPath:indexPath];
            break;
        case 1:
            [self didSelectRowAtIndexPathHelperWithArrayAs:_doneItems andIndexPath:indexPath];
            break;
        default:
            NSLog(@"VC-didSelectRowAtIndexPath: doesn't pick any section");
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    headerView.backgroundColor = section == 0 ? [[UIColor redColor] colorWithAlphaComponent:0.5] : [[UIColor blackColor] colorWithAlphaComponent:0.3];
    UILabel *textLabel = [[UILabel alloc] initWithFrame:headerView.bounds];
    textLabel.text = section == 0 ? @"TODO" : @"DONE";
    [headerView addSubview:textLabel];
    return headerView;
}

#pragma mark - ItemTableViewCellDelegates Methods

- (void) updateCellSelectedStatus:(ItemTableViewCell *)itemTableViewCell whereStatusIs:(BOOL)selectedStatusToSentBack forItem:(NSString *)data{
    NSLog(@"Delegates-ITVC: updateCellSelected :- %@",_items);
    [self updateCellSelectedStatusHelperWhereStatusIs:selectedStatusToSentBack forItem:data];
}

#pragma mark - ItemTableViewCellDelegates2 Methods

- (void) updateCellSelectedStatus2:(ItemTableViewCell2 *)itemTableViewCell2 whereStatusIs:(BOOL)selectedStatusToSentBack forItem:(NSString *)data{
    [self updateCellSelectedStatusHelperWhereStatusIs:selectedStatusToSentBack forItem:data];
    NSLog(@"Delegates-ITVC2: updateCellSelected:- %@",_items);
    
}

#pragma mark - ShowDetailsDelegate Methods

- (void)getUpdatedDataFrom:(ShowDetails *)showDetails whereDataIs:(NSString *)data atIndex:indexPath{
    NSLog(@"returned Updated Data is: %@ and Index is %@",data,indexPath);
    if ([indexPath section] == 0) {
        NSDictionary *currentDictionary = _items[[indexPath row] ];
        NSDictionary *newDictionary = @{data:currentDictionary.allValues.firstObject};
        _items[[indexPath row] ] = newDictionary;
        [self.itemTableView reloadData];
    }
    else{
        NSDictionary *currentDictionary = _doneItems[[indexPath row] ];
        NSDictionary *newDictionary = @{data:currentDictionary.allValues.firstObject};
        _doneItems[[indexPath row] ] = newDictionary;
        [self.itemTableView reloadData];
    }
}

#pragma mark - UITableView Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"sections");
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"Rows");
    if (section == 0) {
        return _items.count;
    }
    return self.doneItems.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSLog(@"indexpath value %@", indexPath);
    switch (indexPath.section) {
        case 0:
            return [self tableView:tableView cellForRowAtIndexPathHelperWithArrayAs:_items andIndexPath:indexPath];
            break;
        case 1:
            return [self tableView:tableView cellForRowAtIndexPathHelperWithArrayAs:_doneItems andIndexPath:indexPath];
            break;
        default:
            return [UITableViewCell new];
            break;
    }
}

#pragma mark - private methods

- (void)didSelectRowAtIndexPathHelperWithArrayAs:(NSMutableArray *)arrayName andIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didSelectHelper: %@",arrayName);
    ShowDetails *showDetail = [[ShowDetails alloc] init];
    showDetail.itemDetail = ((NSDictionary *)arrayName[indexPath.row]).allKeys.firstObject;
    NSLog(@"inside didSelect %@",((NSDictionary *)arrayName[indexPath.row]).allKeys.firstObject);
    showDetail.indexPathOfElement = indexPath;
    showDetail.delegate = self;
    [[self navigationController] pushViewController:showDetail animated:YES];
    NSLog(@"crossed push line");
}

- (nonnull UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPathHelperWithArrayAs:(NSMutableArray *)arrayName andIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row % 2 == 0){
        ItemTableViewCell *cell = (ItemTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
        cell.delegate = self;
        ItemTableViewCellModel *model = [ItemTableViewCellModel new];
        model.titleText = ((NSDictionary *)arrayName[indexPath.row]).allKeys.firstObject;
        model.isSelected = ((NSDictionary *)arrayName[indexPath.row]).allValues.firstObject;
        if([((NSDictionary *)arrayName[indexPath.row]).allValues.firstObject isEqualToString:@"false"])
        {
            model.isSelected = false;
        }else{
            model.isSelected = true;
        }
        [cell updateCellWithModel:model];
        return cell;
    }
    ItemTableViewCell2 *cell2 = (ItemTableViewCell2 *)[tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier2 forIndexPath:indexPath];
    cell2.delegate2 = self;
    ItemTableViewCellModel2 *model2 = [ItemTableViewCellModel2 new];
    model2.titleText = ((NSDictionary *)arrayName[indexPath.row]).allKeys.firstObject;
    model2.isSelected = ((NSDictionary *)arrayName[indexPath.row]).allValues.firstObject;
    if([((NSDictionary *)arrayName[indexPath.row]).allValues.firstObject isEqualToString:@"false"])
    {
        model2.isSelected = false;
    }else{
        model2.isSelected = true;
    }
    [cell2 updateCellWithModel:model2];
    return cell2;
}

- (void) addNewitem:(UIBarButtonItem *)sender{
    AddItemViewController *addItemViewController = [[AddItemViewController alloc] init];
    [[self navigationController] pushViewController:addItemViewController animated:YES];
}

- (void) updateCellSelectedStatusHelperWhereStatusIs:(BOOL)selectedStatus forItem:(NSString *)data{
    NSLog(@"updateCellSelectedHelper: %@",_items);
    if(selectedStatus){
        for(int i=0;i<_items.count;i++){
            NSDictionary *dict = _items[i];
            NSString *currentKey = dict.allKeys.firstObject;
            if ([currentKey isEqualToString:data]) {
                NSDictionary *newDictionary = @{data:@"true"};
                [_items removeObjectAtIndex:i];
                [_doneItems addObject:newDictionary];
                [_itemTableView reloadData];
            }
        }
    }else{
        for(int i=0;i<_doneItems.count;i++){
            NSDictionary *dict = _doneItems[i];
            NSString *currentKey = dict.allKeys.firstObject;
            if ([currentKey isEqualToString:data]) {
                NSDictionary *newDictionary = @{data:@"false"};
                [_items addObject:newDictionary];
                [_doneItems removeObjectAtIndex:i];
                [_itemTableView reloadData];
            }
        }
        
    }
}
@end
