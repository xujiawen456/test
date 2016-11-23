//
//  YlwlBeaconManager.h
//  BeaconCFG
//
//  Created by Shengguo Gao on 15/9/30.
//  Copyright (c) 2015年 YLWL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@class YlwlBeacon;

@protocol YlwlBeaconManagerDelegate <NSObject>

@optional

- (void)didDiscoverBeacon:(YlwlBeacon *)beacon;

- (void)didConnectBeacon:(YlwlBeacon *)beacon;

- (void)didDisconnectBeacon:(YlwlBeacon *)beacon;

- (void)didFailToConnectBeacon:(YlwlBeacon *)beacon;

@end


@interface YlwlBeaconManager : NSObject

@property id<YlwlBeaconManagerDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *beacons;

+ (YlwlBeaconManager *)sharedInstance;

- (void)startScanBeacons;

- (void)stopScanBeacons;

- (void)connectBeacon:(YlwlBeacon*) beacon;

- (void)disconnectBeacon:(YlwlBeacon*) beacon;

@end
