//
//  HYCalendarManager.m
//  HYCalendar
//
//  Created by 徐浩宇 on 2018/11/5.
//  Copyright © 2018 徐浩宇. All rights reserved.
//

#import "HYCalendarManager.h"
#import "HYCalendarHeaderModel.h"


@interface HYCalendarManager ()

/** 日历对象 */
@property (nonatomic, strong) NSCalendar *gregorianCalendar;
/** 计算中国农历日期对象 */
@property (nonatomic,strong)  HYChineseCalendarManager *chineseCalendarManager;
/** 当前日期 */
@property (nonatomic,strong)NSDate *todayDate;
/** 日期显示的格式 */
@property (nonatomic,strong)NSDateFormatter *dateFormatter;

@end

@implementation HYCalendarManager

- (instancetype)init {
    self = [super init];
    if (self) {
        // 定义一个遵循某个历法的日历对象 NSGregorianCalendar国际历法
        /*
         identifier 的范围可以是:
         
         NSCalendarIdentifierGregorian         公历
         NSCalendarIdentifierBuddhist          佛教日历
         NSCalendarIdentifierChinese           中国农历
         NSCalendarIdentifierHebrew            希伯来日历
         NSCalendarIdentifierIslamic           伊斯兰日历
         NSCalendarIdentifierIslamicCivil      伊斯兰教日历
         NSCalendarIdentifierJapanese          日本日历
         NSCalendarIdentifierRepublicOfChina   中华民国日历（台湾）
         NSCalendarIdentifierPersian           波斯历
         NSCalendarIdentifierIndian            印度日历
         NSCalendarIdentifierISO8601           ISO8601
         */
        _gregorianCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        _chineseCalendarManager = [[HYChineseCalendarManager alloc]init];
        _todayDate = [NSDate date];
        _dateFormatter = [[NSDateFormatter alloc]init];
    }
    return self;
}

- (NSArray *)getCalendarDataSoruceWithLimitMonth:(NSInteger)limitMonth withArray:(NSArray *)tempArray {
    
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    NSDateComponents *components = [self dateToComponents:_todayDate];
    components.day = 1;
    components.month -= 1;
    
    for(int i = 0;i < limitMonth;i++)
    {
        components.month++;
        HYCalendarHeaderModel *headerItem = [[HYCalendarHeaderModel alloc]init];
        NSDate *date = [self componentsToDate:components];
//        [_dateFormatter setDateFormat: @"yyyy年MM月"];
        [_dateFormatter setDateFormat: @"yyyy-MM"];
        NSString *dateString = [_dateFormatter stringFromDate:date];
        headerItem.headerText = dateString;
        headerItem.calendarItemArray = [self getCalendarItemArrayWithDate:date section:i withArray:tempArray];
        [resultArray addObject:headerItem];
    }
    
    return resultArray;
}

