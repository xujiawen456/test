//
//  ViewController.m
//  test
//
//  Created by czy on 16/11/1.
//  Copyright © 2016年 czy. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreBluetooth/CBService.h>
#import <CoreBluetooth/CBCharacteristic.h>

#import <CoreLocation/CoreLocation.h>

#import "ACBle.h"
@interface ViewController ()<UIDocumentInteractionControllerDelegate,CBCentralManagerDelegate, CBPeripheralDelegate,CBPeripheralManagerDelegate,CLLocationManagerDelegate>{
    NSString *localPath;
}
@property (strong,nonatomic) UIDocumentInteractionController * dVC;
@property (strong,nonatomic) CBCentralManager *centralManager;
@property (nonatomic,strong) CBPeripheralManager *peripheraManager;
@property (nonatomic,strong) CBMutableCharacteristic *customCharacteristic;
@property (nonatomic,strong) CBMutableService *customService;

@property (strong,nonatomic) CLLocationManager * locationmanager;
@property (strong, nonatomic) CLBeaconRegion *beacon1;//被扫描的iBeacon

@property (strong,nonatomic) ACBle *test;
@end
static NSString *const kServiceUUID = @"FDA50693-A4E2-4FB1-AFCF-C6EB07647825";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"预览Demo";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor blueColor];
    NSString *pdfPath = [[NSBundle mainBundle]pathForResource:@"sample" ofType:@"pdf"];
    NSData *pdfData=[NSData dataWithContentsOfFile:pdfPath];
    //NSLog(@"%@",pdfData);
    
    localPath = [NSTemporaryDirectory() stringByAppendingPathComponent:pdfPath.lastPathComponent];
    [pdfData writeToFile:localPath atomically:YES];
    
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(60, 60, 100, 50)];
    [btn addTarget:self action:@selector(preView) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"点击预览" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:btn];
    
    _test=[[ACBle alloc]init];
    
//    NSLog(@"1"); // 任务1
//    dispatch_sync(dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT), ^{
//        NSLog(@"2"); // 任务2
//    });
//    NSLog(@"3");
}
- (void)preView{
    
    [_test initManager:nil];
    [_test scan:nil];
//    NSURL * url = [NSURL fileURLWithPath:localPath];
//    _dVC = [UIDocumentInteractionController interactionControllerWithURL:url];
//    _dVC.delegate = self;
//    [_dVC presentPreviewAnimated:YES];
    //NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:@"FDA50693-A4E2-4FB1-AFCF-C6EB07647825"];
    //_centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
//    _peripheraManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
//    CBUUID *characteristicUUID = [CBUUID UUIDWithString:@"EEC65D7D-173B-43A6-9C1A-3557CB032303"];
//    self.customCharacteristic = [[CBMutableCharacteristic alloc] initWithType:
//                                 
//                                 characteristicUUID properties:CBCharacteristicPropertyNotify
//                                 
//                                                                        value:nil permissions:CBAttributePermissionsReadable];
//    
//    // Creates the service UUID
//    
//    CBUUID *serviceUUID = [CBUUID UUIDWithString:kServiceUUID];
//    
//    // Creates the service and adds the characteristic to it
//    
//    self.customService = [[CBMutableService alloc] initWithType:serviceUUID
//                          
//                                                        primary:YES];
//    
//    // Sets the characteristics for this service
//    
//    [self.customService setCharacteristics:
//     
//  @[self.customCharacteristic]];
//    
//    // Publishes the service
//    
//    [self.peripheraManager addService:self.customService];
    
//    self.locationmanager = [[CLLocationManager alloc] init];//初始化
//    
//    self.locationmanager.delegate = self;
    
    //[self.locationmanager requestAlwaysAuthorization];//设置location是一直允许
    

    //self.beacon1 = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"FDA50693-A4E2-4FB1-AFCF-C6EB07647825"] identifier:@"YlwlBeaconID"];//初始化监测的iBeacon信息
    
//    self.beacon1 = [[CLBeaconRegion alloc]initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"FDA50693-A4E2-4FB1-AFCF-C6EB07647825"] major:10001 minor:19641 identifier:@"MiniBeacon_17324"];
//    
//    [self.locationmanager startMonitoringForRegion:self.beacon1];
}
#pragma mark - UIDocumentInteractionControllerDelegate -
-(UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
    return self.navigationController;
}
- (void)documentInteractionControllerDidEndPreview:(UIDocumentInteractionController *)controller{
    
}
- (void)documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController *)controller{
    
}
- (void)documentInteractionControllerWillPresentOpenInMenu:(UIDocumentInteractionController *)controller{
    
}
- (void)documentInteractionControllerWillPresentOptionsMenu:(UIDocumentInteractionController *)controller{
    
}
- (void)documentInteractionControllerDidDismissOptionsMenu:(UIDocumentInteractionController *)controller{
}
- (void)documentInteractionController:(UIDocumentInteractionController *)controller didEndSendingToApplication:(nullable NSString *)application{
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CBCentralManagerDelegate -

//初始化中心设备管理器时返回其状态
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    //[self initManagerCallback:central.state];
    NSLog(@"%d",central.state);
    switch (central.state) {
            case CBManagerStatePoweredOn:
            [_centralManager scanForPeripheralsWithServices:nil options:nil];
            break;
            default:
            break;
    }
}

//app状态的保存或者恢复，这是第一个被调用的方法当APP进入后台去完成一些蓝牙有关的工作设置，使用这个方法同步app状态通过蓝牙系统
- (void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary<NSString *, id> *)dict {
    
}

//扫描设备的回调，大概每秒十次的频率在重复回调
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI {
    NSLog(@"PeripheralName = %@  UUID = %@",peripheral.name,peripheral.identifier.UUIDString);
    if([peripheral.name isEqualToString:@"9C2000con_17320"]){
        NSUUID *uuid=[[NSUUID alloc]initWithUUIDString:kServiceUUID];
        
        [_centralManager stopScan];
        [_centralManager connectPeripheral:peripheral
                           options:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:CBConnectPeripheralOptionNotifyOnDisconnectionKey]];
    }
    
}

-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    NSLog(@"connect success:%@",peripheral.name);
}
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    
}
-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@"disconnect success:%@",peripheral.name);
}
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error{
    NSLog(@"connect fail:%@",peripheral.name);
}
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error{
    
}
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(nullable NSError *)error{
    
}
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(nullable NSError *)error{
    
}

#pragma mark - CBPeripheralManagerDelegate -
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    NSLog(@"%d",peripheral.state);
}
- (void)peripheralManager:(CBPeripheralManager *)peripheral

            didAddService:(CBService *)service error:(NSError *)error {
    
    if (error == nil) {
        
        // Starts advertising the service
        
        [self.peripheraManager startAdvertising:@{ CBAdvertisementDataLocalNameKey :@"ICServer", CBAdvertisementDataServiceUUIDsKey :@[[CBUUID UUIDWithString:kServiceUUID]] }];
    }
}
-(void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error{
    
}
-(void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic{
    
}

#pragma mark - CLocationDelegate -
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    //if (status == kCLAuthorizationStatusAuthorizedAlways) {
        
        [self.locationmanager startMonitoringForRegion:self.beacon1];//开始MonitoringiBeacon
        
    //}
    
}

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    
    [self.locationmanager startRangingBeaconsInRegion:_beacon1];//开始RegionBeacons
    
}
//找的iBeacon后扫描它的信息

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region{
    
}
@end
