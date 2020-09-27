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
    vm_address_t address = vm_searchData("2A0500B1E8779F1AEA2F00F9", [AppTool getBinarySize]);
    vm_writeData("2A9D0FB1", address);
}

@end
