/**
  * APICloud Modules
  * Copyright (c) 2014-2015 by APICloud, Inc. All Rights Reserved.
  * Licensed under the terms of the The MIT License (MIT).
  * Please see the license.html included with this distribution for details.
  */

#import "UZModule.h"

@interface ACBle : UZModule
- (void)initManager:(NSDictionary *)paramsDict_;
- (void)scan:(NSDictionary *)paramsDict_;
@end
