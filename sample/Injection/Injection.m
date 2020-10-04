//
//  Injection.m
//  Injection
//
//  Created by Yiheng Quan on 27/9/20.
//

#import "Injection.h"

@implementation Injection

+(void)inject
{
//    vm_address_t address = vm_searchData("2A0500B1E8779F1AEA2F00F9", [AppTool getBinarySize]);
//    vm_writeData("2A9D0FB1", address);
}

+(void)loadPref
{
    NSDictionary *pref = [NSDictionary dictionaryWithContentsOfFile:@PLIST_PATH];
    BOOL score = [[pref valueForKey:@"enabled"] boolValue];
    NSLog(@"Score is %d", score);
}

+(void)test
{
    const int size = 5;
    Module a[size] = {
        { 0, "", "EACD", 0 },
        { 0, "", "2A0500B1E8779F1AEA2F00F9", "2A9D0FB1", 0 },
        { 0, "", "EACD", "1234", 0 },
        { 0, "", "EACD", "5321", 0 },
        { 0, "", "EACD", "1234", 0 },
    };
    vm_searchData((Module *)&a, size, [AppTool getBinarySize]);
    Module one = a[1];
    vm_writeData(one, true);
}

@end
