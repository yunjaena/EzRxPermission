//
//  AppTrackingPermission.swift.swift
//  EzRxPermission
//
//  Created by EE201201 on 2022/03/29.
//

import AppTrackingTransparency
import RxSwift

class AppTrackingPermission: PermissionGrant {
    func requestPermission() -> Observable<PermissionResult> {
        return Observable.create { observer in
            if #available(iOS 14.0, *) {
                var requestTrackingAuthorization: DispatchWorkItem?
                requestTrackingAuthorization = DispatchWorkItem(block: {
                    if (requestTrackingAuthorization?.isCancelled == true) {
                        return
                    }
                    ATTrackingManager.requestTrackingAuthorization { status in
                        if(requestTrackingAuthorization?.isCancelled == false) {
                            observer.onNext(PermissionResult(permission: .ATTrackingManager, result: status == .denied ? .denied : .authorized))
                            observer.onCompleted()
                        }
                    }
                })

                if ATTrackingManager.trackingAuthorizationStatus == .notDetermined, let requestTrackingAuthorization = requestTrackingAuthorization {
                    // https://developer.apple.com/forums/thread/690607
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: requestTrackingAuthorization)
                } else {
                    observer.onNext(PermissionResult(permission: .ATTrackingManager, result: .authorized))
                    observer.onCompleted()
                }

                return Disposables.create {
                    requestTrackingAuthorization?.cancel()
                }
            } else {
                observer.onNext(PermissionResult(permission: .ATTrackingManager, result: .authorized))
                observer.onCompleted()
                return Disposables.create()
            }
        }
    }
}
