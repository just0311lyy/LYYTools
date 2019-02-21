//
//  NSDate+YylCategory.h
//  LYYTools
//
//  Created by YangyangLi on 2019/2/21.
//  Copyright © 2019年 lyy. All rights reserved.
//

#import <Foundation/Foundation.h>

#define S_MINUTE     60         //以秒计算
#define S_HOUR       3600
#define S_DAY        86400
#define S_WEEK       604800
#define S_YEAR_365   31536000
#define S_YEAR_366   31622400

@interface NSDate (YylCategory)

+ (NSCalendar *)currentCalendar; // avoid bottlenecks

#pragma mark - ***** Decomposing Dates 具体时间 *****
@property (nonatomic, readonly) NSInteger yyl_year; ///< Year component
@property (nonatomic, readonly) NSInteger yyl_month; ///< Month component (1~12)
@property (nonatomic, readonly) NSInteger yyl_day; ///< Day component (1~31)
@property (nonatomic, readonly) NSInteger yyl_hour; ///< Hour component (0~23)
@property (nonatomic, readonly) NSInteger yyl_nearestHour;  //最近的整点小时
@property (nonatomic, readonly) NSInteger yyl_minute; ///< Minute component (0~59)
@property (nonatomic, readonly) NSInteger yyl_second; ///< Second component (0~59)
@property (nonatomic, readonly) NSInteger yyl_nanosecond; ///< 纳秒单位Nanosecond component
@property (nonatomic, readonly) NSInteger yyl_weekday; ///< Weekday component (1~7, first day is based on user setting)
@property (nonatomic, readonly) NSInteger yyl_weekdayOrdinal; ///< 以7天为单位，范围为1-5 WeekdayOrdinal component
@property (nonatomic, readonly) NSInteger yyl_weekOfMonth; ///< 该月第几周 WeekOfMonth component (1~5)
@property (nonatomic, readonly) NSInteger yyl_weekOfYear; ///< 该年第几周 WeekOfYear component (1~53)
@property (nonatomic, readonly) NSInteger yyl_yearForWeekOfYear; ///< YearForWeekOfYear component
@property (nonatomic, readonly) NSInteger yyl_quarter; ///< 季度 Quarter component
@property (nonatomic, readonly) BOOL yyl_isLeapMonth; ///< 是否是闰月 whether the month is leap month
@property (nonatomic, readonly) BOOL yyl_isLeapYear; ///< 是否是闰年 whether the year is leap year
@property (nonatomic, readonly) BOOL yyl_isToday; ///< whether date is today (based on current locale)
@property (nonatomic, readonly) BOOL yyl_isYesterday; ///< whether date is yesterday (based on current locale)
- (NSDate*)yyl_yesterday;
@property (nonatomic, readonly) BOOL yyl_isTomorrow; ///< whether date is tomorrow (based on current locale)

#pragma mark - ***** String Properties 短字符串工具 日期时间格式 *****
/**
 日期和时间格式设置
 @param dateStyle 日期格式
 @param timeStyle 时间格式
 @return 日期时间
 */
- (NSString *)yyl_stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle: (NSDateFormatterStyle)timeStyle;

- (NSString *)yyl_stringWithFormat:(NSString *)format;

/*  以 ** 2019年2月13日 下午4：01分 ** 为例  */
@property (nonatomic, readonly) NSString *yyl_shortString;      //示例： 2/13/19 4:01 PM   （月/日/年 小时/分）
@property (nonatomic, readonly) NSString *yyl_shortDateString;  //示例： 2/13/19  （月/日/年）
@property (nonatomic, readonly) NSString *yyl_shortTimeString;  //示例： 4:01 PM
@property (nonatomic, readonly) NSString *yyl_mediumString;     //示例： Feb 13,2019 at 4:01:42 PM
@property (nonatomic, readonly) NSString *yyl_mediumDateString; //示例： Feb 13,2019
@property (nonatomic, readonly) NSString *yyl_mediumTimeString; //示例： 4:01:42 PM
@property (nonatomic, readonly) NSString *yyl_longString;       //示例： February 13,2019 at 4:01:42 PM GMT+8
@property (nonatomic, readonly) NSString *yyl_longDateString;   //示例： February 13,2019
@property (nonatomic, readonly) NSString *yyl_longTimeString;   //示例： 4:01:42 PM GMT+8

