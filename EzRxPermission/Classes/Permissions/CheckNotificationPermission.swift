//
//  UNUserNotificationCenterPermission.swift
//  EzRxPermission
//
//  Created by EE201201 on 2022/03/30.
//

import Foundation
import RxSwift

public class NotificationOption {
    @available(iOS 10.0, *)
    lazy var options: UNAuthorizationOptions? = nil

    @available(iOS 10.0, *)
    public init(option: UNAuthorizationOptions?) {
        self.options = option
    }
}


public class CheckNotificationPermission: PermissionGrant {
    var isGranted: Bool {
        let semaphore = DispatchSemaphore(value: 0)
        var status: Bool = false

        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                switch settings.authorizationStatus {
                case .authorized: status = true
                default: status = false
                }

                semaphore.signal()
            }
            _ = semaphore.wait(timeout: .distantFuture)
        } else {
            status = true
        }

        return status
    }

    let notificationOption: NotificationOption?

    public init(notificationOption: NotificationOption?) {
        self.notificationOption = notificationOption
    }

    func requestPermission() -> Observable<PermissionResult> {
        return Observable.create { observer in
            if #available(iOS 10.0, *) {
                guard let options = self.notificationOption?.options else {
                    observer.onNext(PermissionResult(permission: .UNUserNotificationCenter(options: self.notificationOption), result: .authorized))
                    observer.onCompleted()
                    return Disposables.create()
                }
                UNUserNotificationCenter.current().requestAuthorization(
                    options: options,
                    completionHandler: { didAllow, _ in
                        observer.onNext(PermissionResult(permission: .UNUserNotificationCenter(options: self.notificationOption), result: didAllow ? .authorized : .denied))
                        observer.onCompleted()
                    }
                )
            } else {
                observer.onNext(PermissionResult(permission: .UNUserNotificationCenter(options: self.notificationOption), result: .authorized))
                observer.onCompleted()
            }

            return Disposables.create()
        }
    }
}
