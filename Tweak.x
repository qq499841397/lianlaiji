%hook LNUserJointVIPInfo

- (BOOL)is_diamond_vip {
    return YES;
}

- (void)setIs_diamond_vip:(BOOL)isDiamondVip {
    %orig(YES);
}

- (BOOL)diamond_vip_is_forever {
    return YES;
}

- (void)setDiamond_vip_is_forever:(BOOL)isForever {
    %orig(YES);
}

%end
