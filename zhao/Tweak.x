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
	vm_address_t *out;

    result_t results;

	get_region_size(task, &base, &end);

	NSLog(@"addr range: 0x%lx - 0x%lx\n", base, end);
	NSLog(@"offset is 0x%llx", get_slide());

	// Search for a string
	search_data(task, // task obtained by task_for_pid
                       false, // isString = false - we're not searching for a string (feedfacf)
                       true, // quitOnFirstResult = false - look for SEARCH_MAX (256 default) results
                       base, // base address found by get_region_size
                       end, // end address found by get_region_size
                       &out, // out array found by search_data (256)
                       &results, // out result_t of found number of results (256 max)
                       "44040094880600B1C6060054E80700F9"); // bytes to find - feedfacf (MH_MAGIC_64) in little endian (MH_CIGAM_64)
	
	for (int i=0; i<results; i++) {
        NSlog(@"Result #%d - 0x%lx\n", i, out[i]);
    }
}
