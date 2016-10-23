//
//  MyStatus.m
//  GXLWB
//
//  Created by administrator on 16/8/11.
//  Copyright © 2016年 administrator. All rights reserved.
//

#import "MyStatus.h"
#import "MyUser.h"
#import "MJExtension.h"
#import "MyPhoto.h"

@implementation MyStatus

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[MyPhoto class]};
}


- (void)setSource:(NSString *)source
{
    
    _source = source;
    
    //正则表达式NSRegulatExpression
    if ([source isEqualToString:@""]) {
        return;
    }
    
    //截串NSString
    NSRange range;
    range.location = [source rangeOfString:@">"].location+1;
    range.length = [source rangeOfString:@"</"].location-range.location;
    _source = [NSString stringWithFormat:@"来自%@",[source substringWithRange:range]];
    
}

//- (void)setCreated_at:(NSString *)created_at
//{
//    
//    _created_at = created_at;
//    
//    //今年
//    //今天
//    //一分钟之内的 刚刚
//    //一分钟到五十九分钟内 xx分钟前
//    //大于60分钟  xx小时前
//    //昨天
//    //昨天 xx:xx
//    //xx-xx xx:xx
//    
//    //不是今年
//    //xxxx-xx-xx xx:xx
//    
//    
//    
//    
//    
//    // 设置日期格式（声明字符串里面每个数字和单词的含义）
//    // E:星期几
//    // M:月份
//    // d:几号(这个月的第几天)
//    // H:24小时制的小时
//    // m:分钟
//    // s:秒
//    // y:年
//    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
//    //如果是真机 转换这种欧美时间 需要设置locale
//    fmt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
//    
//    //设置日期格式 （声明字符串每个数字单词的含义）
//    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
//    
//    //微博的创建日期
//    NSDate *creatDate = [fmt dateFromString:_created_at];
//    
//    //当前时间
//    NSDate *now = [NSDate date];
//    
//    //日历对象 方便比较两个日期之间的差距
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    //NSCalendarUnit美剧代表想获得那些差值
//    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
//    //计算两个日期之间的差值
//    NSDateComponents *cmps = [calendar components:unit fromDate:creatDate toDate:now options:0];
//    
//    //    //获得某个时间的年月日时分秒
//    //    NSDateComponents *createDateCmps = [calendar components:unit fromDate:creatDate];
//    //    NSDateComponents *nowDateCmps = [calendar components:unit fromDate:now];
//    //    createDateCmps.year = nowDateCmps.year;
//    
//    
//    if ([creatDate isThisYear]) {//今年
//        if ([creatDate isYesterday]) {//昨天
//            fmt.dateFormat = @"昨天 HH:mm";
//            _created_at = [fmt stringFromDate:creatDate];
//        }else if([creatDate isToday]){//今天
//            if (cmps.hour >= 1) {
//                _created_at = [NSString stringWithFormat:@"%ld小时前",(long)cmps.hour];
//            }else if (cmps.minute >= 1){
//                _created_at = [NSString stringWithFormat:@"%ld分钟前",(long)cmps.minute];
//            }else{
//                _created_at = @"刚刚";
//            }
//        }else{//今年的其他日子
//            fmt.dateFormat = @"MM-dd HH:mm";
//            _created_at = [fmt stringFromDate:creatDate];
//        }
//    }else{//非今年
//        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
//        _created_at = [fmt stringFromDate:creatDate];
//    }
//    
//    
//}

/**
 *  重写get方法
 *
 *  @return 时间
 */
- (NSString *)created_at
{
//今年
//今天
    //一分钟之内的 刚刚
    //一分钟到五十九分钟内 xx分钟前
    //大于60分钟  xx小时前
//昨天
    //昨天 xx:xx
    //xx-xx xx:xx
    
//不是今年
    //xxxx-xx-xx xx:xx
    
    
    
    
    
    // 设置日期格式（声明字符串里面每个数字和单词的含义）
    // E:星期几
    // M:月份
    // d:几号(这个月的第几天)
    // H:24小时制的小时
    // m:分钟
    // s:秒
    // y:年
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    //如果是真机 转换这种欧美时间 需要设置locale
    fmt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    
    //设置日期格式 （声明字符串每个数字单词的含义）
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    
    //微博的创建日期
    NSDate *creatDate = [fmt dateFromString:_created_at];
    
    //当前时间
    NSDate *now = [NSDate date];
    
    //日历对象 方便比较两个日期之间的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //NSCalendarUnit美剧代表想获得那些差值
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    //计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:creatDate toDate:now options:0];
    
//    //获得某个时间的年月日时分秒
//    NSDateComponents *createDateCmps = [calendar components:unit fromDate:creatDate];
//    NSDateComponents *nowDateCmps = [calendar components:unit fromDate:now];
//    createDateCmps.year = nowDateCmps.year;
    
    
    if ([creatDate isThisYear]) {//今年
        if ([creatDate isYesterday]) {//昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:creatDate];
        }else if([creatDate isToday]){//今天
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%d小时前",(int)cmps.hour];
            }else if (cmps.minute >= 1){
                return [NSString stringWithFormat:@"%d分钟前",(int)cmps.minute];
            }else{
                return @"刚刚";
            }
        }else{//今年的其他日子
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:creatDate];
        }
    }else{//非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:creatDate];
    }
    
}



//- (BOOL)isThisYear:(NSDate *)date
//{
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSCalendarUnit unit = NSCalendarUnitYear;
//    
//    //获得某个时间的年月日时分秒
//    NSDateComponents *createDateCmps = [calendar components:unit fromDate:date];
//    NSDateComponents *nowDateCmps = [calendar components:unit fromDate:[NSDate date]];
//    return createDateCmps.year = nowDateCmps.year;
//}
//
//- (BOOL )isYesterday:(NSDate *)date
//{
//    
//    NSDate *now = [NSDate date];
//    
//    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
//    fmt.dateFormat = @"yyyy-MM-dd";
//    
//    NSString *dateStr = [fmt stringFromDate:date];
//    
//    NSString *nowStr = [fmt stringFromDate:now];
//    
//    date = [fmt dateFromString:dateStr];
//    
//    now = [fmt dateFromString:nowStr];
//    
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    
//    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
//    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
//    
//    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
//    
//}
//
//
//
//- (BOOL )isToday:(NSDate *)date
//{
//    
//    NSDate *now = [NSDate date];
//    
//    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
//    fmt.dateFormat = @"yyyy-MM-dd";
//    
//    NSString *dateStr = [fmt stringFromDate:date];
//    
//    NSString *nowStr = [fmt stringFromDate:now];
//    
//    return [dateStr isEqualToString:nowStr];
//    
//}



@end
