#import <Foundation/Foundation.h>
#import "helper/SearchKit.h"
#import "helper/vm_writeData.h"

@interface NSUserDefaults (Tweak_Category)
- (id)objectForKey:(NSString *)key inDomain:(NSString *)domain;
- (void)setObject:(id)value forKey:(NSString *)key inDomain:(NSString *)domain;
@end

static NSString * nsDomainString = @"org.github.henryquan.zhao";
static NSString * nsNotificationString = @"pref.changed";
static BOOL enabled;

static void notificationCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	NSNumber * enabledValue = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"enabled" inDomain:nsDomainString];
	enabled = (enabledValue) ? [enabledValue boolValue] : YES;
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
	mach_port_t task = mach_task_self();

	vm_address_t base;
	vm_address_t end;

	get_region_size(task, &base, &end);

	NSLog(@"addr range: 0x%lx - 0x%lx\n", base, end);
	NSLog(@"Testing logs");
	NSLog(@"offset is 0x%llx", get_slide());
}