/** 获取到每天的数据存入数组 */
- (NSArray<HYCalendarModel *> *)getCalendarItemArrayWithDate:(NSDate *)date section:(NSInteger)section withArray:(NSArray *)tempArray {
    
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    //date所在月份的t总天数
    NSInteger tatalDay = [self numberOfDaysInCurrentMonth:date];
    //date所在月份的第一天是星期几
    NSInteger firstDay = [self startDayOfWeek:date];
    
    NSDateComponents *components = [self dateToComponents:date];
    // 判断日历有多少列
    /*
     NSCalendar中比较重要的方法和概念
     firstWeekday
     firstWeekday是大家比较容易浑淆的东西。
     大家在使用dateComponents.weekday获取某天对应的星期时，会发现，星期日对应的值为1，星期一对应的值为2，星期二对应的值为3，依次递推，星期六对应的值为7，这与我们平时理解的方式不一样(歪果仁好像一周的开始就是周日，而不是周一)。然后，我们就开始找是不是可以设置这种对应关系。终于，我们在NSCalendar中发现了firstWeekday这个变量，从字面意思上看貌似就是我们寻找的那个东西。可是，设置过firstWeekday后，我们又发现完全没有作用，真是郁闷啊！其实，大家不必郁闷，因为郁闷也没用，iOS中规定的就是周日为1，周一为2，周二为3，周三为4，周四为5，周五为6，周六为7，无法通过某个设置改变这个事实的，只能在使用的时候注意一下这个规则了。那firstWeekday是干什么用的呢？大家设置一下firstWeekday，再获取一下dateComponents.weekOfYear或dateComponents.weekOfMonth，看看返回的数据是否发生了变化。firstWeekday的作用确实是修改当前历法中周的起始位置，但是不能修改周日对应的数值，只能修改一年或一个月中周的数量，以及周的次序。
     
     这里“(firstDay - 1)”是加上前面空白的个数来计算页面所显示的总个数 除以7 来计算行数
     */
    NSInteger tempTotalDay = tatalDay + (firstDay - 1);
    NSInteger line = 0;
    if (tempTotalDay % 7 == 0) {
        line = tempTotalDay/7;
    }else {
        line = tempTotalDay/7+1;
    }
    
    components.day = 0;
    // i：行数 ； j：列数
    for (int i = 0; i < line; i++) {
        for (int j = 0; j < 7; j++) {
            
            //如果是第一行前面的几个空白（意思就是上个月剩余的日期显示在这个月，所以叫空白）
            if (i == 0 && j < firstDay - 1) {
                HYCalendarModel *calendarItem = [[HYCalendarModel alloc]init];
                calendarItem.year = 0;
                calendarItem.month = 0;
                calendarItem.day = 0;
                calendarItem.chineseCalendar = @"";
//                calendarItem.holiday = @"";
                calendarItem.week = -1;
                calendarItem.dateInterval = -1;
                [resultArray addObject:calendarItem];
                continue;
            }
            
            components.day += 1;
            //跳出循环
            if(components.day == tatalDay + 1) {
                i = (int)line;// 结束外层循环
                break;
            }
            
            HYCalendarModel *calendarItem = [[HYCalendarModel alloc]init];
            calendarItem.year = components.year;
            calendarItem.month = components.month;
            calendarItem.day = components.day;
            calendarItem.week = j;

            // 时间戳
            calendarItem.dateInterval = (long)[date timeIntervalSince1970];
            
            if([date compare:_todayDate] == NSOrderedDescending) {
                calendarItem.type = HYCalendarAfterToday;
            }else if ([date compare:_todayDate] == NSOrderedSame) {
                calendarItem.type = HYCalendarToday;
            }else {
                calendarItem.type = HYCalendarBeforeToday;
            }
            
            NSString *tempKey = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)components.year,(long)components.month,(long)components.day];
            //定义谓词对象,谓词对象中包含了过滤条件
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date = %@",tempKey];
            //使用谓词条件过滤数组中的元素,过滤之后返回查询的结果
            NSArray *array = [tempArray filteredArrayUsingPredicate:predicate];
            calendarItem.tempArray = array?array:@[];
            
            [_chineseCalendarManager getChineseCalendarWithDate:[self componentsToDate:components] calendarItem:calendarItem];
            [resultArray addObject:calendarItem];
        }
    }
    return [resultArray copy];
}

