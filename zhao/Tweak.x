#import "helper/Tools.h"
#import "helper/vm_tool.h"

@interface NSUserDefaults (Tweak_Category)
- (id)objectForKey:(NSString *)key inDomain:(NSString *)domain;
- (void)setObject:(id)value forKey:(NSString *)key inDomain:(NSString *)domain;
@end

static NSString * nsDomainString = @"org.github.henryquan.zhao";
static NSString * nsNotificationString = @"pref.changed";
static vm_address_t addOne = 0;
static BOOL enabled;

static void notificationCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	NSNumber * enabledValue = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"enabled" inDomain:nsDomainString];
	enabled = (enabledValue) ? [enabledValue boolValue] : YES;

	if (enabled) {
		vm_writeData(addOne, 0x2A0900B1);
	} else {
		vm_writeData(addOne, 0x2A0500B1);
	}
}

%ctor {
	// Set variables on start up
	notificationCallback(NULL, NULL, NULL, NULL, NULL);

	// Register for 'PostNotification' notifications
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), 
									NULL, 
									notificationCallback, 
									(CFStringRef)nsNotificationString, NULL, CFNotificationSuspensionBehaviorCoalesce);

	// Add any personal initializations
	addOne = vm_searchData("2A0500B1E8779F1AEA2F00F9", [Tools getBinarySize]);
    NSLog(@"Address: 0x%lx", addOne);
}
