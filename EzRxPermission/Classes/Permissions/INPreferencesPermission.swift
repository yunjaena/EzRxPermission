//
//  INPreferencesPermission.swift
//  EzRxPermission
//
//  Created by EE201201 on 2022/04/04.
//

import Foundation
import Intents
import RxSwift

class INPreferencesPermission: PermissionGrant {
    var isGranted: Bool {
        if #available(iOS 10.0, *) {
            return INPreferences.siriAuthorizationStatus() == .authorized
        } else {
            return true
        }
    }

    func requestPermission() -> Observable<PermissionResult> {
        return Observable.create { observer in
            if #available(iOS 10.0, *) {
                INPreferences.requestSiriAuthorization { status in
                    switch status {
                    case .authorized:
                        observer.onNext(PermissionResult(permission: .INPreferences, result: .authorized))
                        observer.onCompleted()
                    default:
                        observer.onNext(PermissionResult(permission: .INPreferences, result: .denied))
                        observer.onCompleted()
                    }
                }
            } else {
                observer.onNext(PermissionResult(permission: .INPreferences, result: .authorized))
                observer.onCompleted()
            }

            return Disposables.create()
        }
    }
}
