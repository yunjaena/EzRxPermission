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
        case .AVCaptureDevice:
            break
        case .PHPhotoLibrary:
            break
        case .AVAudioSession:
            break
        case .ATTrackingManager:
            break
        case .UNUserNotificationCenter(options: let options):
            return UNUserNotificationCenterPermission(notificationOption: options)
        }

        return EmptyPermission()
    }
}
