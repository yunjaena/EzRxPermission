//
//  CameraPermission.swift
//  EzRxPermission
//
//  Created by EE201201 on 2022/03/29.
//

import Foundation
import AVFoundation
import RxSwift

enum PermissionStatus {
    case granted
    case denied
}

class CheckCameraPermission {
    func getCamerPermission() -> Observable<AVAuthorizationStatus> {
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)

        if authorizationStatus != .notDetermined {
            return Observable.just(authorizationStatus)
        }

        return Observable.create { observer in
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { granted in
                if granted {
                    observer.onNext(.authorized)
                } else {
                    observer.onNext(.notDetermined)
                }
            }
            return Disposables.create()
        }
    }
}
