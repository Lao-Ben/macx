//
//  CKImageView.m
//  Cookie
//
//  Created by Irenicus on 08/07/12.
//  Copyright (c) 2012 3IE. All rights reserved.
//

#import "CKImageView.h"

@implementation CKImageView
- (void)mouseDown:(NSEvent *)event {
    
    if ([[self target] respondsToSelector:[self action]]) {
        [NSApp sendAction:[self action] to:[self target] from:self];
    }
}
@end
