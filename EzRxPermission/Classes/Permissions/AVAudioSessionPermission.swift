//
//  AVAudioSessionPermission.swift
//  EzRxPermission
//
//  Created by EE201201 on 2022/03/30.
//

import Foundation
import AVFoundation
import RxSwift

class AVAudioSessionPermission: PermissionGrant {
    var isGranted: Bool {
        get {
            return AVAudioSession.sharedInstance().recordPermission == .granted
        }
    }

    func requestPermission() -> Observable<PermissionResult> {
        return Observable.create { observer in
            AVAudioSession.sharedInstance().requestRecordPermission { didAllow in
                observer.onNext(PermissionResult(permission: .AVAudioSession, result: didAllow ? .authorized : .denied))
                observer.onCompleted()
            }

            return Disposables.create()
        }
    }
}
