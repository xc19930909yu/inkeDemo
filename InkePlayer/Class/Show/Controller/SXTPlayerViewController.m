//
//  SXTPlayerViewController.m
//  InkePlayer
//
//  Created by 徐超 on 2018/7/18.
//  Copyright © 2018年 sd. All rights reserved.
//

#import "SXTPlayerViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "UIImageView+SDWebImage.h"
#import "AppDelegate.h"
#import "SXTChatViewController.h"
@interface SXTPlayerViewController ()


@property(atomic, retain) id<IJKMediaPlayback> player;

@property (nonatomic, strong) UIImageView * loadBlurImage;


@property (nonatomic, strong) UIButton * closeBtn;


@property(nonatomic, strong)SXTChatViewController *liveChatVc;

@end

@implementation SXTPlayerViewController


- (SXTChatViewController*)liveChatVc{
    
    if (!_liveChatVc) {
        
        _liveChatVc = [[SXTChatViewController alloc] init];
    }
    
    return  _liveChatVc;
}

- (UIButton *)closeBtn{
    
    if (!_closeBtn) {
        
        UIImage *image = [UIImage imageNamed:@"mg_room_btn_guan_h"];
        
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_closeBtn setImage:image forState:UIControlStateNormal];
        
        _closeBtn.frame = CGRectMake(SCREEN_WIDTH - image.size.width - 10, SCREEN_HEIGHT - image.size.height - 10, image.size.width, image.size.height);
        
        [_closeBtn addTarget:self action:@selector(closeLive:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return  _closeBtn;
}


- (void)closeLive:(UIButton*)button{
    
    
    [self.liveChatVc cancelTimer];
    [self.navigationController popViewControllerAnimated:YES];

    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initPlayer];
    
    [self initUI];
    
    [self addChildVC];
    // Do any additional setup after loading the view.
}

- (void)initUI{
    self.view.backgroundColor = [UIColor blackColor];
    
    [self initBlurImage];
    
    
}

- (void)initBlurImage{
    // 添加图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.loadBlurImage  = imageView;
    
    if ([self.live.creator.portrait hasPrefix:@"http"]) {
         [imageView downloadImage:[NSString stringWithFormat:@"%@", self.live.creator.portrait] placeholder:@"default_room"];
    }else{
        [imageView downloadImage:[NSString stringWithFormat:@"%@%@",IMAGE_HOST, self.live.creator.portrait] placeholder:@"default_room"];
        
    }
    
    [self.view addSubview:imageView];
    
    // 创建需要的毛玻璃特效类型
    UIBlurEffect *bluEfft = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    
    // 毛玻璃view视图
    UIVisualEffectView *efftView = [[UIVisualEffectView alloc] initWithEffect:bluEfft];
    
    // 添加到要有毛玻璃特效的空间中
    efftView.frame = imageView.bounds;
    
    [imageView addSubview:efftView];
    
}


// 自控制器
- (void)addChildVC{
    
    [self addChildViewController:self.liveChatVc];
    
    
    
    [self.view addSubview:self.liveChatVc.view];
    
    
    
    [self.liveChatVc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
    }];
    
    
    self.liveChatVc.live = self.live;
    
    
}


- (void)initPlayer{
    
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    
    self.player = [[IJKFFMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:self.live.streamAddr] withOptions:options];
    
    self.player.view.frame = self.view.bounds;
    
    self.player.shouldAutoplay = YES;
    
    [self.view addSubview:self.player.view];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;

    //注册直播需要用的通知
    [self installMovieNotificationObservers];
    
    // 准备播放
    [self.player prepareToPlay];
    
    UIWindow * window = [(AppDelegate *)[UIApplication sharedApplication].delegate window];
    [window addSubview:self.closeBtn];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    // 关闭直播
    [self.player shutdown];
    
    [self removeMovieNotificationObservers];
    
    [self.closeBtn removeFromSuperview];
}


- (void)loadStateDidChange:(NSNotification*)notification
{
    //    MPMovieLoadStateUnknown        = 0,
    //    MPMovieLoadStatePlayable       = 1 << 0,
    //    MPMovieLoadStatePlaythroughOK  = 1 << 1, // Playback will be automatically started in this state when shouldAutoplay is YES
    //    MPMovieLoadStateStalled        = 1 << 2, // Playback will be automatically paused in this state, if started
    
    IJKMPMovieLoadState loadState = _player.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStatePlaythroughOK: %d\n", (int)loadState);
    } else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}

- (void)moviePlayBackDidFinish:(NSNotification*)notification
{
    //    MPMovieFinishReasonPlaybackEnded,
    //    MPMovieFinishReasonPlaybackError,
    //    MPMovieFinishReasonUserExited
    int reason = [[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    
    switch (reason)
    {
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            break;
            
        default:
            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}

- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification
{
    NSLog(@"mediaIsPreparedToPlayDidChange\n");
}

- (void)moviePlayBackStateDidChange:(NSNotification*)notification
{
    
    //    MPMoviePlaybackStateStopped,
    //    MPMoviePlaybackStatePlaying,
    //    MPMoviePlaybackStatePaused,
    //    MPMoviePlaybackStateInterrupted,
    //    MPMoviePlaybackStateSeekingForward,
    //    MPMoviePlaybackStateSeekingBackward
    
    switch (_player.playbackState)
    {
        case IJKMPMoviePlaybackStateStopped: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePlaying: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePaused: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateInterrupted: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
            break;
        }
        default: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
            break;
        }
    }
    
    self.loadBlurImage.hidden = YES;
    [self.loadBlurImage removeFromSuperview];
}


-(void)installMovieNotificationObservers
{
    
    // 监听缓冲环境，监听网络环境
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_player];
    
    // 监听直播完成回调
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_player];
    
    // 监听用户操作
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];
}

#pragma mark Remove Movie Notification Handlers

/* Remove the movie notification observers from the movie object. */
-(void)removeMovieNotificationObservers
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerLoadStateDidChangeNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackDidFinishNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackStateDidChangeNotification object:_player];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
