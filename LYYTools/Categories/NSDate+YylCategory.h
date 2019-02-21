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
@property (nonatomic, readonly) NSInteger cmb_year; ///< Year component
@property (nonatomic, readonly) NSInteger cmb_month; ///< Month component (1~12)
@property (nonatomic, readonly) NSInteger cmb_day; ///< Day component (1~31)
@property (nonatomic, readonly) NSInteger cmb_hour; ///< Hour component (0~23)
@property (nonatomic, readonly) NSInteger cmb_nearestHour;  //最近的整点小时
@property (nonatomic, readonly) NSInteger cmb_minute; ///< Minute component (0~59)
@property (nonatomic, readonly) NSInteger cmb_second; ///< Second component (0~59)
@property (nonatomic, readonly) NSInteger cmb_nanosecond; ///< 纳秒单位Nanosecond component
@property (nonatomic, readonly) NSInteger cmb_weekday; ///< Weekday component (1~7, first day is based on user setting)
@property (nonatomic, readonly) NSInteger cmb_weekdayOrdinal; ///< 以7天为单位，范围为1-5 WeekdayOrdinal component
@property (nonatomic, readonly) NSInteger cmb_weekOfMonth; ///< 该月第几周 WeekOfMonth component (1~5)
@property (nonatomic, readonly) NSInteger cmb_weekOfYear; ///< 该年第几周 WeekOfYear component (1~53)
@property (nonatomic, readonly) NSInteger cmb_yearForWeekOfYear; ///< YearForWeekOfYear component
@property (nonatomic, readonly) NSInteger cmb_quarter; ///< 季度 Quarter component
@property (nonatomic, readonly) BOOL cmb_isLeapMonth; ///< 是否是闰月 whether the month is leap month
@property (nonatomic, readonly) BOOL cmb_isLeapYear; ///< 是否是闰年 whether the year is leap year
@property (nonatomic, readonly) BOOL cmb_isToday; ///< whether date is today (based on current locale)
@property (nonatomic, readonly) BOOL cmb_isYesterday; ///< whether date is yesterday (based on current locale)
- (NSDate*)cmb_yesterday;
@property (nonatomic, readonly) BOOL cmb_isTomorrow; ///< whether date is tomorrow (based on current locale)

#pragma mark - ***** String Properties 短字符串工具 日期时间格式 *****
/**
 日期和时间格式设置
 @param dateStyle 日期格式
 @param timeStyle 时间格式
 @return 日期时间
 */
- (NSString *)cmb_stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle: (NSDateFormatterStyle)timeStyle;

- (NSString *)cmb_stringWithFormat:(NSString *)format;

/*  以 ** 2019年2月13日 下午4：01分 ** 为例  */
@property (nonatomic, readonly) NSString *cmb_shortString;      //示例： 2/13/19 4:01 PM   （月/日/年 小时/分）
@property (nonatomic, readonly) NSString *cmb_shortDateString;  //示例： 2/13/19  （月/日/年）
@property (nonatomic, readonly) NSString *cmb_shortTimeString;  //示例： 4:01 PM
@property (nonatomic, readonly) NSString *cmb_mediumString;     //示例： Feb 13,2019 at 4:01:42 PM
@property (nonatomic, readonly) NSString *cmb_mediumDateString; //示例： Feb 13,2019
@property (nonatomic, readonly) NSString *cmb_mediumTimeString; //示例： 4:01:42 PM
@property (nonatomic, readonly) NSString *cmb_longString;       //示例： February 13,2019 at 4:01:42 PM GMT+8
@property (nonatomic, readonly) NSString *cmb_longDateString;   //示例： February 13,2019
@property (nonatomic, readonly) NSString *cmb_longTimeString;   //示例： 4:01:42 PM GMT+8

