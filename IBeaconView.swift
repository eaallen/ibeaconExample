//
//  IBeaconView.swift
//  ibeaconExample
//
//  Created by Oleg Simonov on 2/9/22.
//

import SwiftUI
 
struct IbeaconView: View {
    // the hard coded UUID should be unique to our business. We will need to make sure that all of out ibeacons have the same uuid
    let beaconUUID = UUID(uuidString: "CC6ED3C0-477E-417B-81E1-0A62D6504061")!
    @ObservedObject private var beaconDetector = BeaconDebugger()
    var body: some View {
        VStack(alignment: .center){
            Text(beaconDetector.currentBeacon?.uuid.uuidString ?? "unknown")
            Text(BeaconDebugger.translateProximity(beaconDetector.currentBeacon?.proximity ?? .unknown))
                .font(.largeTitle)
                .padding()
            Text(String(beaconDetector.currentBeacon?.rssi ?? -1))
            List(beaconDetector.beaconHistory){ item in
                beaconDetialRow(item: item)
            }
        }
        .onAppear(perform: startScanning)
        .onDisappear(perform: stopScanning)
    }
    
    func beaconDetialRow(item: BeaconDebugger.BeaconHistoryItem) -> some View {
        VStack{
            

            HStack{
                HStack{
                    Text("Proximity: ")
                    Text(BeaconDebugger.translateProximity(item.beacon.proximity))
                }
                Spacer()
                VStack {
    //                Text("UUID: \(item.beacon.uuid.uuidString)")
    //                Text("Minor: \(item.beacon.minor)")
                    Text("Major: \(item.beacon.major)")
                    Text("\(Date().description(with: Locale.current))")
                }
                Spacer()
                HStack{
                    Text("RSSI: ")
                    Text(String(item.beacon.rssi))
                }
            }
        }
    }
    
    func startScanning(){
        beaconDetector.startScanning(beaconUUID: beaconUUID )
    }
    
    func stopScanning(){
        beaconDetector.stopScanning(beaconUUID: beaconUUID)
    }
}
 
struct IbeaconView_Previews: PreviewProvider {
    static var previews: some View {
        IbeaconView()
    }
}
