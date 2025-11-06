//
//  main.m
//  ZephyrApplication
//
//  Created by DF on 10/22/25.
//

#import <Cocoa/Cocoa.h>
#import "global.h"

void restart(void) {
    pid_t pid;
    posix_spawnp(&pid, "killall", NULL, NULL, (char *const[]){ "killall", "Dock", NULL }, environ);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
    }
    return NSApplicationMain(argc, argv);
}
