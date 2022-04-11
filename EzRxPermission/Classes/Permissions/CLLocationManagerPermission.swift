//
//  CLLocationManagerPermission.swift
//  EzRxPermission
//
//  Created by EE201201 on 2022/03/31.
//

import Foundation
import RxSwift
import CoreLocation

class CLLocationManagerPermission: NSObject, PermissionGrant {
    var isGranted: Bool {
        if #available(iOS 14.0, *) {
            return CLLocationManager().authorizationStatus == .authorizedAlways || CLLocationManager().authorizationStatus == .authorizedWhenInUse
        } else {
            return CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse
        }
    }

    let locationManager = CLLocationManager()

    let permissionPublishSubject = PublishSubject<PermissionResult>()

    override init() {
        super.init()

        locationManager.delegate = self
    }

    func requestPermission() -> Observable<PermissionResult> {
        return getCLLocationManagerPermission()
            .flatMap { _ in
                return self.permissionPublishSubject.asObservable()
            }
    }

    private func getCLLocationManagerPermission() -> Observable<Bool> {
        return Observable.create { observable in
            self.locationManager.requestWhenInUseAuthorization()
            observable.onNext(true)
            observable.onCompleted()

            return Disposables.create()
        }
    }
}

extension CLLocationManagerPermission: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        var permissionStatus: PermissionStatus
        if #available(iOS 14.0, *) {
            switch manager.authorizationStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                permissionStatus = .authorized
            case .notDetermined:
                return
            case .restricted, .denied:
                permissionStatus = .denied
            @unknown default:
                permissionStatus = .denied
            }
            permissionPublishSubject.onNext(PermissionResult(permission: .CLLocationManager, result: permissionStatus))
            permissionPublishSubject.onCompleted()
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        var permissionStatus: PermissionStatus
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            permissionStatus = .authorized
        case .notDetermined:
            return
        case .restricted, .denied:
            permissionStatus = .denied
        @unknown default:
            permissionStatus = .denied
        }
        permissionPublishSubject.onNext(PermissionResult(permission: .CLLocationManager, result: permissionStatus))
        permissionPublishSubject.onCompleted()
    }
}
