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

        EzRxPermission.requestPermission(permissions: [.SFSpeechRecognizer])
            .subscribe(onNext: { result in
                print(result)
            }).disposed(by: disposBag)

        /*
        PermissionType.CLLocationManager.request
            .subscribe(onNext: { [weak self] result in
                print(result)
            }).disposed(by: disposBag)
         */
    }
}
