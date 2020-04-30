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
                Text("Staus of Local Network")
                    .font(.title)
                Divider()
                Text("Setup State: \(self.networkStatusViewModel.networkStatus?.setupState ?? "")")
                Text("Local IP Connected: \(String(self.networkStatusViewModel.networkStatus?.wan.ipAddress ?? false))")
                Text("Local IP: \(self.networkStatusViewModel.networkStatus?.wan.localIPAddress ?? "")")
                Text("Gateway Address: \(self.networkStatusViewModel.networkStatus?.wan.gatewayIPAddress ?? "")")
                Text("IP Lease Duration: \(self.networkStatusViewModel.networkStatus?.wan.leaseDurationSeconds ?? 0)")
                
                List(self.networkStatusViewModel.networkStatus?.wan.nameServers ?? [], id:\.self) { dns in
                    Text("DNS Severs: \(dns)")
                }
            }
        }
        .navigationBarTitle("Local Network Status")
        
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
