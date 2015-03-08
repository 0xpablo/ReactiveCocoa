//
//  UICollectionViewCell+RACSupport.m
//  ReactiveCocoa
//
//  Created by Kent Wong on 2013-10-04.
//  Copyright (c) 2013 GitHub, Inc. All rights reserved.
//

#import "UICollectionViewCell+RACSupport.h"
#import "NSObject+RACDescription.h"
#import "NSObject+RACSelectorSignal.h"
#import "RACSignal+Operations.h"
#import <objc/runtime.h>

@implementation UICollectionViewCell (RACSupport)

- (RACSignal *)rac_prepareForReuseSignal {
	RACSignal *signal = objc_getAssociatedObject(self, _cmd);
	if (signal != nil) return signal;
	
	signal = [[[self
		rac_signalForSelector:@selector(prepareForReuse)]
		mapReplace:nil]
		setNameWithFormat:@"%@ -rac_prepareForReuseSignal", self.rac_description];

	objc_setAssociatedObject(self, _cmd, signal, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	return signal;
}

@end
