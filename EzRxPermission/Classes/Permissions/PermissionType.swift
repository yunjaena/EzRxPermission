//
//  PermissionType.swift
//  EzRxPermission
//
//  Created by EE201201 on 2022/03/30.
//

import Foundation
import RxSwift
import AVFoundation

public enum PermissionType {
    case AVCaptureDevice(type: AVMediaType)
    case PHPhotoLibrary
    case AVAudioSession
    case ATTrackingManager
    case CBPeripheralManager
    case CLLocationManager
    case CNContactStore
    case UNUserNotificationCenter(options: NotificationOption?)
}


extension PermissionType {
    public var request : Observable<PermissionResult> {
        return PermissionFactory.getPermission(permission: self).requestPermission()
    }
}
