//
//  NSDate+YylCategory.m
//  LYYTools
//
//  Created by YangyangLi on 2019/2/21.
//  Copyright © 2019年 lyy. All rights reserved.
//

#import "NSDate+YylCategory.h"

//若获取dateComponents对象时，设置components的时候未添加NSYearCalendarUnit，dateComponents.year将返回错误的数值，其他的也一样，所以使用NSDateComponents表示时间时，要确保需要使用的数据都在componets中添加了。
static const unsigned componentFlags = (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth |NSCalendarUnitWeekOfYear |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal);

@implementation NSDate (YylCategory)

#pragma mark -  ********** 单例初始化
+ (NSCalendar *)currentCalendar{
    static NSCalendar *sharedCalendar = nil;
    if (!sharedCalendar)
        //        sharedCalendar = [NSCalendar currentCalendar];  //在程序中，currentCalendar取得的值会一直保持在cache中，第一次取得以后如果用户修改该系统日历设定，这个值也不会改变。
        sharedCalendar = [NSCalendar autoupdatingCurrentCalendar]; //每次取得的值都会是当前系统设置的日历的值。
    return sharedCalendar;
}

#pragma mark - ***** Decomposing Dates 具体时间 *****
- (NSInteger)yyl_year
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.year;
}

- (NSInteger)yyl_month
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.month;
}

- (NSInteger)yyl_day
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.day;
}

- (NSInteger)yyl_hour
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.hour;
}

/**
 最近的整点小时，例如 2:42 pm  则返回 15
 @return 整点
 */
- (NSInteger)yyl_nearestHour
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + S_MINUTE * 30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitHour fromDate:newDate];
    return components.hour;
}

- (NSInteger)yyl_minute
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.minute;
}

- (NSInteger)yyl_second
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.second;
}

//纳秒单位
- (NSInteger)yyl_nanosecond
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.nanosecond;
}

//    Sunday:1, Monday:2, Tuesday:3, Wednesday:4, Friday:5, Saturday:6
- (NSInteger)yyl_weekday
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.weekday;
}

/**
 以7天为单位，范围为1-5 例1-7号为第1个7天，8-14号为第2个7天...）
 @return 第几个七天
 */
- (NSInteger)yyl_weekdayOrdinal
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.weekdayOrdinal;
}

//该月第几周
- (NSInteger)yyl_weekOfMonth
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.weekOfMonth;
}

//该年第几周 苹果官方不推荐使用week 即不推荐components.week写法
- (NSInteger)yyl_weekOfYear{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.weekOfYear;
}

- (NSInteger)yyl_yearForWeekOfYear {
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.yearForWeekOfYear;
}

//第几季度
- (NSInteger)yyl_quarter
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.quarter;
}

// 是否是闰月
- (BOOL)yyl_isLeapMonth
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] isLeapMonth];
}

// 是否是闰年
- (BOOL)yyl_isLeapYear
{
    NSUInteger year = self.yyl_year;
    return ((year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0)));
}

- (BOOL)yyl_isToday
{
    //    return [self isEqualToDateIgnoringTime:[NSDate date]];   //方案一：直接使用日期的比较
    //方案二：fabs处理double类型的 取绝对值
    if (fabs(self.timeIntervalSinceNow) >= 60 * 60 * 24) return NO;
    return [NSDate new].yyl_day == self.yyl_day;
}

- (BOOL)yyl_isYesterday
{
    //方案一：直接使用日期的比较
    //    return [self isEqualToDateIgnoringTime:[NSDate yyl_dateYesterday]];
    //方案二：
    NSDate *added = [self yyl_dateByAddingDays:1];
    return [added yyl_isToday];
}

- (NSDate*)yyl_yesterday
{
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.day = -1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0];
}

- (BOOL)yyl_isTomorrow{
    return [self yyl_isSameDay:[NSDate yyl_dateTomorrow]];
}

