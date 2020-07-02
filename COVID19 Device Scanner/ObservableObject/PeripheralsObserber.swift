//
//  PeripheralsObserber.swift
//  COVID19 Device Scanner
//
//  Created by Takahiko Inayama on 2020/07/02.
//  Copyright © 2020 TETRA2000. All rights reserved.
//

import Foundation
import CoreBluetooth

class PeripheralsObserber: NSObject, ObservableObject, CBCentralManagerDelegate {
    public let serviceUUID = CBUUID.init(string: "0000fd6f-0000-1000-8000-00805f9b34fb")
    
    @Published var log: RingBuffer<DiscoveryLog> = RingBuffer(capacity: 30)
    private var centralManager: CBCentralManager?
    
    override init() {
        super.init()
        centralManager = CBCentralManager.init(delegate: self, queue: nil)
    }
    
    public func startScan() {
        centralManager?.scanForPeripherals(withServices: [serviceUUID], options: nil)
    }
    
    public func stopScan() {
        centralManager?.stopScan()
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("\(central.state.rawValue)")
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("identifier: \(peripheral.identifier)")
        print("advertisementData: \(advertisementData)\n")
        print("RSSI: \(RSSI)\n")
        
        log.append(elm: DiscoveryLog(uuid: peripheral.identifier, rssi: RSSI, timestamp: Date()))
    }
}
