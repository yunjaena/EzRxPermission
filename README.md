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

```Swift
// MARK: - Single Permission
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

## Author

yunjaena, jinbaejeong

## License

EzRxPermission is available under the MIT license. See the LICENSE file for more info.
