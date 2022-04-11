//
//  EKEventStorePermission.swift
//  EzRxPermission
//
//  Created by EE201201 on 2022/04/01.
//

import Foundation
import EventKit
import RxSwift

class EKEventStorePermission: PermissionGrant {
    var isGranted: Bool {
        return EKEventStore.authorizationStatus(for: self.entityType ?? .event) == .authorized
    }

    var entityType: EKEntityType? = .event

    init(type: EKEntityType? = .event) {
        self.entityType = type
    }

    func requestPermission() -> Observable<PermissionResult> {
        return Observable.create { observer in
            EKEventStore().requestAccess(to: self.entityType ?? .event) { isGrant, error in
                observer.onNext(PermissionResult(permission: .EKEventStore(type: self.entityType), result: isGrant ? .authorized : .denied))
                observer.onCompleted()
            }

            return Disposables.create()
        }
    }
}
