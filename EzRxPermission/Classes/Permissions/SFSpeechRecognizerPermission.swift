//
//  SFSpeechRecognizerPermission.swift
//  EzRxPermission
//
//  Created by EE201201 on 2022/04/01.
//

import Foundation
import Speech
import RxSwift

class SFSpeechRecognizerPermission: PermissionGrant {
    var isGranted: Bool {
        if #available(iOS 10.0, *) {
            return SFSpeechRecognizer.authorizationStatus() == .authorized
        } else {
            return true
        }
    }

    func requestPermission() -> Observable<PermissionResult> {
        return Observable.create { observer in
            if #available(iOS 10.0, *) {
                SFSpeechRecognizer.requestAuthorization { status in
                    var permissionStatus: PermissionStatus
                    switch status {
                    case .authorized:
                        permissionStatus = .authorized
                    default:
                        permissionStatus = .denied
                    }

                    observer.onNext(PermissionResult(permission: .SFSpeechRecognizer, result: permissionStatus))
                    observer.onCompleted()
                }
            } else {
                observer.onNext(PermissionResult(permission: .SFSpeechRecognizer, result: .authorized))
                observer.onCompleted()
            }

            return Disposables.create()
        }
    }
}