- (NSString*)yyl_yyyyMMddString;        //示例： 2019-02-13
- (NSDate  *)yyl_getDateOnly;           //示例： 2019-02-13 返回NSDate类型
- (NSString*)yyl_yyyyMMddDotString;     //示例： 2019.02.13
- (NSString*)yyl_yyyyMMddSlashString;   //示例： 2019/2/13
- (NSString*)yyl_yyyyMMddString_CN;     //示例： 2019年02月13日
- (NSString*)yyl_yyyyMMddHHmmssString;  //示例： 2019-02-13 16:01:42
- (NSString*)yyl_HHmmString;            //示例： 16:01
- (NSDate  *)yyl_getTimeOnly;           //示例： 16:01 返回NSDate类型
- (NSString*)yyl_yyyyMMddEEString;      //示例： 2019-02-13 Wed  （星期三）
- (NSString*)yyl_yyyyMMddEEEEString_CN; //示例： 2019年02月13日 Wednesday
- (NSString*)yyl_MMddEEEEString_CN;     //示例： 02月13日 Wednesday
- (NSString*)yyl_EEEEString;            //示例： Wednesday
- (NSString*)yyl_eeString;              //示例： 04

#pragma mark -  ***** Relative Dates 日期计算 *****
/**
 Returns a date representing the receiver date shifted later by the provided number of years.
 
 @param years  Number of years to add.
 @return Date modified by the number of desired years.
 */
- (nullable NSDate *)yyl_dateByAddingYears:(NSInteger)years;

/**
 Returns a date representing the receiver date shifted later by the provided number of months.
 
 @param months  Number of months to add.
 @return Date modified by the number of desired months.
 */
- (nullable NSDate *)yyl_dateByAddingMonths:(NSInteger)months;

/**
 Returns a date representing the receiver date shifted later by the provided number of weeks.
 
 @param weeks  Number of weeks to add.
 @return Date modified by the number of desired weeks.
 */
- (nullable NSDate *)yyl_dateByAddingWeeks:(NSInteger)weeks;

/**
 根据提供的天数移动计算所需的日期
 
 @param  days 输入需要移动的天数.
 @return Date  由所需天数计算所得：返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (nullable NSDate *)yyl_dateByAddingDays:(NSInteger)days;

/**
 Returns a date representing the receiver date shifted later by the provided number of hours.
 
 @param hours  Number of hours to add.
 @return Date modified by the number of desired hours.
 */
- (nullable NSDate *)yyl_dateByAddingHours:(NSInteger)hours;

/**
 Returns a date representing the receiver date shifted later by the provided number of minutes.
 
 @param minutes  Number of minutes to add.
 @return Date modified by the number of desired minutes.
 */
- (nullable NSDate *)yyl_dateByAddingMinutes:(NSInteger)minutes;

/**
 Returns a date representing the receiver date shifted later by the provided number of seconds.
 
 @param seconds  Number of seconds to add.
 @return Date modified by the number of desired seconds.
 */
- (nullable NSDate *)yyl_dateByAddingSeconds:(NSInteger)seconds;

#pragma mark -  ***** Relative Dates 相对日期 *****
+ (NSDate *)yyl_dateWithDaysFromNow:(NSInteger)days;          //多少(d)之后的那天的日期
+ (NSDate *)yyl_dateWithDaysBeforeNow:(NSInteger)days;        //多少(d)之前的那天的日期
+ (NSDate *)yyl_dateTomorrow;   //明天日期
+ (NSDate *)yyl_dateYesterday;  //昨天日期

+ (NSDate *)yyl_dateWithHoursFromNow:(NSInteger)dHours;       //多少(h)之后的那天的日期
+ (NSDate *)yyl_dateWithHoursBeforeNow:(NSInteger)dHours;     //多少(h)之前的那天的日期
+ (NSDate *)yyl_dateWithMinutesFromNow:(NSInteger)dMinutes;   //多少(min)之后的那天的日期
+ (NSDate *)yyl_dateWithMinutesBeforeNow:(NSInteger)dMinutes; //多少(min)之后的那天的日期

#pragma mark - ***** Comparing dates 日期比较 *****
- (BOOL)yyl_isSameDay:(NSDate *)aDate; //日期比较 是否为同一天

- (BOOL)yyl_isSameDayAndHour:(NSDate*)anotherDate; //是否为同一天的同一小时

- (BOOL)yyl_isSameWeekAsDate:(NSDate *)aDate;   //周比较
@property (nonatomic, readonly) BOOL yyl_isThisWeek;
@property (nonatomic, readonly) BOOL yyl_isNextWeek;
@property (nonatomic, readonly) BOOL yyl_isLastWeek;

