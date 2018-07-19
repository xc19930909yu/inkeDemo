//
//  SXTLiveCell.m
//  InkePlayer
//
//  Created by 徐超 on 2018/7/18.
//  Copyright © 2018年 sd. All rights reserved.
//

#import "SXTLiveCell.h"
#import "UIImageView+SDWebImage.h"

@interface SXTLiveCell()

@property (weak, nonatomic) IBOutlet UIImageView *headView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *onlineLabel;

@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;


@end

@implementation SXTLiveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.headView.layer.cornerRadius = 25;
    
    self.headView.layer.masksToBounds = YES;
    // Initialization code
}


- (void)setLive:(SXTLive *)live{
    
    _live = live;
    if ([live.creator.portrait hasPrefix:@"http"]) {
        [self.headView downloadImage:[NSString stringWithFormat:@"%@",live.creator.portrait] placeholder:@"default_room"];
        
        [self.bigImageView downloadImage:[NSString stringWithFormat:@"%@", live.creator.portrait] placeholder:@"default_room"];
        
    }else{
        
        [self.headView downloadImage:[NSString stringWithFormat:@"%@%@", IMAGE_HOST,live.creator.portrait] placeholder:@"default_room"];
        
        [self.bigImageView downloadImage:[NSString stringWithFormat:@"%@%@", IMAGE_HOST,live.creator.portrait] placeholder:@"default_room"];
    }
    
    self.nameLabel.text = live.creator.nick;
    self.addressLabel.text = live.city;
    self.onlineLabel.text = [@(live.onlineUsers) stringValue];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