#pragma mark - ***** String Properties 短字符串工具 时间日期格式设置 *****
- (NSString *)yyl_stringWithFormat:(NSString *)format{
    NSDateFormatter *formatter = [NSDateFormatter new];
    //    formatter.locale = [NSLocale currentLocale]; // Necessary?
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

//时间字符串格式设置
- (NSString *)yyl_stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateStyle = dateStyle;
    formatter.timeStyle = timeStyle;
    //    formatter.locale = [NSLocale currentLocale]; // Necessary?
    return [formatter stringFromDate:self];
}

//2019年2月13日 下午4：01分
//示例： 2/13/19 4:01 PM   （月/日/年 小时/分）
- (NSString *)yyl_shortString{
    return [self yyl_stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
}

//示例： 2/13/19  （月/日/年）
- (NSString *)yyl_shortDateString{
    return [self yyl_stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
}

//示例： 4:01 PM
- (NSString *)yyl_shortTimeString{
    return [self yyl_stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
}

//示例： Feb 13,2019 at 4:01:42 PM
- (NSString *)yyl_mediumString{
    return [self yyl_stringWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle ];
}

//示例： Feb 13,2019
- (NSString *)yyl_mediumDateString{
    return [self yyl_stringWithDateStyle:NSDateFormatterMediumStyle  timeStyle:NSDateFormatterNoStyle];
}

//示例： 4:01:42 PM
- (NSString *)yyl_mediumTimeString{
    return [self yyl_stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle ];
}

//示例： February 13,2019 at 4:01:42 PM GMT+8
- (NSString *)yyl_longString{
    return [self yyl_stringWithDateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterLongStyle ];
}

//示例： February 13,2019
- (NSString *)yyl_longDateString{
    return [self yyl_stringWithDateStyle:NSDateFormatterLongStyle  timeStyle:NSDateFormatterNoStyle];
}

//示例： 4:01:42 PM GMT+8
- (NSString *)yyl_longTimeString{
    return [self yyl_stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterLongStyle ];
}

//示例： 2019-02-13  返回NSString类型
- (NSString *)yyl_yyyyMMddString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str = [formatter stringFromDate:self];
    return str;
}

//示例： 2019-02-13  返回NSDate类型
- (NSDate *)yyl_getDateOnly
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString * strDate=[formatter stringFromDate:self];
    NSDate * dateReturn= [formatter dateFromString:strDate];
    return dateReturn;
}

//示例： 2019.02.13
- (NSString *)yyl_yyyyMMddDotString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    NSString *str = [formatter stringFromDate:self];
    return str;
}

//示例： 2019/2/13
- (NSString *)yyl_yyyyMMddSlashString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/M/d"];
    NSString *str = [formatter stringFromDate:self];
    return str;
}

//示例： 2019年02月13日
- (NSString *)yyl_yyyyMMddString_CN
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *str = [formatter stringFromDate:self];
    return str;
}

//示例： 2019-02-13 16:01:42
- (NSString *)yyl_yyyyMMddHHmmssString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *str = [formatter stringFromDate:self];
    return str;
}

//示例： 16:01  返回NSString类型
- (NSString *)yyl_HHmmString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *str = [formatter stringFromDate:self];
    return str;
}

//示例： 2019-02-13  返回NSDate类型
- (NSDate *)yyl_getTimeOnly
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat=@"HH:mm";
    NSString * strDate=[formatter stringFromDate:self];
    NSDate * dateReturn= [formatter dateFromString:strDate];
    return dateReturn;
}

//示例： 2019-02-13 Wed  （星期三）
- (NSString *)yyl_yyyyMMddEEString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd EE"];
    NSString *str = [formatter stringFromDate:self];
    return str;
}

//示例： 2019年02月13日 Wednesday
- (NSString *)yyl_yyyyMMddEEEEString_CN
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日 EEEE"];
    NSString *str = [formatter stringFromDate:self];
    return str;
}

