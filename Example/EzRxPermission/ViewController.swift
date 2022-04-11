//
//  ViewController.swift
//  EzRxPermission
//
//  Created by yunjaena on 03/28/2022.
//  Copyright (c) 2022 yunjaena. All rights reserved.
//

import UIKit
import RxSwift
import EzRxPermission

class ViewController: UIViewController {
    let disposBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        var notificationOption: NotificationOption? = nil
        if #available(iOS 10.0, *) {
            notificationOption = NotificationOption(option: [.alert, .badge, .sound])
        }

        print("IsGrant : ", PermissionType.UNUserNotificationCenter().isGranted)

        EzRxPermission.requestPermission(permissions: [.UNUserNotificationCenter(options: notificationOption), .CNContactStore])
            .subscribe(
                onNext: { permission in
                    switch permission.result {
                    case .authorized:
                        print("Permission Authorized")
                    case .denied:
                        print("Permission Denied")
                    }
                }
            ).disposed(by: disposBag)

        PermissionType.CLLocationManager.request
            .subscribe(
                onNext: { [weak self] permission in
                    switch permission.result {
                    case .authorized:
                        print("Permission Authorized")
                    case .denied:
                        print("Permission Denied")
                    }
                }
            ).disposed(by: disposBag)
    }
}