- (BOOL)yyl_isSameMonthAsDate: (NSDate *)aDate;  //月比较
@property (nonatomic, readonly) BOOL yyl_isThisMonth;
@property (nonatomic, readonly) BOOL yyl_isNextMonth;
@property (nonatomic, readonly) BOOL yyl_isLastMonth;
- (NSDate*)yyl_lastMonth;

- (BOOL)yyl_isSameYearAsDate: (NSDate *)aDate;   //年比较
@property (nonatomic, readonly) BOOL yyl_isThisYear;
@property (nonatomic, readonly) BOOL yyl_isNextYear;
@property (nonatomic, readonly) BOOL yyl_isLastYear;

- (BOOL)yyl_isEarlierThanDate:(NSDate *)aDate;  //比aDate日期早
- (BOOL)yyl_isLaterThanDate:(NSDate *)aDate;    //比aDate日期晚

- (BOOL)yyl_isInFuture;
- (BOOL)yyl_isInPast;

#pragma mark - ***** Roles 特殊日期 *****
- (BOOL)yyl_isTypicallyWorkday;    //是否工作日
- (BOOL)yyl_isTypicallyWeekend;    //是否周末：周六和周天
- (NSDate *)yyl_dateAtStartOfDay;  //获得的时间不太准确，不确定具体意思，待研究
- (NSDate *)yyl_dateAtEndOfDay;    //获得的时间不太准确，不确定具体意思，待研究

- (NSDate *)yyl_beginningOfWeek;   // 取得该周的第一天,星期天为一周的第一天？ 2019-02-10 03:28:59 +0000 (测试日期是2019-02-14 11:28)
- (NSDate *)yyl_endOfWeek;         // 取得该周的最后一天，星期六为一周的第一天？ 2019-02-16 03:28:59 +0000 (测试日期是2019-02-14 11:28)
- (NSDate *)yyl_beginningOfMonth;  //返回该月的第一天, 2019-02-01 03:38:30 +0000 (测试日期是2019-02-14 11:38)
- (NSDate *)yyl_endOfMonth;        //该月的最后一天, 2019-02-28 03:38:30 +0000 (测试日期是2019-02-14 11:38)
- (NSString *)yyl_NdaysBefore;     //取得日期的描述文字 今天 昨天 前天 N天前
- (NSInteger)yyl_getDaysOfMonth;   //取得当前月份的天数

#pragma mark - ***** Retrieving Intervals 时间间隔 *****
- (NSInteger)yyl_minutesAfterDate:(NSDate *)aDate;            //当前时间距aDate过去多少分钟
- (NSInteger)yyl_minutesBeforeDate:(NSDate *)aDate;           //aDate距当前时间多少分钟后
- (NSInteger)yyl_hoursAfterDate:(NSDate *)aDate;              //当前时间距aDate过去多少小时
- (NSInteger)yyl_hoursBeforeDate:(NSDate *)aDate;             //aDate距当前时间多少小时后
- (NSInteger)yyl_daysAfterDate:(NSDate *)aDate;               //当前时间距aDate过去多少天
- (NSInteger)yyl_daysBeforeDate:(NSDate *)aDate;              //aDate距当前时间多少天后
- (NSInteger)yyl_compareDaysToDate:(NSDate *)anotherDate;  //当前时间距anotherDate相隔多少天
- (NSDate*)yyl_dateByMovingToBeginningOfDay;  // 2019/2/14 16:00:00 +0000   待研究  (测试日期是02-14 10:05)
- (NSString*)yyl_description;                 // 没年份    02-15  10:05  (测试日期是02-14 10:05)
- (NSString*)yyl_description_date;            // 有年份    2019年2月15日  (测试日期是02-14 10:05)

#pragma mark - ***** CMB 网易有料 *****
//获取当前时间戳 毫秒 (网易有料：网络请求时间戳参数)
+(NSTimeInterval)yyl_getCurrentMillisecondInterval;

//计算两个时间戳之差 (网易有料：行为上报)
+(NSUInteger)yyl_timeFromBeginTimeInterval:(NSTimeInterval)beginTimestamp toEndTimeInterval:(NSTimeInterval)endTimestamp;

//时间戳变为格式时间 (网易有料：视频相关行为上报)
+(NSString *)yyl_convertStrByTime:(NSTimeInterval)timeInterval;


@end