//示例： 02月13日 Wednesday
- (NSString *)yyl_MMddEEEEString_CN
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM月dd日 EEEE"];
    NSString *str = [formatter stringFromDate:self];
    return str;
}

//示例： 04
- (NSString *)yyl_eeString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"ee"];
    NSString *str = [formatter stringFromDate:self];
    return str;
}

//示例： Wednesday
- (NSString *)yyl_EEEEString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE"];
    NSString *str = [formatter stringFromDate:self];
    return str;
}

#pragma mark -  ***** Relative Dates 日期计算 *****
- (NSDate *)yyl_dateByAddingYears:(NSInteger)years
{
    NSCalendar *calendar =  [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:years];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)yyl_dateByAddingMonths:(NSInteger)months
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:months];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)yyl_dateByAddingWeeks:(NSInteger)weeks
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setWeekOfYear:weeks];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

// timeIntervalSinceReferenceDate初始化方式: 当前date对象 与 2001-01-01 00:00:00 的时间间隔
- (NSDate *)yyl_dateByAddingDays:(NSInteger)days
{
    //方法一
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + S_DAY * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
    //方法二
    //    // Get the weekday component of the current date
    //    // NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    //    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    //    // to get the end of week for a particular date, add (7 - weekday) days
    //    [dateComponents setDay:days];
    //    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    //    return newDate;
}

- (NSDate *)yyl_dateByAddingHours:(NSInteger)hours
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + S_HOUR * hours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)yyl_dateByAddingMinutes:(NSInteger)minutes
{
    //方法一
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + S_MINUTE * minutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
    //方法二
    //    NSDateComponents *c = [[NSDateComponents alloc] init];
    //    c.minute = minutes;
    //    return [[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0];
}

- (NSDate *)yyl_dateByAddingSeconds:(NSInteger)seconds
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + seconds;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

#pragma mark -  ***** Relative Dates 相对日期 *****
//几天后（从今天往后计算）
+ (NSDate *)yyl_dateWithDaysFromNow:(NSInteger)days{
    return [[NSDate date] yyl_dateByAddingDays:days];
}

//几天前（从今天往前推算）
+ (NSDate *)yyl_dateWithDaysBeforeNow:(NSInteger)days{
    return [[NSDate date] yyl_dateByAddingDays:(days * -1)];
}

//明天
+ (NSDate *)yyl_dateTomorrow{
    return [NSDate yyl_dateWithDaysFromNow:1];
}

//昨天
+ (NSDate *)yyl_dateYesterday
{
    return [NSDate yyl_dateWithDaysBeforeNow:1];
}

