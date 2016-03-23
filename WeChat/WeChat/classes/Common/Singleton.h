//
//  Singleton.h
//  WeChat
//
//  Created by 赵宏亚 on 16/3/21.
//  Copyright © 2016年 赵宏亚. All rights reserved.
//

// 帮助实现单例设计模式

//.h文件的实现
#define SingletionH(methodName) + (instancetype)shared##methodName;

//.m文件的实现
#if __has_feature(objc_arc) //是ARC

#define SingletonM(methodName) \
static id _instance = nil;\
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone {\
\
if (_instance == nil) {\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
}\
return _instance;\
}\
\
- (instancetype)init {\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super init];\
});\
\
return _instance;\
}\
\
+ (instancetype)shared##methodName {\
return [[self alloc] init];\
}

#else //不是ARC

#define SingletonM(methodName) \
static id _instance = nil;\
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone {\
\
if (_instance == nil) {\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
}\
return _instance;\
}\
\
- (instancetype)init {\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super init];\
});\
\
return _instance;\
}\
\
+ (instancetype)shared##methodName {\
return [[self alloc] init];\
}\
\
- (oneway void)release {\
\
}\
\
- (instancetype)retain {\
return self;\
}\
\
- (NSUInteger)retainCount {\
return 1;\
}
#endif