- (NSString*)cmb_yyyyMMddString;        //示例： 2019-02-13
- (NSDate  *)cmb_getDateOnly;           //示例： 2019-02-13 返回NSDate类型
- (NSString*)cmb_yyyyMMddDotString;     //示例： 2019.02.13
- (NSString*)cmb_yyyyMMddSlashString;   //示例： 2019/2/13
- (NSString*)cmb_yyyyMMddString_CN;     //示例： 2019年02月13日
- (NSString*)cmb_yyyyMMddHHmmssString;  //示例： 2019-02-13 16:01:42
- (NSString*)cmb_HHmmString;            //示例： 16:01
- (NSDate  *)cmb_getTimeOnly;           //示例： 16:01 返回NSDate类型
- (NSString*)cmb_yyyyMMddEEString;      //示例： 2019-02-13 Wed  （星期三）
- (NSString*)cmb_yyyyMMddEEEEString_CN; //示例： 2019年02月13日 Wednesday
- (NSString*)cmb_MMddEEEEString_CN;     //示例： 02月13日 Wednesday
- (NSString*)cmb_EEEEString;            //示例： Wednesday
- (NSString*)cmb_eeString;              //示例： 04

#pragma mark -  ***** Relative Dates 日期计算 *****
/**
 Returns a date representing the receiver date shifted later by the provided number of years.
 
 @param years  Number of years to add.
 @return Date modified by the number of desired years.
 */
- (nullable NSDate *)cmb_dateByAddingYears:(NSInteger)years;

/**
 Returns a date representing the receiver date shifted later by the provided number of months.
 
 @param months  Number of months to add.
 @return Date modified by the number of desired months.
 */
- (nullable NSDate *)cmb_dateByAddingMonths:(NSInteger)months;

/**
 Returns a date representing the receiver date shifted later by the provided number of weeks.
 
 @param weeks  Number of weeks to add.
 @return Date modified by the number of desired weeks.
 */
- (nullable NSDate *)cmb_dateByAddingWeeks:(NSInteger)weeks;

/**
 根据提供的天数移动计算所需的日期
 
 @param  days 输入需要移动的天数.
 @return Date  由所需天数计算所得：返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (nullable NSDate *)cmb_dateByAddingDays:(NSInteger)days;

/**
 Returns a date representing the receiver date shifted later by the provided number of hours.
 
 @param hours  Number of hours to add.
 @return Date modified by the number of desired hours.
 */
- (nullable NSDate *)cmb_dateByAddingHours:(NSInteger)hours;

/**
 Returns a date representing the receiver date shifted later by the provided number of minutes.
 
 @param minutes  Number of minutes to add.
 @return Date modified by the number of desired minutes.
 */
- (nullable NSDate *)cmb_dateByAddingMinutes:(NSInteger)minutes;

/**
 Returns a date representing the receiver date shifted later by the provided number of seconds.
 
 @param seconds  Number of seconds to add.
 @return Date modified by the number of desired seconds.
 */
- (nullable NSDate *)cmb_dateByAddingSeconds:(NSInteger)seconds;

#pragma mark -  ***** Relative Dates 相对日期 *****
+ (NSDate *)cmb_dateWithDaysFromNow:(NSInteger)days;          //多少(d)之后的那天的日期
+ (NSDate *)cmb_dateWithDaysBeforeNow:(NSInteger)days;        //多少(d)之前的那天的日期
+ (NSDate *)cmb_dateTomorrow;   //明天日期
+ (NSDate *)cmb_dateYesterday;  //昨天日期

+ (NSDate *)cmb_dateWithHoursFromNow:(NSInteger)dHours;       //多少(h)之后的那天的日期
+ (NSDate *)cmb_dateWithHoursBeforeNow:(NSInteger)dHours;     //多少(h)之前的那天的日期
+ (NSDate *)cmb_dateWithMinutesFromNow:(NSInteger)dMinutes;   //多少(min)之后的那天的日期
+ (NSDate *)cmb_dateWithMinutesBeforeNow:(NSInteger)dMinutes; //多少(min)之后的那天的日期

#pragma mark - ***** Comparing dates 日期比较 *****
- (BOOL)cmb_isSameDay:(NSDate *)aDate; //日期比较 是否为同一天

- (BOOL)cmb_isSameDayAndHour:(NSDate*)anotherDate; //是否为同一天的同一小时

- (BOOL)cmb_isSameWeekAsDate:(NSDate *)aDate;   //周比较
@property (nonatomic, readonly) BOOL cmb_isThisWeek;
@property (nonatomic, readonly) BOOL cmb_isNextWeek;
@property (nonatomic, readonly) BOOL cmb_isLastWeek;