//几小时之后的日期（几小时后是哪天）
+ (NSDate *)yyl_dateWithHoursFromNow:(NSInteger)dHours{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + S_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

//几小时之前的日期（几小时前是哪天）
+ (NSDate *)yyl_dateWithHoursBeforeNow:(NSInteger)dHours{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - S_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

//几分钟之后的日期（多少分钟后是哪天）
+ (NSDate *)yyl_dateWithMinutesFromNow:(NSInteger)dMinutes{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + S_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

//几分钟之前的日期（多少分钟前是哪天）
+ (NSDate *)yyl_dateWithMinutesBeforeNow:(NSInteger)dMinutes{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - S_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

#pragma mark - ***** Comparing dates 日期比较 *****
//日期比较：是否同一天(只比较年月日)
- (BOOL)yyl_isSameDay:(NSDate *)aDate{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:componentFlags fromDate:aDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}

//是否为同一天的同一小时
- (BOOL)yyl_isSameDayAndHour:(NSDate*)aDate{
    //    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components1 = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    NSDateComponents* components2 = [[NSDate currentCalendar] components:componentFlags fromDate:aDate];
    return ([components1 year] == [components2 year] && [components1 month] == [components2 month] && [components1 day] == [components2 day]
            && [components1 hour] == [components2 hour]);
}

//周比较：七天为一周
- (BOOL)yyl_isSameWeekAsDate:(NSDate *)aDate{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:componentFlags fromDate:aDate];
    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if (components1.weekOfYear != components2.weekOfYear) return NO;
    // Must have a time interval under 1 week. Thanks @aclark
    return (fabs([self timeIntervalSinceDate:aDate]) < S_WEEK);
}

- (BOOL)yyl_isThisWeek{
    return [self yyl_isSameWeekAsDate:[NSDate date]];
}

- (BOOL)yyl_isNextWeek{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + S_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self yyl_isSameWeekAsDate:newDate];
}

- (BOOL)yyl_isLastWeek{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - S_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self yyl_isSameWeekAsDate:newDate];
}

//月比较
- (BOOL)yyl_isSameMonthAsDate:(NSDate *)aDate{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

- (BOOL)yyl_isThisMonth{
    return [self yyl_isSameMonthAsDate:[NSDate date]];
}

- (BOOL)yyl_isLastMonth{
    return [self yyl_isSameMonthAsDate:[[NSDate date] yyl_dateByAddingMonths:-1]];
}

- (NSDate*)yyl_lastMonth{
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.month = -1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0];
}

- (BOOL)yyl_isNextMonth{
    return [self yyl_isSameMonthAsDate:[[NSDate date] yyl_dateByAddingMonths:1]];
}

- (BOOL)yyl_isSameYearAsDate:(NSDate *)aDate{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:aDate];
    return (components1.year == components2.year);
}

- (BOOL)yyl_isThisYear{
    return [self yyl_isSameYearAsDate:[NSDate date]];
}

- (BOOL)yyl_isNextYear{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    return (components1.year == (components2.year + 1));
}

- (BOOL)yyl_isLastYear{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    return (components1.year == (components2.year - 1));
}

//比aDate日期早
- (BOOL)yyl_isEarlierThanDate:(NSDate *)aDate{
    //方法一
    //    if ([self timeIntervalSinceDate:aDate] >=0) {
    //        return NO;
    //    }else {
    //        return YES;
    //    }
    //方法二
    return ([self compare:aDate] == NSOrderedAscending);
}

//比aDate日期晚
- (BOOL)yyl_isLaterThanDate:(NSDate *)aDate{
    return ([self compare:aDate] == NSOrderedDescending);
}

- (BOOL)yyl_isInFuture{
    return ([self yyl_isLaterThanDate:[NSDate date]]);
}

- (BOOL)yyl_isInPast{
    return ([self yyl_isEarlierThanDate:[NSDate date]]);
}

#pragma mark - ***** Roles 特殊日期 *****
//周末：周六和周天
- (BOOL)yyl_isTypicallyWeekend{
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return YES;
    return NO;
}

//工作日
- (BOOL)yyl_isTypicallyWorkday
{
    return ![self yyl_isTypicallyWeekend];
}

#pragma mark -- ***** 项目调用方法 *****
//获得的时间不太准确，不确定具体意思，待研究
- (NSDate *)yyl_dateAtStartOfDay{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [[NSDate currentCalendar] dateFromComponents:components];
}

//获得的时间不太准确，不确定具体意思，待研究
- (NSDate *)yyl_dateAtEndOfDay{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    components.hour = 23; // Thanks Aleksey Kononov
    components.minute = 59;
    components.second = 59;
    return [[NSDate currentCalendar] dateFromComponents:components];
}

// 取得该周的第一天,星期天为一周的第一天？ 2019-02-10 03:28:59 +0000 (测试日期是2019-02-14 11:28)
- (NSDate *)yyl_beginningOfWeek
{
    NSInteger week;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate * now = self;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    //    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:componentFlags fromDate:now];
    week = [comps weekday];
    return [self yyl_dateByAddingDays:-((int)week-1)];
}

