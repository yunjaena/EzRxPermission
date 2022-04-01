//
//  MPMediaLibraryPermission.swift
//  EzRxPermission
//
//  Created by EE201201 on 2022/04/01.
//

import Foundation
import MediaPlayer
import RxSwift

class MPMediaLibraryPermission: PermissionGrant {
    func requestPermission() -> Observable<PermissionResult> {
        return Observable.create { observer in
            if #available(iOS 9.3, *) {
                MPMediaLibrary.requestAuthorization { state in
                    var permissionStatus: PermissionStatus
                    switch state {
                    case .authorized:
                        permissionStatus = .authorized
                    default:
                        permissionStatus = .denied
                    }
                    observer.onNext(PermissionResult(permission: .MPMediaLibrary, result: permissionStatus))
                    observer.onCompleted()
                }
            } else {
                observer.onNext(PermissionResult(permission: .MPMediaLibrary, result: .authorized))
                observer.onCompleted()
            }

            return Disposables.create()
        }
    }
}
