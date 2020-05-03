//
//  ContentView.swift
//  HomeNetworkStatus
//
//  Created by William Calkins on 4/29/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var networkStatusViewModel = NetworkStatusViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Nest Wifi Status")
                    .font(.title)
                Divider()
                
                List {
                    NavigationLink(destination: WANView(wanData: self.networkStatusViewModel.networkStatus.wan )) {
                        Text("WAN Info: \(self.networkStatusViewModel.networkStatus.wan.localIPAddress)")
                    }
                    NavigationLink(destination: SystemView(systemData: self.networkStatusViewModel.networkStatus.system)) {
                        Text("System Info: \(self.networkStatusViewModel.networkStatus.system.modelID)")
                    }
                    NavigationLink(destination: SoftwareView(softwareData: self.networkStatusViewModel.networkStatus.software)) {
                        Text("Software Version: \(self.networkStatusViewModel.networkStatus.software.softwareVersion)")
                    }
                }
                
            }
        }
        .navigationBarTitle("Local Network Status")
        
    }
}

struct WANView: View {
    
    let wanData: WAN
    
    var body: some View {
        
        VStack {
            Text("Local IP Connected: \(String(self.wanData.ipAddress))")
            Text("Local IP: \(self.wanData.localIPAddress)")
            Text("Gateway Address: \(self.wanData.gatewayIPAddress)")
            Text("IP Lease Duration: \(self.wanData.leaseDurationSeconds)")
        }
    }
}

struct DNSServersView: View {
    let nameServers : [String]
    
    var body: some View {
        VStack {
            ForEach(self.nameServers, id: \.self) { nameServerIP in
                Text(nameServerIP)
            }
        }
    }
}

struct SystemView: View {
    
    let systemData: System
    
    var body: some View {
        VStack {
            Text("Country Code: \(self.systemData.countryCode)")
            Text("Group Role: \(self.systemData.groupRole)")
            Text("HardwardID: \(self.systemData.hardwareID)")
            Text("Land is Linked: \(self.systemData.lan0Link ? "true" : "false"))")
            Text("Model ID: \(self.systemData.modelID)")
            Text("Uptime: \(self.systemData.uptime)")
        }
    }
}

struct SoftwareView: View {
    
    let softwareData: Software
    
    var body: some View {
        VStack {
            Text("Blocking Update: \(self.softwareData.blockingUpdate)")
            Text("Software Version: \(self.softwareData.softwareVersion)")
            Text("Update Channel: \(self.softwareData.updateChannel)")
            Text("Update New Version: \(self.softwareData.updateNewVersion)")
            Text("Update Progress: \(self.softwareData.updateProgress)")
            Text("Update Required: \(self.softwareData.updateRequired ? "true" : "false")")
            Text("Update Status: \(self.softwareData.updateStatus)")
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
