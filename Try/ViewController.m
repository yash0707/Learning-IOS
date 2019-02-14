//
//  ViewController.m
//  Try
//
//  Created by Admin on 10/02/19.
//  Copyright © 2019 Personal. All rights reserved.
//

#import "ViewController.h"
#import "ShowDetailsViewController.h"
#import "AddItemViewController.h"
#import "ButtonRightAlignedItemTableViewCell.h"
#import "ButtonLeftAlignedItemTableViewCell.h"
static NSString * const kCellReuseIdentifier = @"kCellReuseIdentifier";
static NSString * const kCellReuseIdentifier2 = @"kCellReuseIdentifier2";
static NSString * const kNSUserDefaultsKey = @"kNSUserDefaultsKey";

@interface ViewController () <UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource, ShowDetailsDelegate, ItemTableViewCellProtocol>

@property (nonatomic) NSMutableArray *items;
@property (nonatomic)NSMutableArray *doneItems;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewdidload VC");
    _items = [NSMutableArray array];
    _doneItems = [NSMutableArray array];

    for(int i=0;i<100;i++) {
        NSMutableString *item = [NSMutableString stringWithFormat:@"item %d",i];
        [_items addObject:[@{item:@"false"}mutableCopy]];
    }
    
   // _items = [[[NSUserDefaults standardUserDefaults] objectForKey:kNSUserDefaultsKey] mutableCopy] ?: [NSMutableArray array];
    self.navigationItem.title=@"To-Do-List";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewitem:)];
    
    _itemTableView = [[UITableView alloc] init];
    _itemTableView.delegate = self;
    _itemTableView.dataSource = self;
    [self.itemTableView registerClass:[ButtonLeftAlignedItemTableViewCell class] forCellReuseIdentifier:kCellReuseIdentifier];
    [self.itemTableView registerClass:[ButtonRightAlignedItemTableViewCell class] forCellReuseIdentifier:kCellReuseIdentifier2];
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    headerView.backgroundColor = section == 0 ? [[UIColor redColor] colorWithAlphaComponent:0.5] : [[UIColor blackColor] colorWithAlphaComponent:0.3];
    UILabel *textLabel = [[UILabel alloc] initWithFrame:headerView.bounds];
    textLabel.text = section == 0 ? @"TODO" : @"DONE";
    [headerView addSubview:textLabel];
    return headerView;
}

#pragma mark - ItemTableViewCellProtocol Method

- (void) updateCellSelectedStatusWhereStatusIs:(BOOL)selectedStatusToSentBack forItem:(NSString *)data{
    NSLog(@"updateCellSelectedHelper: %@",_items);
    if(selectedStatusToSentBack){
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

#pragma mark - ShowDetailsDelegate Methods

- (void)getUpdatedDataFrom:(ShowDetailsViewController *)showDetails whereDataIs:(NSString *)data atIndex:indexPath{
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
    ShowDetailsViewController *showDetail = [[ShowDetailsViewController alloc] init];
    showDetail.itemDetail = ((NSDictionary *)arrayName[indexPath.row]).allKeys.firstObject;
    NSLog(@"inside didSelect %@",((NSDictionary *)arrayName[indexPath.row]).allKeys.firstObject);
    showDetail.indexPathOfElement = indexPath;
    showDetail.delegate = self;
    [[self navigationController] pushViewController:showDetail animated:YES];
    NSLog(@"crossed push line");
}

- (nonnull UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPathHelperWithArrayAs:(NSMutableArray *)arrayName andIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row % 2 == 0){
        ButtonLeftAlignedItemTableViewCell *cellLeftAligned = (ButtonLeftAlignedItemTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
        cellLeftAligned.buttonLeftAlignedDelegate = self;
        ItemCellDataModel *buttonLeftAlignedModel = [ItemCellDataModel new];
        buttonLeftAlignedModel.titleText = ((NSDictionary *)arrayName[indexPath.row]).allKeys.firstObject;
        buttonLeftAlignedModel.isSelected = ((NSDictionary *)arrayName[indexPath.row]).allValues.firstObject;
        if([((NSDictionary *)arrayName[indexPath.row]).allValues.firstObject isEqualToString:@"false"])
        {
            buttonLeftAlignedModel.isSelected = false;
        }else{
            buttonLeftAlignedModel.isSelected = true;
        }
        [cellLeftAligned updateCellWithModel:buttonLeftAlignedModel];
        return cellLeftAligned;
    }
    
    ButtonRightAlignedItemTableViewCell *cellRightAligned = (ButtonRightAlignedItemTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier2 forIndexPath:indexPath];
    cellRightAligned.buttonRightAlignedDelegate = self;
    ItemCellDataModel *buttonRightAlignedModel = [ItemCellDataModel new];
    buttonRightAlignedModel.titleText = ((NSDictionary *)arrayName[indexPath.row]).allKeys.firstObject;
    buttonRightAlignedModel.isSelected = ((NSDictionary *)arrayName[indexPath.row]).allValues.firstObject;
    if([((NSDictionary *)arrayName[indexPath.row]).allValues.firstObject isEqualToString:@"false"])
    {
        buttonRightAlignedModel.isSelected = false;
    }else{
        buttonRightAlignedModel.isSelected = true;
    }
    [cellRightAligned updateCellWithModel:buttonRightAlignedModel];
    return cellRightAligned;
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

- (void) addNewitem:(UIBarButtonItem *)sender{
    AddItemViewController *addItemViewController = [[AddItemViewController alloc] init];
    [[self navigationController] pushViewController:addItemViewController animated:YES];
}


@end