// 取得该周的最后一天，星期六为一周的第一天？ 2019-02-16 03:28:59 +0000 (测试日期是2019-02-14 11:28)
- (NSDate *)yyl_endOfWeek;
{
    NSInteger week;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate * now = self;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    //    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:componentFlags fromDate:now];
    week = [comps weekday];
    return [self yyl_dateByAddingDays:(7-(int)week)];
}

//返回该月的第一天, 2019-02-01 03:38:30 +0000 (测试日期是2019-02-14 11:38)
- (NSDate *)yyl_beginningOfMonth
{
    return [self yyl_dateByAddingDays:-(int)[self yyl_day] + 1];
}

//该月的最后一天, 2019-02-28 03:38:30 +0000 (测试日期是2019-02-14 11:38)
- (NSDate *)yyl_endOfMonth
{
    return [[[self yyl_beginningOfMonth] yyl_dateByAddingMonths:1] yyl_dateByAddingDays:-1];
}

//取得日期的描述文字 今天 昨天 前天 N天前
-(NSString *)yyl_NdaysBefore
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat=@"yyyy-MM-dd";
    NSString * strDate=[formatter stringFromDate:self];
    NSDate * today = [formatter dateFromString:strDate]; //今天
    NSInteger days = [self yyl_compareDaysToDate:today];
    NSString * strReturn=@"";
    if (days==0) strReturn=@"今天";
    else if (days==1) strReturn=@"昨天";
    else if (days==2) strReturn=@"前天";
    else strReturn=[NSString stringWithFormat:@"%ld天前",days];
    return strReturn;
}

//取得当前月份的天数
- (NSInteger)yyl_getDaysOfMonth
{
    NSDate * firstDay = [self yyl_beginningOfMonth];
    NSDate * endDay = [self yyl_endOfMonth];
    return [firstDay yyl_compareDaysToDate:endDay]+1;
}

#pragma mark - ***** Retrieving Intervals 时间间隔 *****
//当前时间距aDate过去多少分钟
- (NSInteger)yyl_minutesAfterDate:(NSDate *)aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / S_MINUTE);
}

//aDate距当前时间多少分钟后
- (NSInteger)yyl_minutesBeforeDate:(NSDate *)aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / S_MINUTE);
}

//当前时间距aDate过去多少小时
- (NSInteger)yyl_hoursAfterDate:(NSDate *)aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / S_HOUR);
}

//aDate距当前时间多少小时后
- (NSInteger)yyl_hoursBeforeDate:(NSDate *)aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / S_HOUR);
}

//当前时间距aDate过去多少天
- (NSInteger)yyl_daysAfterDate:(NSDate *)aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / S_DAY);
}

//aDate距当前时间多少天后
- (NSInteger)yyl_daysBeforeDate:(NSDate *)aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / S_DAY);
}

//当前时间距anotherDate相隔多少天
- (NSInteger)yyl_compareDaysToDate:(NSDate *)anotherDate
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay fromDate:self toDate:anotherDate options:0];
    return components.day;
}

//  2019/2/14 16:00:00 +0000   待研究
- (NSDate *)yyl_dateByMovingToBeginningOfDay
{
    //    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents* parts = [[NSCalendar currentCalendar] components:componentFlags fromDate:self];
    [parts setHour:0];
    [parts setMinute:0];
    [parts setSecond:0];
    return [[NSCalendar currentCalendar] dateFromComponents:parts];
}

