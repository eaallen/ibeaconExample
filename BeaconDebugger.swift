//
//  BeaconDebugger.swift
//  ibeaconExample
//
//  Created by Oleg Simonov on 2/9/22.
//

import Foundation
import CoreLocation
import SwiftUI
 
class BeaconDebugger: BeaconBase {
    @Published var currentBeacon : CLBeacon? = nil
    @Published var beaconHistory : [BeaconHistoryItem] = []
    
    override init(){
        super.init()
    }
    
    override func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if beacons.count > 0 {
            updateDistance(beacons[0])
        } else {
            
        }
    }
    
    func updateDistance(_ beacon: CLBeacon) {
        currentBeacon = beacon
        // ensure we only add a value to the history list if there has been a change in rssi
        if beaconHistory.isEmpty || beacon.rssi != beaconHistory[0].beacon.rssi{
            beaconHistory.insert(BeaconHistoryItem(beacon: beacon), at: 0)
        }
    }
    
    func startScanning(beaconUUID: UUID) {
        let beaconRegion = CLBeaconRegion()
        locationManager?.startMonitoring(for: beaconRegion)
        locationManager?.startRangingBeacons(satisfying: .init(uuid: beaconUUID))
    }
    
    func stopScanning(beaconUUID: UUID){
        let beaconRegion = CLBeaconRegion()
        locationManager?.stopMonitoring(for: beaconRegion)
        locationManager?.stopRangingBeacons(satisfying: .init(uuid: beaconUUID))
    }
    
    struct BeaconHistoryItem : Identifiable {
        var id = UUID()
        var beacon: CLBeacon
    }
}
