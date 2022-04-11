//
//  PermissionResult.swift
//  EzRxPermission
//
//  Created by EE201201 on 2022/03/29.
//

import Foundation
import RxSwift

protocol PermissionGrant {
    var isGranted: Bool { get }
    func requestPermission() -> Observable<PermissionResult>
}

public enum PermissionStatus {
    case authorized
    case denied
}

public class EmptyPermission: PermissionGrant {
    var isGranted: Bool = false

    func requestPermission() -> Observable<PermissionResult> {
        return Observable.never()
    }
}

public struct PermissionResult {
    public let permission: PermissionType
    public let result: PermissionStatus
}
