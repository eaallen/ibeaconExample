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
    @Published var beaconInfo : [
        String : [BeaconHistoryItem]
    ] = [:]
    override init(){
        super.init()
    }
    
    override func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if beacons.count > 0 {
            updateDistance(beacons)
        } else {
            
        }
    }
    
    func updateDistance(_ beacons: [CLBeacon]) {
        currentBeacon = beacons[0]
        // ensure we only add a value to the history list if there has been a change in rssi
        for beacon in beacons{
            beaconInfo["\(beacon.major)"] = [BeaconHistoryItem(beacon: beacon)]
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
