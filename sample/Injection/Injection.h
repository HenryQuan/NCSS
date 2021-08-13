//
//  Injection.h
//  Injection
//
//  Created by Yiheng Quan on 27/9/20.
//

#import <Foundation/Foundation.h>
#import "../../vm_tools/vm_tool.h"

NS_ASSUME_NONNULL_BEGIN

@interface Injection : NSObject

+(void)inject;
+(void)loadPref;
+(void)test;

@end

NS_ASSUME_NONNULL_END