/** 当前时间对应的月份中有几天 */
- (NSUInteger)numberOfDaysInCurrentMonth:(NSDate *)date {
    
    /* 返回某个特定时间(date)其对应的小的时间单元(smaller)在大的时间单元(larger)中的范围，比如:
     
        . 要取得2008/11/12在所在月份的日期范围则可以这样调用该方法:
        [calendar rangeOfUnit:NSCalendarUnitDay inUnit: NSCalendarUnitMonth forDate:fDate];
        则返回(1,31)。注: fDate存放了2008/11/12
     
        . 要取得2008/02/20在所在月份的日期范围则可以这样调用该方法:
        [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:fDate];
        则返回(1,29)。注: fDate存放了2008/11/12
     */
    return [_gregorianCalendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
}

/** 确定这个月的第一天是星期几 */
- (NSUInteger)startDayOfWeek:(NSDate *)date {
    
    NSDate *startDate = nil;

     //用于返回日期date(参数)所在的那个日历单元unit(参数)的开始时间(sDate)。其中参数unit指定了日历单元，参数sDate用于返回日历单元的第一天，参数unitSecs用于返回日历单元的长度(以秒为单位)，参数date指定了一个特定的日期。
    BOOL result = [_gregorianCalendar rangeOfUnit:NSCalendarUnitMonth startDate:&startDate interval:NULL forDate:date];
    if(result) {
        /*
            返回某个特定时间(date)其对应的小的时间单元(smaller)在大的时间单元(larger)中的顺序，比如:
         
                . 要取得2008/11/12在当月的第几周则可以这样调用该方法:
                [calendar ordinalityOfUnit:NSWeekOrdinalCalendarUnit inUnit: NSWeekCalendarUnit forDate: someDate];
                注: someDate存放了2008/11/12
         */
        return [_gregorianCalendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:startDate];
    }
    return 0;
}

#pragma mark - ⬅️⬅️⬅️⬅️ NSDate 和 NSDateComponents 转换 ➡️➡️➡️➡️
#pragma mark -
- (NSDateComponents *)dateToComponents:(NSDate *)date {
    
    /*
     NSCalendarUnitEra                 -- 纪元单位。对于 NSGregorianCalendar (公历)来说，只有公元前(BC)和公元(AD)；
     而对于其它历法可能有很多，例如日本和历是以每一代君王统治来做计算。
     NSCalendarUnitYear                -- 年单位。值很大，相当于经历了多少年，未来多少年。
     NSCalendarUnitMonth               -- 月单位。范围为1-12
     NSCalendarUnitDay                 -- 天单位。范围为1-31
     NSCalendarUnitHour                -- 小时单位。范围为0-24
     NSCalendarUnitMinute              -- 分钟单位。范围为0-60
     NSCalendarUnitSecond              -- 秒单位。范围为0-60
     NSCalendarUnitWeekOfMonth / NSCalendarUnitWeekOfYear -- 周单位。范围为1-53
     NSCalendarUnitWeekday             -- 星期单位，每周的7天。范围为1-7
     NSCalendarUnitWeekdayOrdinal      -- 没完全搞清楚
     NSCalendarUnitQuarter             -- 几刻钟，也就是15分钟。范围为1-4
     NSCalendarUnitWeekOfMonth         -- 月包含的周数。最多为6个周
     NSCalendarUnitWeekOfYear          -- 年包含的周数。最多为53个周
     NSCalendarUnitYearForWeekOfYear   -- 没完全搞清楚
     NSCalendarUnitTimeZone            -- 没完全搞清楚
     */
    NSDateComponents *dateComponents = [_gregorianCalendar components:(NSCalendarUnitEra   |
                                                                       NSCalendarUnitYear  |
                                                                       NSCalendarUnitMonth |
                                                                       NSCalendarUnitDay   |
                                                                       NSCalendarUnitHour  |
                                                                       NSCalendarUnitMinute|
                                                                       NSCalendarUnitSecond)
                                                             fromDate:date];
    return dateComponents;
}
- (NSDate *)componentsToDate:(NSDateComponents *)components {
    // 不区分时分秒
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    NSDate *date = [_gregorianCalendar dateFromComponents:components];
    return date;
}
@end






@interface HYChineseCalendarManager ()
/** 日历对象 */
@property (nonatomic,strong)NSCalendar *chineseCalendar;
/** 中国农历月份数组 */
@property (nonatomic,strong)NSArray *chineseMonthArray;
/** 中国农历日 数组 */
@property (nonatomic,strong)NSArray *chineseDayArray;
@end
@implementation HYChineseCalendarManager

- (instancetype)init
{
    self = [super init];
    if(self) {
        _chineseCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierChinese];
        _chineseMonthArray = @[@"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",@"九月", @"十月", @"冬月", @"腊月"];
        _chineseDayArray = @[@"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",@"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",@"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十"];
    }
    return self;
}

- (void)getChineseCalendarWithDate:(NSDate *)date calendarItem:(HYCalendarModel *)calendarItem {
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents *localeComp = [_chineseCalendar components:unitFlags fromDate:date];
    NSInteger tempDay = localeComp.day;
    // 系统日历类在2057-09-28计算有bug结果为0（应该为30）
    if(tempDay == 0) {
        tempDay = 30;
    }
    NSString *chineseMonth = [_chineseMonthArray objectAtIndex:localeComp.month - 1];
    NSString *chineseDay = [_chineseDayArray objectAtIndex:tempDay - 1];
    
    calendarItem.chineseCalendar = (tempDay - 1 != 0)?chineseDay:chineseMonth;
    calendarItem.isWholeMonth    = (tempDay - 1 != 0)?NO:YES;
}

@end
