//
//  HYCalendarHeader.h
//  HYCalendar
//
//  Created by 徐浩宇 on 2018/11/5.
//  Copyright © 2018 徐浩宇. All rights reserved.
//

#ifndef HYCalendarHeader_h
#define HYCalendarHeader_h

#define HY_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define HY_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define HY_UTILS_COLORRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define HY_Iphone6Scale(x) ((x) * HY_SCREEN_WIDTH / 1024.0f)
#define HY_ONE_PIXEL (1.0f / [[UIScreen mainScreen] scale])

// headerView高度
#define HY_HeaderViewHeight 50
// 周视图高度
#define HY_WeekViewHeight 40


#endif /* HYCalendarHeader_h */
