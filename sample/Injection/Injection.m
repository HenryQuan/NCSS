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
//    vm_address_t address = vm_searchDataEx("2A0500B1E8779F1AEA2F00F9");
//    vm_writeData("2A9D0FB1", address);
}

+(void)loadPref
{
//    NSDictionary *pref = [NSDictionary dictionaryWithContentsOfFile:@PLIST_PATH];
//    BOOL score = [[pref valueForKey:@"enabled"] boolValue];
//    NSLog(@"Score is %d", score);
}

+(void)test
{
    const int size = 5;
    Module a[size] = {
        { 0x100008a24, "", "2A0500B1E8779F1AEA2F00F9", "2A9D0FB1",  0 },
        { 0, "", "2A0500B1E8779F1AEA2F00F9", "2A9D0FB1", 0 },
        { 0, "", "EACD", "1234", 0 },
        { 0, "", "EACD", "5321", 0 },
        { 0, "", "EACD", "1234", 0 },
    };
    
    vm_searchDataEx((Module *)&a, size);
    vm_readData((Module *)&a, size);
    Module one = a[0];
    vm_writeData(one, true);
    Module two = a[1];
    vm_writeData(two, true);
//    vm_writeData(one, false);
}

@end
