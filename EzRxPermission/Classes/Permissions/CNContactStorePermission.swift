//
//  CNContactStorePermission.swift
//  EzRxPermission
//
//  Created by EE201201 on 2022/03/31.
//

import Foundation
import RxSwift
import Contacts

class CNContactStorePermission: PermissionGrant {
    var isGranted: Bool {
        return CNContactStore.authorizationStatus(for: .contacts) == .authorized
    }

    func requestPermission() -> Observable<PermissionResult> {
        return Observable.create { observer in
            CNContactStore().requestAccess(for: .contacts) { isGrant, error in
                observer.onNext(PermissionResult(permission: .CNContactStore, result: isGrant ? .authorized : .denied))
                observer.onCompleted()
            }

            return Disposables.create()
        }
    }
}
