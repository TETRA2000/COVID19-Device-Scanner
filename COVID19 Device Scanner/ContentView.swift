//
//  ContentView.swift
//  COVID19 Device Scanner
//
//  Created by Takahiko Inayama on 2020/07/02.
//  Copyright © 2020 TETRA2000. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var updater = PeripheralsObserber()
    private let dateFormatter: DateFormatter;
    
    init() {
        dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "HH:mm:ss"
    }
    
    var body: some View {
        VStack {
            Text("COVID19 Device Scanner")
            
            List(self.filterLog(log: updater.log), id: \.hashValue) { log in
                HStack {
                    Text("[\(self.dateFormatter.string(from: log.timestamp))]")
                    Text("UUID: \(log.uuid)")
                        .foregroundColor(Color.green)
                    Text("RSSI: \(log.rssi)")
                        .foregroundColor(Color.red)
                }
            }

            Button(action: {self.updater.startScan()}) {
                Text("Scan!!")
            }
        }
    }
    
    func filterLog(log: RingBuffer<DiscoveryLog>) -> [DiscoveryLog] {
        var foundUUID = Set<UUID>()
        return log.toArray().reversed().compactMap(
            {elm in
                if foundUUID.contains(elm.uuid) {
                    return nil
                } else {
                    foundUUID.insert(elm.uuid)
                    return elm
                }
            }
        )
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
