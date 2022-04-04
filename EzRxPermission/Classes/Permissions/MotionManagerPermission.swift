//
//  MotionManagerPermission.swift
//  EzRxPermission
//
//  Created by EE201201 on 2022/04/04.
//

import Foundation
import CoreMotion
import RxSwift

public enum MotionType {
    case Accelerometer
    case Gyroscope
    case Magnetometer
    case DeviceMotion
}

class MotionManagerPermission: PermissionGrant {
    func requestPermission() -> Observable<PermissionResult> {
        return Observable.create { observer in
            let manager = CMMotionActivityManager()
            let now = Date()
            manager.queryActivityStarting(from: now, to: now, to: .main) { _, error in
                if error == nil {
                    observer.onNext(PermissionResult(permission: .MotionManager, result: .authorized))
                    observer.onCompleted()
                } else {
                    observer.onNext(PermissionResult(permission: .MotionManager, result: .denied))
                    observer.onCompleted()
                }
            }

            return Disposables.create()
        }
    }
}
