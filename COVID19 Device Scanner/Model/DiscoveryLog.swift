//
//  DiscoveryLog.swift
//  COVID19 Device Scanner
//
//  Created by Takahiko Inayama on 2020/07/02.
//  Copyright © 2020 TETRA2000. All rights reserved.
//

import Foundation

struct DiscoveryLog {
    var uuid: UUID
    var rssi: NSNumber
    var timestamp: Date
    var hashValue: Int {
        return (uuid.hashValue ^ rssi.hashValue ^ timestamp.hashValue) &* 16777619
    }
}
