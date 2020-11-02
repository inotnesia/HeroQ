//
//  NetworkManager.swift
//  HeroQ
//
//  Created by Tony Hadisiswanto on 02/11/20.
//  Copyright © 2020 Tony Hadisiswanto. All rights reserved.
//

import Foundation
import SystemConfiguration

class NetworkManager: NSObject {
    static let shared = NetworkManager()
    
    public func isConnectedToInternet() -> Bool {
        return _currentReachabilityStatus != .notReachable
    }
    
    enum ReachabilityStatus {
        case notReachable
        case reachableViaWWAN
        case reachableViaWiFi
    }
    
    private var _currentReachabilityStatus: ReachabilityStatus {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return .notReachable
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return .notReachable
        }
        if flags.contains(.reachable) == false {
            return .notReachable
        } else if flags.contains(.isWWAN) == true {
            return .reachableViaWWAN
        } else if flags.contains(.connectionRequired) == false {
            return .reachableViaWiFi
        } else if (flags.contains(.connectionOnDemand) == true || flags.contains(.connectionOnTraffic) == true) && flags.contains(.interventionRequired) == false {
            return .reachableViaWiFi
        } else {
            return .notReachable
        }
    }
}
