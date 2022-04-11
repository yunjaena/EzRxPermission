# EzRxPermission

[![CI Status](https://img.shields.io/travis/yunjaena/EzRxPermission.svg?style=flat)](https://travis-ci.org/yunjaena/EzRxPermission)
[![Version](https://img.shields.io/cocoapods/v/EzRxPermission.svg?style=flat)](https://cocoapods.org/pods/EzRxPermission)
[![License](https://img.shields.io/cocoapods/l/EzRxPermission.svg?style=flat)](https://cocoapods.org/pods/EzRxPermission)
[![Platform](https://img.shields.io/cocoapods/p/EzRxPermission.svg?style=flat)](https://cocoapods.org/pods/EzRxPermission)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

EzRxPermission is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'EzRxPermission'
```

## How to Use

### Check permission granted

```swift
PermissionType.UNUserNotificationCenter().isGranted
```

### Request permission
```Swift
// MARK: - Single Permission
PermissionType.CLLocationManager.request
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

// MARK: - Multiple Permission
var notificationOption: NotificationOption? = nil

if #available(iOS 10.0, *) {
    notificationOption = NotificationOption(option: [.alert, .badge, .sound])
}

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
```

## Options

| Permission                                                                                                        | PermissionType     | Option             |
|-------------------------------------------------------------------------------------------------------------------|--------------------|--------------------|
| [AVAudioSession](https://developer.apple.com/documentation/avfaudio/avaudiosession)                               | Microphone         |                    |
| [AVCaptureDevice](https://developer.apple.com/documentation/avfoundation/avcapturedevice/)                        | Camera             | AVMediaType        |
| [ATTrackingManager](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/)         | AppTracking        |                    |
| [CBPeripheralManager](https://developer.apple.com/documentation/corebluetooth/cbperipheralmanager/)               | Bluetooth          |                    |
| [CLLocationManager](https://developer.apple.com/documentation/corelocation/cllocationmanager/)                    | GPS                |                    |
| [CNContactStore](https://developer.apple.com/documentation/contacts/cncontactstore/)                              | Contacts           |                    |
| [UNUserNotificationCenter](https://developer.apple.com/documentation/usernotifications/unusernotificationcenter/) | Notification       | NotificationOption |
| [EKEventStore](https://developer.apple.com/documentation/eventkit/ekeventstore/)                                  | Calendar           | EKEntityType       |
| [INPreferences](https://developer.apple.com/documentation/foundation/preferences/)                                | Siri               |                    |
| [MPMediaLibrary](https://developer.apple.com/documentation/mediaplayer/mpmedialibrary/)                           | Media library      |                    |
| [MotionManager](https://developer.apple.com/documentation/coremotion/cmmotionmanager/)                            | Motion             |                    |
| [PHPhotoLibrary](https://developer.apple.com/documentation/photokit/phphotolibrary/)                              | Photo library      |                    |
| [SFSpeechRecognizer](https://developer.apple.com/documentation/speech/sfspeechrecognizer)                         | Speech recognition |                    |

## Author

yunjaena, jinbaejeong

## License

EzRxPermission is available under the MIT license. See the LICENSE file for more info.
