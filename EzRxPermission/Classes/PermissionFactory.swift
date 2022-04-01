//
//  PermissionFactory.swift
//  EzRxPermission
//
//  Created by EE201201 on 2022/03/30.
//

import Foundation
import RxSwift

class PermissionFactory {
    static func getPermission(permission: PermissionType) -> PermissionGrant {
        switch permission {
        case .AVCaptureDevice(type: let type):
            return AVCaptureDevicePermission(type: type)
        case .PHPhotoLibrary:
            return PHPhotoLibraryPermission()
        case .AVAudioSession:
            return AVAudioSessionPermission()
        case .ATTrackingManager:
            return AppTrackingPermission()
        case .UNUserNotificationCenter(options: let options):
            return CheckNotificationPermission(notificationOption: options)
        case .CBPeripheralManager:
            return CBPeripheralManagerPermission()
        case .CLLocationManager:
            return CLLocationManagerPermission()
        case .CNContactStore:
            return CNContactStorePermission()
        }

        return EmptyPermission()
    }
}
