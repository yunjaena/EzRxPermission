//
//  PermissionType.swift
//  EzRxPermission
//
//  Created by EE201201 on 2022/03/30.
//

import Foundation
import RxSwift

public enum PermissionType {
    case AVCaptureDevice
    case PHPhotoLibrary
    case AVAudioSession
    case ATTrackingManager
    case UNUserNotificationCenter(options: NotificationOption?)
}
