import Foundation

let Domain = "http://localhost:8080"

public protocol TargetType {
    var domain: String { get }
    var path: String { get }
    var method: String { get }
}

// 実行されるAPIの種類を管理
public enum API {
    // プロフィール取得API
    case profile(Int)
}

extension API: TargetType {
    public var domain : String {
        return Domain
    }

    public var path : String {
        switch self {
        // プロフィール取得
        case .profile(let user_id):
            return "\(domain)" + "/user/\(user_id)"
        }
    }

    public var method: String {
        switch self {
        case .profile:
            return "GET"
        }
    }
}