// 没年份    02-15  10:05  (测试日期是02-14 10:05)
- (NSString*)yyl_description{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSDate* beginningOfToday = [[NSDate date] yyl_dateByMovingToBeginningOfDay];
    
    NSTimeInterval oneDayInterval = 60*60*24;
    NSTimeInterval interval = [self timeIntervalSinceDate:beginningOfToday];
    
    NSString *returnStr = nil;
    
    if (interval>=0 && interval < oneDayInterval) {
        
        NSDate *now = [NSDate date];
        interval = [now timeIntervalSinceDate:self];
        if (interval < 60*60 && interval >= 60*1) {
            returnStr = [NSString stringWithFormat:@"%i 分钟前", (int)interval/60 ];
        }else if (interval < 60 *1) {
            returnStr = @"刚才";
        }else
            [formatter setDateFormat:@"今日 HH:mm"];
        
    }else if ( interval <0 && interval > -oneDayInterval) {
        [formatter setDateFormat:@"昨日 HH:mm"];
    }else if ( interval <0 && interval > -oneDayInterval*2) {
        [formatter setDateFormat:@"前日 HH:mm"];
    }else {
        [formatter setDateFormat:@"MM-dd HH:mm"];
    }
    
    if (returnStr==nil)
        returnStr = [formatter stringFromDate:self];
    return returnStr;
}

// 有年份    2019年2月15日  (测试日期是02-14 10:05)
- (NSString*)yyl_description_date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSDate* beginningOfToday = [[NSDate date] yyl_dateByMovingToBeginningOfDay];
    
    NSTimeInterval oneDayInterval = 60*60*24;
    NSTimeInterval interval = [self timeIntervalSinceDate:beginningOfToday];
    
    NSString *returnStr = nil;
    
    if (interval>=0 && interval < oneDayInterval) {
        
        NSDate *now = [NSDate date];
        interval = [now timeIntervalSinceDate:self];
        if (interval < 60*60 && interval >= 60*1) {
            returnStr = [NSString stringWithFormat:@"%i 分钟前", (int)interval/60 ];
        }else if (interval < 60 *1) {
            returnStr = @"刚才";
        }else
            [formatter setDateFormat:@"今天"];
        
    }else if ( interval <0 && interval >= -oneDayInterval) {
        [formatter setDateFormat:@"昨天"];
    }else if ( interval <0 && interval >= -oneDayInterval*2) {
        [formatter setDateFormat:@"前天"];
    }else {
        [formatter setDateFormat:@"yyyy年M月d日"];
    }
    
    if (returnStr==nil)
        returnStr = [formatter stringFromDate:self];
    
    return returnStr;
}

#pragma mark - ***** CMB 网易有料 *****
//获取当前时间戳 毫秒 (网易有料：网络请求时间戳参数)
+(NSTimeInterval)yyl_getCurrentMillisecondInterval
{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval timeInterval=[date timeIntervalSince1970]*1000;
    return timeInterval;
}

//计算两个时间戳之差 (网易有料：浏览时长行为上报)
+(NSUInteger)yyl_timeFromBeginTimeInterval:(NSTimeInterval)beginTimestamp toEndTimeInterval:(NSTimeInterval)endTimestamp
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd-HH:MM:ss"];
    
    NSDate* beginDate = [NSDate dateWithTimeIntervalSince1970:beginTimestamp];
    NSString *beginDateString = [formatter stringFromDate:beginDate];
    NSLog(@"开始时间: %@", beginDateString);
    
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:endTimestamp];
    NSString *endDateString = [formatter stringFromDate:endDate];
    NSLog(@"结束时间: %@", endDateString);
    
    NSTimeInterval seconds = [endDate timeIntervalSinceDate:beginDate];
    NSLog(@"两个时间相隔：%.0f", seconds);
    NSUInteger interValue = roundf(seconds);
    return interValue;
}

//时间戳变为格式时间 (网易有料：视频相关行为上报)
+(NSString *)yyl_convertStrByTime:(NSTimeInterval)timeInterval
{
    //    long long time=[timeStr longLongValue];
    //    如果服务器返回的是13位字符串，需要除以1000，否则显示不正确(13位其实代表的是毫秒，需要除以1000)
    //    long long time=[timeStr longLongValue] / 1000;
    long long time = timeInterval / 1000;
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString*timeString=[formatter stringFromDate:date];
    return timeString;
}

@end
