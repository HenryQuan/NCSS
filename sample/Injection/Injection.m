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
    Module a[] = {
        { 200, 100, "EACD", 123 },
        { 200, 100, "ADCE", 123 },
        { 200, 100, "1234", 123 },
        { 200, 100, "5321", 123 },
        { 200, 100, "1234", 123 },
    };
    int size = sizeof(a) / sizeof(a[0]);
    vm_searchData((Module *)&a, size, 100);
}

@end
