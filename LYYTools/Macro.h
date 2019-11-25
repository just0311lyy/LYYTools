//
//  Macro.h
//  LYYTools
//
//  Created by YangyangLi on 2019/11/25.
//  Copyright © 2019 lyy. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

///////////////////////////////////////////////////////////
// Load Nib
// Note: Load Nib
///////////////////////////////////////////////////////////
#define PSLoadNibView(nibName, index)       [[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil] objectAtIndex:index]

///////////////////////////////////////////////////////////
// 字体定义
// Note: 字体定义
///////////////////////////////////////////////////////////
#define FONT(F)     [UIFont fontWithName:@"HelveticaNeue" size:F]
#define FONT_M(F)   [UIFont fontWithName:@"HelveticaNeue-Medium" size:F]

///////////////////////////////////////////////////////////
// COLOR
// Note: rgb and hex
///////////////////////////////////////////////////////////
#define HEX(c)      [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]
#define RGB(A,B,C)  [UIColor colorWithRed:(A)/255.0 green:(B)/255.0 blue:(C)/255.0 alpha:1.0]
#define HEXA(c, a)  [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:a];


///////////////////////////////////////////////////////////
// STRING
// Note:safe string
///////////////////////////////////////////////////////////
#define PSSafeString(string)    ((string)==nil||[string isEqual:[NSNull null]]) ? @"" : string
#define PSSafeArray(arrayList)  (arrayList==nil || [arrayList isEqual:[NSNull null]]) ? [NSArray array] : arrayList
#define PSString(A)             [@(A) stringValue]


///////////////////////////////////////////////////////////
// path
// Note: path
///////////////////////////////////////////////////////////
#define PATH_DOCUMENTS          [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define PATH_LIBRARIES          [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define PATH_DOWNLOADS          [NSSearchPathForDirectoriesInDomains(NSDownloadsDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define PATH_CACHES             [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define PATH_HOME               NSHomeDirectory()

///////////////////////////////////////////////////////////
// SCREEN
// Note: SCREEN
///////////////////////////////////////////////////////////

#define SCREEN_WIDTH            [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT           [UIScreen mainScreen].bounds.size.height

///////////////////////////////////////////////////////////
// SYSTEM_VERSION
// Note: SYSTEM_VERSION
///////////////////////////////////////////////////////////
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

///////////////////////////////////////////////////////////
// device
// Note:device
///////////////////////////////////////////////////////////

#define DEVICE_IS_IPAD          ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define DEVICE_IS_LANDSCAPE     ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || \
[[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight)
#define DEVICE_IS_IPHONE6PLUS    (!DEVICE_IS_IPAD && (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")?[[UIScreen mainScreen] nativeScale] == 3.0f:NO))

///////////////////////////////////////////////////////////
// DEBUG LOG
// Note: debug log
///////////////////////////////////////////////////////////
#define XCODE_COLORS_ESCAPE_MAC @"\033["
#define XCODE_COLORS_ESCAPE     XCODE_COLORS_ESCAPE_MAC
#define XCODE_COLORS_RESET_FG   XCODE_COLORS_ESCAPE @"fg;" // Clear any foreground color
#define XCODE_COLORS_RESET_BG   XCODE_COLORS_ESCAPE @"bg;" // Clear any background color
#define XCODE_COLORS_RESET      XCODE_COLORS_ESCAPE @";"  // Clear any foreground or background color

#ifdef DEBUG

#define DLogBlue(frmt, ...)     NSLog((XCODE_COLORS_ESCAPE @"fg0,0,255;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define DLogRed(frmt, ...)      NSLog((XCODE_COLORS_ESCAPE @"fg255,0,0;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)

#define DLog(format, ...) do {\
NSLog(@"\033[fg0,0,255;<%@:%d %s> \033[fg255,0,0;" format @"\033[;", \
[[NSString stringWithUTF8String:__FILE__] lastPathComponent],__LINE__,__FUNCTION__,##__VA_ARGS__);\
} while (0)

#else

#define DLog(format, ...)

#define DLogBlue(frmt, ...)
#define DLogRed(frmt, ...)

#endif

#endif /* Macro_h */
