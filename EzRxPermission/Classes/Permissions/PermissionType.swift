//
//  PermissionType.swift
//  EzRxPermission
//
//  Created by EE201201 on 2022/03/30.
//

import Foundation
import RxSwift
import AVFoundation
import EventKit

public enum PermissionType {
    case ATTrackingManager
    case AVAudioSession
    case AVCaptureDevice(type: AVMediaType? = nil)
    case CBPeripheralManager
    case CLLocationManager
    case CNContactStore
    case EKEventStore(type: EKEntityType? = nil)
    case INPreferences
    case MotionManager
    case MPMediaLibrary
    case PHPhotoLibrary
    case SFSpeechRecognizer
    case UNUserNotificationCenter(options: NotificationOption? = nil)
}


extension PermissionType {
    public var isGranted: Bool {
        return PermissionFactory.getPermission(permission: self).isGranted
    }

    public var request : Observable<PermissionResult> {
        return PermissionFactory.getPermission(permission: self).requestPermission()
    }
}
