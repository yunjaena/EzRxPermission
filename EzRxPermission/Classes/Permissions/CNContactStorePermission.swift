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
    func requestPermission() -> Observable<PermissionResult> {
        return Observable.create { observer in
            CNContactStore().requestAccess(for: .contacts) { _, _ in
                return
            }

            return Disposables.create()
        }
    }
}
