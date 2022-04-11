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
        case .ATTrackingManager:
            return AppTrackingPermission()
        case .AVCaptureDevice(type: let type):
            return AVCaptureDevicePermission(type: type)
        case .AVAudioSession:
            return AVAudioSessionPermission()
        case .CBPeripheralManager:
            return CBPeripheralManagerPermission()
        case .CLLocationManager:
            return CLLocationManagerPermission()
        case .CNContactStore:
            return CNContactStorePermission()
        case .EKEventStore(type: let type):
            return EKEventStorePermission(type: type)
        case .INPreferences:
            return INPreferencesPermission()
        case .MotionManager:
            return MotionManagerPermission()
        case .MPMediaLibrary:
            return MPMediaLibraryPermission()
        case .PHPhotoLibrary:
            return PHPhotoLibraryPermission()
        case .SFSpeechRecognizer:
            return SFSpeechRecognizerPermission()
        case .UNUserNotificationCenter(options: let options):
            return CheckNotificationPermission(notificationOption: options)
        }
    }
}
