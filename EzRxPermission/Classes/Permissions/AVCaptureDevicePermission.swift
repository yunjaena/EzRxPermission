//
//  AVCaptureDevicePermission.swift
//  EzRxPermission
//
//  Created by EE201201 on 2022/03/29.
//

import Foundation
import AVFoundation
import RxSwift

class AVCaptureDevicePermission: PermissionGrant {
    var isGranted: Bool {
        get {
            return AVCaptureDevice.authorizationStatus(for: self.type) ==  .authorized
        }
    }

    let type: AVMediaType

    init(type: AVMediaType) {
        self.type = type
    }

    func requestPermission() -> Observable<PermissionResult> {
        return Observable.create { observer in
            AVCaptureDevice.requestAccess(for: self.type) { granted in
                if granted {
                    observer.onNext(PermissionResult(permission: .AVCaptureDevice(type: self.type), result: .authorized))
                    observer.onCompleted()
                } else {
                    observer.onNext(PermissionResult(permission: .AVCaptureDevice(type: self.type), result: .denied))
                }
            }
            return Disposables.create()
        }
    }
}
