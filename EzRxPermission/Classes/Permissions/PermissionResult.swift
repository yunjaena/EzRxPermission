//
//  PermissionResult.swift
//  EzRxPermission
//
//  Created by EE201201 on 2022/03/29.
//

import Foundation
import RxSwift

protocol PermissionGrant {
    func getPermission() -> Observable<PermissionResult>
}

public class EmptyPermission: PermissionGrant {
    func getPermission() -> Observable<PermissionResult> {
        return Observable.never()
    }
}

public struct PermissionResult {
    let permission: PermissionType
    let result: PermissionStatus
}
