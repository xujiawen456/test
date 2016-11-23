//
//  YlwlBeacon.h
//  BeaconCFG
//
//  Created by Shengguo Gao on 15/9/30.
//  Copyright (c) 2015年 YLWL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>


typedef void (^YlwlBeaconCompletionBlock)(NSError *error);

@protocol YlwlBeaconDelegate <NSObject>

@optional

- (void)discoveredAllServices;

@end


@interface YlwlBeacon : NSObject

@property (nonatomic, strong) CBPeripheral *peripheral;

@property (nonatomic, strong) NSString *UUIDString;

@property (nonatomic, assign) int major;

@property (nonatomic, assign) int minor;

@property (nonatomic, assign) int advDataTxPowerLevel;

@property (nonatomic, assign) int batteryLevel;

@property (nonatomic, assign, getter=isConnectable) BOOL connectable;

@property (nonatomic, assign, getter=isConnected) BOOL connected;

@property (nonatomic, assign) int RSSI;

@property (nonatomic, assign) float distance;

@property (nonatomic, assign) int checkDistance;

@property (nonatomic, assign) int broadcastPower;

@property (nonatomic, assign) int broadcastInterval;

@property (nonatomic, assign) int serialNumber;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) int connectMode;

@property (nonatomic, strong) NSArray *systemInfos;

//@property (nonatomic, copy) NSString * firmwareVersion;

@property (nonatomic, weak) id<YlwlBeaconDelegate> delegate;

- (void)didConnect;

- (void)didDisconnect;

- (void)writeUUIDString:(NSString *)UUIDString completion:(YlwlBeaconCompletionBlock)completion;

- (void)writeMajor:(int)major completion:(YlwlBeaconCompletionBlock)completion;

- (void)writeMinor:(int)minor completion:(YlwlBeaconCompletionBlock)completion;

- (void)writeCheckDistance:(int)checkDistance completion:(YlwlBeaconCompletionBlock)completion;

- (void)writeBroadcastPower:(int)broadcastPower completion:(YlwlBeaconCompletionBlock)completion;

- (void)writeBroadcastInterval:(int)broadcastInterval completion:(YlwlBeaconCompletionBlock)completion;

- (void)writeSerialNumber:(int)serialNumber completion:(YlwlBeaconCompletionBlock)completion;

- (void)writeName:(NSString *)name completion:(YlwlBeaconCompletionBlock)completion;

- (void)writeConnectMode:(int)connectMode completion:(YlwlBeaconCompletionBlock)completion;

- (void)resetPassword:(NSString *)password completion:(YlwlBeaconCompletionBlock)completion;

- (void)rebootBeaconWithPassword:(NSString *)password completion:(YlwlBeaconCompletionBlock)completion;

@end
