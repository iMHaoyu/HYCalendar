//
//  HYCalendarView.m
//  HYCalendar
//
//  Created by 徐浩宇 on 2018/11/6.
//  Copyright © 2018 徐浩宇. All rights reserved.
//

#import "HYCalendarView.h"
#import "HYCalendarHeader.h"
#import "HYCalendarManager.h"
#import "HYCalendarCell.h"
#import "HYCalendarHeaderModel.h"
#import "HYCalendarCollectionReusableView.h"
#import "UIView+HYCategory.h"
#import "UIColor+HYCategory.h"

@interface HYCalendarView ()<UICollectionViewDelegate,UICollectionViewDataSource>

/** 显示日历item的CollectionView */
@property (nonatomic, strong)  UICollectionView *mainCollection;
/** 日历模型数组 */
@property (nonatomic,strong) NSMutableArray<HYCalendarHeaderModel *>   *dataArray;

@end
@implementation HYCalendarView

- (UICollectionView *)mainCollection {
    if (!_mainCollection) {
        NSInteger width = HY_Iphone6Scale(140);
        NSInteger height = HY_Iphone6Scale(140);
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(width, height);
        flowLayout.headerReferenceSize = CGSizeMake(0, HY_HeaderViewHeight);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        
        UICollectionView *tempView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 20+HY_WeekViewHeight, width * 7, HY_SCREEN_HEIGHT - 20 - HY_WeekViewHeight) collectionViewLayout:flowLayout];
        tempView.backgroundColor = [UIColor whiteColor];
        tempView.delegate = self;
        tempView.dataSource = self;
        tempView.layer.borderWidth = 1;
        tempView.layer.borderColor = [UIColor hy_colorWithHexString:@"f1f2f3"].CGColor;
        [self addSubview: tempView];
        _mainCollection = tempView;

        [_mainCollection registerClass:[HYCalendarCell class] forCellWithReuseIdentifier:NSStringFromClass([HYCalendarCell class])];
        [_mainCollection registerClass:[HYCalendarCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([HYCalendarCollectionReusableView class])];
        
    }
    return _mainCollection;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self mainCollection];
        NSArray *tempArray = @[@{@"date":@"2018-11-9",@"data":@[@"张三家在装修",@"李四家在装修",@"王五家在装修",@"刘九家在装修",]},
                               @{@"date":@"2018-11-10",@"data":@[@"张三家在装修",@"李四家在装修",@"王五家在装修"]},
                               @{@"date":@"2018-11-11",@"data":@[@"张三家在装修",@"王五家在装修",@"刘九家在装修",]},
                               @{@"date":@"2018-11-12",@"data":@[@"诸葛十家在装修",@"夏侯一家在装修",@"邓七家在装修",@"张三家在装修",@"李四家在装修",@"王五家在装修",@"刘九家在装修"]},
                               @{@"date":@"2018-11-20",@"data":@[@"张三家在装修",@"王五家在装修",@"刘九家在装修",]},
                               @{@"date":@"2018-11-22",@"data":@[@"张三家在装修",@"刘九家在装修",]},
                               @{@"date":@"2018-11-25",@"data":@[@"张三家在装修",@"李四家在装修",@"王五家在装修",@"刘九家在装修",]},
                               @{@"date":@"2018-11-29",@"data":@[@"张三家在装修",@"王五家在装修",@"刘九家在装修",]},
                               @{@"date":@"2018-11-30",@"data":@[@"刘九家在装修"]},];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            HYCalendarManager *manager = [[HYCalendarManager alloc]init];
            NSArray *tempDataArray = [manager getCalendarDataSoruceWithLimitMonth:(12 * 20) withArray:tempArray];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.dataArray = [tempDataArray mutableCopy];
                [self addWeakView];
                [self.mainCollection reloadData];
            });
        });
    }
    return self;
}


- (void)addWeakView {
    UIView *weekView = [[UIView alloc]initWithFrame:CGRectMake(0, 20,HY_SCREEN_WIDTH,HY_WeekViewHeight)];
    weekView.backgroundColor = [UIColor hy_colorWithHexString:@"f9f9f9"];
    [self addSubview:weekView];
    
    NSArray *weekArray = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    int i = 0;
    NSInteger width =HY_Iphone6Scale(140);
    for(i = 0; i < 7;i++)
    {
        UILabel *weekLabel = [[UILabel alloc]initWithFrame:CGRectMake(i * width, 0, width,HY_WeekViewHeight)];
        weekLabel.backgroundColor = [UIColor clearColor];
        weekLabel.text = weekArray[i];
        weekLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        weekLabel.textAlignment = NSTextAlignmentRight;
        if(i == 0 || i == 6) {
            weekLabel.textColor = [UIColor hy_colorWithHexString:@"a3a3a3"];
        }else {
            weekLabel.textColor = [UIColor darkGrayColor];
        }
        [weekView addSubview:weekLabel];
    }
}

#pragma mark - ⬅️⬅️⬅️⬅️ Collection Delegate & DataSource ➡️➡️➡️➡️
#pragma mark -
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    HYCalendarHeaderModel *model = self.dataArray[section];
    return model.calendarItemArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HYCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HYCalendarCell class]) forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    HYCalendarCell *tempCell = (HYCalendarCell *)cell;
    HYCalendarHeaderModel *model = self.dataArray[indexPath.section];
    HYCalendarModel *tempModel = model.calendarItemArray[indexPath.row];
    tempCell.model = tempModel;
    if (indexPath.row % 7 == 0 || indexPath.row %7 == 6) {
        tempCell.dayLabel.textColor = [UIColor hy_colorWithHexString:@"999999"];
        tempCell.chinesDayLabel.textColor = [UIColor hy_colorWithHexString:@"cccccc"];
        tempCell.backgroundColor = [UIColor hy_colorWithHexString:@"fcfcfc"];
    }else {
        tempCell.dayLabel.textColor = [UIColor hy_colorWithHexString:@"333333"];
        tempCell.chinesDayLabel.textColor = [UIColor hy_colorWithHexString:@"999999"];
        tempCell.backgroundColor = [UIColor whiteColor];
    }
}

// 添加header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HYCalendarCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([HYCalendarCollectionReusableView class]) forIndexPath:indexPath];

        return headerView;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        HYCalendarCollectionReusableView *headerView = (HYCalendarCollectionReusableView *)view;
        HYCalendarHeaderModel *headerItem = _dataArray[indexPath.section];
        headerView.headerLabel.text = headerItem.headerText;
    }

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HYCalendarHeaderModel *model = self.dataArray[indexPath.section];
    HYCalendarModel *tempModel = model.calendarItemArray[indexPath.row];
    if (tempModel.tempArray.count && self.delegate && [self.delegate respondsToSelector:@selector(calendarItemDidSelectedWithCalendarModel:withCalendarCell:)]) {
        [self.delegate calendarItemDidSelectedWithCalendarModel:tempModel withCalendarCell:(HYCalendarCell *)[collectionView cellForItemAtIndexPath:indexPath]];
    }
}


@end
