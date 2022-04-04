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
    case AVCaptureDevice(type: AVMediaType)
    case CBPeripheralManager
    case CLLocationManager
    case CNContactStore
    case EKEventStore(type: EKEntityType)
    case INPreferences
    case MotionManager
    case MPMediaLibrary
    case PHPhotoLibrary
    case SFSpeechRecognizer
    case UNUserNotificationCenter(options: NotificationOption?)
}


extension PermissionType {
    public var request : Observable<PermissionResult> {
        return PermissionFactory.getPermission(permission: self).requestPermission()
    }
}
