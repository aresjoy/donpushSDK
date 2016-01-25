//
//  ViewController.m
//  sampleDonpushSDK
//
//  Created by sungyong on 2015. 12. 9..
//  Copyright © 2015년 sungyong. All rights reserved.
//

#import "ViewController.h"
#import <donpushSDK/donpushSDK.h>



@interface ViewController (){
    UITextView *log;
    
    UITextField *sc, *mb, *nk;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    log = [[UITextView alloc] init];
    [log setFrame:CGRectMake(5, self.view.frame.size.height-210, self.view.frame.size.width-10, 200)];
    [log.layer setBorderColor:[UIColor blackColor].CGColor];
    [log setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:log];
    
    
    UIButton *btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLogin addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [btnLogin setBackgroundColor:[UIColor lightGrayColor]];
    [btnLogin setFrame:CGRectMake(20, 40, 220, 40)];

    if ([[donpushSDK sharedManager] isLogin]) {
        [btnLogin setTitle:[NSString stringWithFormat:@"%@ 로그아웃",[[donpushSDK sharedManager] getEmail]] forState:UIControlStateNormal];
    }else{
        [btnLogin setTitle:@"돈푸시 로그인" forState:UIControlStateNormal];
    }
    
    [btnLogin setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btnLogin];
    
    
    UIButton *btnInfo = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnInfo addTarget:self action:@selector(user_info:) forControlEvents:UIControlEventTouchUpInside];
    [btnInfo setBackgroundColor:[UIColor lightGrayColor]];
    [btnInfo setFrame:CGRectMake(250, 40, 60, 40)];
    [btnInfo setTitle:@"회원정보" forState:UIControlStateNormal];
    [btnInfo.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [btnInfo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btnInfo];
    
    
    UIButton *btnRwd = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnRwd addTarget:self action:@selector(rwd:) forControlEvents:UIControlEventTouchUpInside];
    [btnRwd setBackgroundColor:[UIColor lightGrayColor]];
    [btnRwd setFrame:CGRectMake(20, 100, 250, 40)];
    [btnRwd setTitle:@"랜덤보상 넣어주기" forState:UIControlStateNormal];
    [btnRwd setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btnRwd];

    
    UIButton *btnScore = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnScore addTarget:self action:@selector(score_get:) forControlEvents:UIControlEventTouchUpInside];
    [btnScore setBackgroundColor:[UIColor lightGrayColor]];
    [btnScore setFrame:CGRectMake(20, 150, 250, 40)];
    [btnScore setTitle:@"스코어" forState:UIControlStateNormal];
    [btnScore setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btnScore];
    
    
    UIButton *btnRanking = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnRanking addTarget:self action:@selector(ranking_get:) forControlEvents:UIControlEventTouchUpInside];
    [btnRanking setBackgroundColor:[UIColor lightGrayColor]];
    [btnRanking setFrame:CGRectMake(20, 200, 250, 40)];
    [btnRanking setTitle:@"랭킹" forState:UIControlStateNormal];
    [btnRanking setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btnRanking];
    
    
    sc = [[UITextField alloc] initWithFrame:CGRectMake(20, 250, 70, 40)];
    [sc setBorderStyle:UITextBorderStyleRoundedRect];
    [sc setKeyboardType:UIKeyboardTypeNumberPad];
    [sc setPlaceholder:@"sc"];
    [sc setText:@""];
    [self.view addSubview:sc];

    mb = [[UITextField alloc] initWithFrame:CGRectMake(100, 250, 70, 40)];
    [mb setBorderStyle:UITextBorderStyleRoundedRect];
    [mb setKeyboardType:UIKeyboardTypeNumberPad];
    [mb setPlaceholder:@"mb"];
    [mb setText:@""];
    [self.view addSubview:mb];

    nk = [[UITextField alloc] initWithFrame:CGRectMake(180, 250, 70, 40)];
    [nk setBorderStyle:UITextBorderStyleRoundedRect];
    [nk setPlaceholder:@"닉넴"];
    [nk setText:@""];
    [self.view addSubview:nk];
    
    UIButton *btnPutScore = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnPutScore addTarget:self action:@selector(score_put:) forControlEvents:UIControlEventTouchUpInside];
    [btnPutScore setBackgroundColor:[UIColor lightGrayColor]];
    [btnPutScore setFrame:CGRectMake(260, 250, 100, 40)];
    [btnPutScore setTitle:@"스코어 저장" forState:UIControlStateNormal];
    [btnPutScore setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btnPutScore];
    
    
    UIButton *btnGetDpList = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnGetDpList addTarget:self action:@selector(dp_list_get:) forControlEvents:UIControlEventTouchUpInside];
    [btnGetDpList setBackgroundColor:[UIColor lightGrayColor]];
    [btnGetDpList setFrame:CGRectMake(20, 300, 250, 40)];
    [btnGetDpList setTitle:@"돈푸시 서버목록" forState:UIControlStateNormal];
    [btnGetDpList setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btnGetDpList];
}