- (BOOL)cmb_isSameMonthAsDate: (NSDate *)aDate;  //月比较
@property (nonatomic, readonly) BOOL cmb_isThisMonth;
@property (nonatomic, readonly) BOOL cmb_isNextMonth;
@property (nonatomic, readonly) BOOL cmb_isLastMonth;
- (NSDate*)cmb_lastMonth;

- (BOOL)cmb_isSameYearAsDate: (NSDate *)aDate;   //年比较
@property (nonatomic, readonly) BOOL cmb_isThisYear;
@property (nonatomic, readonly) BOOL cmb_isNextYear;
@property (nonatomic, readonly) BOOL cmb_isLastYear;

- (BOOL)cmb_isEarlierThanDate:(NSDate *)aDate;  //比aDate日期早
- (BOOL)cmb_isLaterThanDate:(NSDate *)aDate;    //比aDate日期晚

- (BOOL)cmb_isInFuture;
- (BOOL)cmb_isInPast;

#pragma mark - ***** Roles 特殊日期 *****
- (BOOL)cmb_isTypicallyWorkday;    //是否工作日
- (BOOL)cmb_isTypicallyWeekend;    //是否周末：周六和周天
- (NSDate *)cmb_dateAtStartOfDay;  //获得的时间不太准确，不确定具体意思，待研究
- (NSDate *)cmb_dateAtEndOfDay;    //获得的时间不太准确，不确定具体意思，待研究

- (NSDate *)cmb_beginningOfWeek;   // 取得该周的第一天,星期天为一周的第一天？ 2019-02-10 03:28:59 +0000 (测试日期是2019-02-14 11:28)
- (NSDate *)cmb_endOfWeek;         // 取得该周的最后一天，星期六为一周的第一天？ 2019-02-16 03:28:59 +0000 (测试日期是2019-02-14 11:28)
- (NSDate *)cmb_beginningOfMonth;  //返回该月的第一天, 2019-02-01 03:38:30 +0000 (测试日期是2019-02-14 11:38)
- (NSDate *)cmb_endOfMonth;        //该月的最后一天, 2019-02-28 03:38:30 +0000 (测试日期是2019-02-14 11:38)
- (NSString *)cmb_NdaysBefore;     //取得日期的描述文字 今天 昨天 前天 N天前
- (NSInteger)cmb_getDaysOfMonth;   //取得当前月份的天数

#pragma mark - ***** Retrieving Intervals 时间间隔 *****
- (NSInteger)cmb_minutesAfterDate:(NSDate *)aDate;            //当前时间距aDate过去多少分钟
- (NSInteger)cmb_minutesBeforeDate:(NSDate *)aDate;           //aDate距当前时间多少分钟后
- (NSInteger)cmb_hoursAfterDate:(NSDate *)aDate;              //当前时间距aDate过去多少小时
- (NSInteger)cmb_hoursBeforeDate:(NSDate *)aDate;             //aDate距当前时间多少小时后
- (NSInteger)cmb_daysAfterDate:(NSDate *)aDate;               //当前时间距aDate过去多少天
- (NSInteger)cmb_daysBeforeDate:(NSDate *)aDate;              //aDate距当前时间多少天后
- (NSInteger)cmb_compareDaysToDate:(NSDate *)anotherDate;  //当前时间距anotherDate相隔多少天
- (NSDate*)cmb_dateByMovingToBeginningOfDay;  // 2019/2/14 16:00:00 +0000   待研究  (测试日期是02-14 10:05)
- (NSString*)cmb_description;                 // 没年份    02-15  10:05  (测试日期是02-14 10:05)
- (NSString*)cmb_description_date;            // 有年份    2019年2月15日  (测试日期是02-14 10:05)

#pragma mark - ***** CMB 网易有料 *****
//获取当前时间戳 毫秒 (网易有料：网络请求时间戳参数)
+(NSTimeInterval)cmb_getCurrentMillisecondInterval;

//计算两个时间戳之差 (网易有料：行为上报)
+(NSUInteger)cmb_timeFromBeginTimeInterval:(NSTimeInterval)beginTimestamp toEndTimeInterval:(NSTimeInterval)endTimestamp;

//时间戳变为格式时间 (网易有料：视频相关行为上报)
+(NSString *)cmb_convertStrByTime:(NSTimeInterval)timeInterval;


@end
