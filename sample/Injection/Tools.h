//
//  Tools.h
//  Injection
//
//  Created by Yiheng Quan on 26/9/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Tools : NSObject

+(NSString *)getAppVersion;
+(unsigned long long)getBinarySize;

@end

NS_ASSUME_NONNULL_END