- (void)login:(id)sender {
    
    if ([donpushSDK sharedManager].isLogin) {
        
        // 로그아웃
        [[donpushSDK sharedManager] logout];
        
        [(UIButton*)sender setTitle:@"돈푸시 로그인" forState:UIControlStateNormal];
        
    }else{
        
        // 로그인처리
        [[donpushSDK sharedManager] login:^(id JSON) {
            
            [(UIButton*)sender setTitle:[NSString stringWithFormat:@"%@ 로그아웃",[JSON objectForKey:@"email"]] forState:UIControlStateNormal];
            
            [log setText:[NSString stringWithFormat:@"%@",JSON]];
            
        } failBlock:^(id JSON, NSError *error) {
            
            [log setText:[NSString stringWithFormat:@"%@",JSON]];
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"로그인" message:[JSON objectForKey:@"msg"] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
        
                                 }];
            [alert addAction: ok];
            [self presentViewController:alert animated:YES completion:nil];
        }];
    }
}


- (void)rwd:(id)sender {
    [[donpushSDK sharedManager] go_post:^(id JSON) {
        [log setText:[NSString stringWithFormat:@"%@",JSON]];
    } failBlock:^(id JSON, NSError *error) {
        [log setText:[NSString stringWithFormat:@"%@",JSON]];
    }];
    
}

- (void)user_info:(id)sender {
    [[donpushSDK sharedManager] user_info:^(id JSON) {
        [log setText:[NSString stringWithFormat:@"%@",JSON]];
    } failBlock:^(id JSON, NSError *error) {
        [log setText:[NSString stringWithFormat:@"%@",JSON]];
    }];
}

- (void)score_get:(id)sender {
    [[donpushSDK sharedManager] score_get:^(id JSON) {
        [log setText:[NSString stringWithFormat:@"%@",JSON]];
    } failBlock:^(id JSON, NSError *error) {
        [log setText:[NSString stringWithFormat:@"%@",JSON]];
    }];
}



- (void)ranking_get:(id)sender {
    [[donpushSDK sharedManager] ranking_get:^(id JSON) {
        [log setText:[NSString stringWithFormat:@"%@",JSON]];
    } failBlock:^(id JSON, NSError *error) {
        [log setText:[NSString stringWithFormat:@"%@",JSON]];
    }];
}

- (void)score_put:(id)sender {
    [sc resignFirstResponder];
    [mb resignFirstResponder];
    [nk resignFirstResponder];
    
    [[donpushSDK sharedManager] score_put:sc.text mb:mb.text name:nk.text completionBlock:^(id JSON) {
        [log setText:[NSString stringWithFormat:@"%@",JSON]];
    } failBlock:^(id JSON, NSError *error) {
        [log setText:[NSString stringWithFormat:@"%@",JSON]];
    }];
}

- (void)dp_list_get:(id)sender{
    [[donpushSDK sharedManager] dp_list_get:^(id JSON) {
        [log setText:[NSString stringWithFormat:@"%@",JSON]];
    } failBlock:^(id JSON, NSError *error) {
        [log setText:[NSString stringWithFormat:@"%@",JSON]];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [sc resignFirstResponder];
    [mb resignFirstResponder];
    [nk resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
