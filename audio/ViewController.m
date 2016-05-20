//
//  ViewController.m
//  audio
//
//  Created by patty on 16/5/20.
//  Copyright © 2016年 patty. All rights reserved.
//

#import "ViewController.h"
#import "Mp3Recorder.h"
#import "UUAVAudioPlayer.h"

@interface ViewController ()<Mp3RecorderDelegate>
@property (nonatomic,strong) Mp3Recorder *mp3Recorder;
@property (nonatomic,strong) UUAVAudioPlayer *audioPlayer;
@property (nonatomic,strong) NSTimer *playTimer;
@property (nonatomic,assign) NSInteger playTime;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    //录音
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 80, 80)];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(click1) forControlEvents:UIControlEventTouchUpInside];
    
    //播放
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 80, 80)];
    btn2.backgroundColor = [UIColor greenColor];
    [self.view addSubview:btn2];
    [btn2 addTarget:self action:@selector(click2) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)initData
{
     self.mp3Recorder = [[Mp3Recorder alloc]initWithDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//开始录音
- (void)click1
{
    [self.mp3Recorder startRecord];
    self.playTime = 0;
    self.playTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countVoiceTime) userInfo:nil repeats:YES];
}

//开始播放
- (void)click2
{
    
    
}

//录音时间
- (void)countVoiceTime
{
    self.playTime ++;
    if (self.playTime > 5) {
        [self endRecordVoice];
    }
}

//结束录音
- (void)endRecordVoice
{
    if (self.playTimer) {
        [self.mp3Recorder stopRecord];
        [self.playTimer invalidate];
        self.playTimer = nil;
    }
}

#pragma mark -录音回调
- (void)endConvertWithData:(NSData *)voiceData
{
   self.audioPlayer = [UUAVAudioPlayer sharedInstance];
//    self.audioPlayer.delegate = self;
    [self.audioPlayer playSongWithData:voiceData];
}


@end
