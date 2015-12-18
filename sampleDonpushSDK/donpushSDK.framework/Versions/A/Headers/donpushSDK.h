//
//  donpushSDK.h
//  donpushSDK
//
//  Created by sungyong on 2015. 12. 14..
//  Copyright © 2015년 sungyong. All rights reserved.
//

#import <Foundation/Foundation.h>


#define DONPUSH_SDK_VERSION @"0.9.3"

@interface donpushSDK : NSObject

+(instancetype) sharedManager;

// 앱key등록
- (void)setKey:(NSString *)key;

// 로그인상태인지?
- (BOOL)isLogin;

// 로그인하기
- (void)login:(void (^)(id JSON))completionBlock failBlock:(void (^)(id JSON))failBlock;

// 로그인콜백
- (BOOL)isLoginCallback:(NSURL *)url;

// 로그아웃
- (void)logout;

// 닉네임,현재금액
- (void)user_info:(void (^)(id JSON))completionBlock failBlock:(void (^)(id JSON))failBlock;

// 랜덤보상 넣어주기
- (void)go_post:(void (^)(id JSON))completionBlock failBlock:(void (^)(id JSON))failBlock;

// 스코어 정보 가져오기
- (void)score_get:(void (^)(id JSON))completionBlock failBlock:(void (^)(id JSON))failBlock;

// 내 점수 등록
// sc : 현재 score
// mb : my best 점수
// name : 닉네임
- (void)score_put:(NSString*)sc mb:(NSString*)mb name:(NSString*)name completionBlock:(void (^)(id JSON))completionBlock failBlock:(void (^)(id JSON))failBlock;

// 랭킹 리스트
- (void)ranking_get:(void (^)(id JSON))completionBlock failBlock:(void (^)(id JSON))failBlock;

@property (nonatomic, strong, readonly) NSString *email;  // 로그인한 돈푸시 이메일
//@property (nonatomic, assign) BOOL isLog;      // 로그출력.

@end
