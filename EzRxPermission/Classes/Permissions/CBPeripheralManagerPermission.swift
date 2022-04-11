//
//  CBPeripheralManagerPermission.swift
//  EzRxPermission
//
//  Created by EE201201 on 2022/03/31.
//

import Foundation
import RxSwift
import CoreBluetooth

class CBPeripheralManagerPermission: NSObject, PermissionGrant {
    var isGranted: Bool {
        get {
            if #available(iOS 13.1, *) {
                return CBCentralManager.authorization == .allowedAlways
            } else if #available(iOS 13.0, *) {
                return CBCentralManager().authorization == .allowedAlways
            }

            return true
        }
    }

    private var peripheral: CBPeripheral!
    private var centralManager: CBCentralManager!

    private var permissionPublishSubject = PublishSubject<PermissionResult>()

    override init() {
        super.init()
    }

    func requestPermission() -> Observable<PermissionResult> {
        return getCBPeripheralManagerPermission()
            .flatMap { _  in
                return self.permissionPublishSubject.asObservable()
            }
    }


    private func getCBPeripheralManagerPermission() -> Observable<Bool> {
        return Observable.create { observable in
            self.centralManager = CBCentralManager(delegate: self, queue: nil)
            observable.onNext(true)
            observable.onCompleted()
            return Disposables.create()
        }
    }
}


extension CBPeripheralManagerPermission: CBCentralManagerDelegate {
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if #available(iOS 13.0, *) {
            permissionPublishSubject.onNext(PermissionResult(permission: .CBPeripheralManager, result: central.state == .unauthorized ? .denied : .authorized))
        } else {
            permissionPublishSubject.onNext(PermissionResult(permission: .CBPeripheralManager, result: .authorized))
        }
        permissionPublishSubject.onCompleted()
    }
}
