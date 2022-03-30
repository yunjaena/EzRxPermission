//
//  AppTrackingPermission.swift.swift
//  EzRxPermission
//
//  Created by EE201201 on 2022/03/29.
//

import AppTrackingTransparency
import RxSwift

class AppTrackingPermission {
    @available(iOS 14, *)
    static func checkTrackingObserver() -> Observable<ATTrackingManager.AuthorizationStatus> {
        return Observable.create { observer in
            var requestTrackingAuthorization: DispatchWorkItem?
            requestTrackingAuthorization = DispatchWorkItem(block: {
                if ((requestTrackingAuthorization?.isCancelled ?? true) == true) {
                    return
                }
                ATTrackingManager.requestTrackingAuthorization { status in
                    if((requestTrackingAuthorization?.isCancelled ?? true) == false) {
                        observer.onNext(status)
                        observer.onCompleted()
                    }
                }
            })

            if ATTrackingManager.trackingAuthorizationStatus == .notDetermined, let requestTrackingAuthorization = requestTrackingAuthorization {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: requestTrackingAuthorization)
            } else {
                observer.onNext(.authorized)
                observer.onCompleted()
            }

            return Disposables.create {
                requestTrackingAuthorization?.cancel()
            }
        }
    }
}
