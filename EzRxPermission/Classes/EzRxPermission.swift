import RxSwift

public struct EzRxPermission {
    public static func requestPermission(permissions: [PermissionType]) -> Observable<PermissionResult>{
        var permissionObservers: [Observable<PermissionResult>] = []
        for permission in permissions {
            let permissionGrant = PermissionFactory.getPermission(permission: permission)
            permissionObservers.append(permissionGrant.requestPermission())
        }

        return Observable.concat(permissionObservers)
    }
}
