//
//  TableVC.m
//  TeaseYou
//
//  Created by Jane on 2017/3/29.
//  Copyright © 2017年 Jane. All rights reserved.
//

#import "TableVC.h"
#import "Tease.h"

#define kTeaseH 260
#define kPickH 150

@interface TableVC ()<UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDataSource,UITableViewDelegate>
{
    UIPickerView *myPickView;
    NSMutableArray *dataList;
}
/** 挑逗视图 */
@property(nonatomic, strong) UIView *teaseView;

/** 是否为男生 */
@property (nonatomic, assign) BOOL isMan;

@property(nonatomic, strong) Tease *myTease;

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation TableVC

#pragma mark ---cxcxc
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.teaseView];
    _isMan =YES;
    if (_isMan) {
        dataList = [NSMutableArray arrayWithObjects:@"你好,你喜欢电影吗?",@"你好,平时会去夜店吗?",@"我们距离很近,一起喝杯咖啡好吗?",@"看到你,若不和你打招呼,我会后悔一辈子.",@"你的头像让我心跳加速,可以聊聊吗?",@"我有六块腹肌哎,要不要看?",@"你好,我饿了,有没有东西给我吃?",@"你好,你在附近读书吗?", nil];
        
    }else{
        dataList = [NSMutableArray arrayWithObjects:@"你好,你喜欢电影吗?",@"我们距离很近,一起喝杯咖啡好吗?",@"看到你,若不和你打招呼,我会后悔一辈子.",@"你的头像让我心跳加速,可以聊聊吗?",@"我是身材超好的九头身美女,要看看面具下的我吗?",@"你好,我饿了,有没有东西给我吃?",@"你好,你在附近读书吗?", nil];
    }
    myPickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.teaseView.frame)-kPickH, CGRectGetWidth(self.teaseView.frame), kPickH)];
    myPickView.delegate = self;
    myPickView.dataSource = self;
    
    //在当前选择上显示一个透明窗口
    myPickView.showsSelectionIndicator = YES;
    [myPickView selectRow:[dataList count] inComponent:0 animated:YES];
    [self.teaseView addSubview:self.tableView];
    [self.teaseView addSubview:myPickView];
    self.tableView.frame = CGRectMake(20,90, CGRectGetWidth(_teaseView.frame)-40,90);
    [self changeSpearatorLineColor];
}
- (void)changeSpearatorLineColor
{
    for(UIView *speartorView in myPickView.subviews)
    {
        if (speartorView.frame.size.height < 1)//取出分割线view
        {
            speartorView.layer.backgroundColor = [UIColor redColor].CGColor;//隐藏分割线
        }
    }
}
#pragma mark --- UITableViewDataSource,UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        self.myTease = [[Tease alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 70)];
        [cell.contentView addSubview:self.myTease];
    }
    cell.contentView.transform = CGAffineTransformMakeRotation(M_PI_2);
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70+18;
}


#pragma mark pickview delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [dataList count]*50;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [dataList objectAtIndex:(row%[dataList count])];
}

//选中picker cell,save ArrayIndex
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSUInteger max = 0;
    NSUInteger base10 = 0;
    if(component == 0)
    {
        max = [dataList count]*50;
        base10 = (max/2)-(max/2)%[dataList count];
        [pickerView selectRow:[pickerView selectedRowInComponent:component]%[dataList count]+base10 inComponent:component animated:false];
    }
    //    NSLog(@"%@",dataList[row]);
}

//替换text居中
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12.0f, 0.0f, [pickerView rowSizeForComponent:component].width-12, [pickerView rowSizeForComponent:component].height)];
    label.textColor = [UIColor orangeColor];
    label.text = [dataList objectAtIndex:(row%[dataList count])];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}
#pragma mark --- get and set

-(UIView *)teaseView{
    if (nil == _teaseView) {
        _teaseView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - kTeaseH, [UIScreen mainScreen].bounds.size.width,kTeaseH)];
        _teaseView.backgroundColor = [UIColor clearColor];
    }
    return _teaseView;
}


-(UITableView *)tableView{
    if (nil == _tableView) {
        UITableView *myTableView = [[UITableView alloc] init];
        [myTableView.layer setAnchorPoint:CGPointMake(0.0, 0.0)];
        myTableView.transform = CGAffineTransformMakeRotation(-M_PI_2);
        myTableView.dataSource = self;
        myTableView.delegate  = self;
        myTableView.scrollEnabled = YES;
        myTableView.userInteractionEnabled = YES;
        myTableView.showsVerticalScrollIndicator = NO;
        myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView = myTableView;
    }
    return _tableView;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
