//
//  PHPhotoLibraryPermission.swift
//  EzRxPermission
//
//  Created by EE201201 on 2022/03/30.
//

import Foundation
import Photos
import RxSwift

class PHPhotoLibraryPermission: PermissionGrant {
    var isGranted: Bool {
        if #available(iOS 14, *) {
            return PHPhotoLibrary.authorizationStatus(for: .readWrite) == .authorized
        } else {
            return PHPhotoLibrary.authorizationStatus() == .authorized
        }
    }

    func requestPermission() -> Observable<PermissionResult> {
        return Observable.create { observer in
            if #available(iOS 14, *) {
                PHPhotoLibrary.requestAuthorization(for: .readWrite) { state in
                    var permissionStatus: PermissionStatus
                    switch state {
                    case .authorized, .limited:
                        permissionStatus = .authorized
                    default:
                        permissionStatus = .denied
                    }
                    observer.onNext(PermissionResult(permission: .PHPhotoLibrary, result: permissionStatus))
                    observer.onCompleted()
                }
            } else {
                PHPhotoLibrary.requestAuthorization({ state in
                    var permissionStatus: PermissionStatus
                    switch state {
                    case .authorized:
                        permissionStatus = .authorized
                    default:
                        permissionStatus = .denied
                    }
                    observer.onNext(PermissionResult(permission: .PHPhotoLibrary, result: permissionStatus))
                    observer.onCompleted()
                })
            }

            return Disposables.create()
        }
    }
}
