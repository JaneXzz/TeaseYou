//
//  TeaseView.m
//  TeaseYou
//
//  Created by Jane on 2017/3/29.
//  Copyright © 2017年 Jane. All rights reserved.
//

#import "TeaseView.h"
#import "TeaseCell.h"

#define kTeaseH 260
#define kPickH 180
#define kMyCollectionViewCellID @"cell"

@interface TeaseView ()<UIPickerViewDelegate,UIPickerViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSMutableArray *dataList;
    UIPickerView *_pickView;
    
}
/** 挑逗视图 */
@property(nonatomic, strong) UIView *teaseView;

/** 是否为男生 */
@property (nonatomic, assign) BOOL isMan;


@property(nonatomic, strong) UICollectionView *collectionView;
@end

@implementation TeaseView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.teaseView];
        [self.teaseView addSubview:self.collectionView];
        [self creatView];
    }
    return self;
}

-(void)creatView{
    [self.collectionView registerNib:[TeaseCell nib] forCellWithReuseIdentifier:[TeaseCell cellReuseIdentifier]];
    _isMan =YES;
    if (_isMan) {
        dataList = [NSMutableArray arrayWithObjects:@"你好,你喜欢电影吗?",@"你好,平时会去夜店吗?",@"我们距离很近,一起喝杯咖啡好吗?",@"看到你,若不和你打招呼,我会后悔一辈子.",@"你的头像让我心跳加速,可以聊聊吗?",@"我有六块腹肌哎,要不要看?",@"你好,我饿了,有没有东西给我吃?",@"你好,你在附近读书吗?", nil];
        
    }else{
        dataList = [NSMutableArray arrayWithObjects:@"你好,你喜欢电影吗?",@"我们距离很近,一起喝杯咖啡好吗?",@"看到你,若不和你打招呼,我会后悔一辈子.",@"你的头像让我心跳加速,可以聊聊吗?",@"我是身材超好的九头身美女,要看看面具下的我吗?",@"你好,我饿了,有没有东西给我吃?",@"你好,你在附近读书吗?", nil];
    }
    _pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.teaseView.frame)-kPickH, CGRectGetWidth(self.teaseView.frame), kPickH)];
    _pickView.delegate = self;
    _pickView.dataSource = self;
    _pickView.backgroundColor = [UIColor orangeColor];
    //在当前选择上显示一个透明窗口
    _pickView.showsSelectionIndicator = YES;
    [_pickView selectRow:[dataList count] inComponent:0 animated:YES];
    
    [self.teaseView addSubview:_pickView];
}

#pragma mark --
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TeaseCell * cell =[collectionView dequeueReusableCellWithReuseIdentifier:[TeaseCell cellReuseIdentifier] forIndexPath:indexPath];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@" indext = %ld",(long)indexPath.row);
    
    
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
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12.0f, 0.0f, [pickerView rowSizeForComponent:component].width-12, [pickerView rowSizeForComponent:component].height)];
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:15];
    label.text = [dataList objectAtIndex:(row%[dataList count])];
    label.textAlignment = NSTextAlignmentCenter;
    [self changeSpearatorLineColor];
    return label;
}

- (void)changeSpearatorLineColor
{
    for(UIView *speartorView in _pickView.subviews)
    {
        if (speartorView.frame.size.height < 1)//取出分割线view
        {
            speartorView.layer.backgroundColor = [UIColor clearColor].CGColor;//隐藏分割线
        }
    }
}
#pragma mark  --- set and get

-(UIView *)teaseView{
    if (nil == _teaseView) {
        _teaseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _teaseView.backgroundColor = [UIColor cyanColor];
    }
    return _teaseView;
}
-(UICollectionView *)collectionView{
    if (nil == _collectionView) {
        UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 80) collectionViewLayout:fl];
        fl.itemSize = CGSizeMake(70, 70);
        fl.minimumLineSpacing = 18;
        fl.sectionInset = UIEdgeInsetsMake(6, 41/2, 6, 41/2);
        fl.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor redColor];
        _collectionView.scrollsToTop = YES;
        _collectionView.showsVerticalScrollIndicator = YES;
        _collectionView.showsHorizontalScrollIndicator = YES;
        
    }
    return _collectionView;
}


@end
