//
//  SXTNearCollectionCell.m
//  InkePlayer
//
//  Created by 徐超 on 2018/7/18.
//  Copyright © 2018年 sd. All rights reserved.
//

#import "SXTNearCollectionCell.h"
#import "UIImageView+SDWebImage.h"
@interface SXTNearCollectionCell()
@property (weak, nonatomic) IBOutlet UIImageView *headView;

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end

@implementation SXTNearCollectionCell

- (void)setLive:(SXTLive *)live{
    _live = live;
    
    if ([live.creator.portrait hasPrefix:@"http"]) {
         [self.headView downloadImage:[NSString stringWithFormat:@"%@", live.creator.portrait] placeholder:@"default_room"];
    }else{
        
        [self.headView downloadImage:[NSString stringWithFormat:@"%@%@", IMAGE_HOST, live.creator.portrait] placeholder:@"default_room"];
        
    }
    
    
    self.distanceLabel.text = live.distance;
    
}


- (void)showAnimation{
    
    if (self.live.isShow) {
        
        return;
    }
    self.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.layer.transform = CATransform3DMakeScale(1, 1, 1);
        
        self.live.show = YES;
    }];
    
    
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
