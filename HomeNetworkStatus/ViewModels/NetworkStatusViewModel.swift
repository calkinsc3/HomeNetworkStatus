//
//  NetworkStatusViewModel.swift
//  HomeNetworkStatus
//
//  Created by William Calkins on 4/29/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import os


//MARK:- NetworkStatus View Model
class NetworkStatusViewModel: ObservableObject {
    
    @Published var networkStatus: NetworkStatusModel = NetworkStatusModel.placeholder
    
    
    private let networkStatusFetcher = NetworkFetcher()
    private var disposables = Set<AnyCancellable>()
    
    init() {
        self.fetchNetworkStatus()
    }
    
    private func fetchNetworkStatus() {
        
        self.networkStatusFetcher.networkStatus()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                
                switch completion {
                case .failure(let networkPublisherError):
                    switch networkPublisherError as NetworkPublisherError {
                    case .decoding(let decodingError):
                        os_log("Decoding error in fetchNetworkStatus error: %s", log: Log.decodingLogger, type: .error, decodingError)
                    case .network(let networkError):
                        os_log("Network error in fetchNetworkStatus error: %s", log: Log.networkLogger, type: .error, networkError)
                    case .apiError(let apiError) :
                        os_log("API error in fetchNetworkStatus error: %s", log: Log.networkLogger, type: .error, apiError)
                    }
                case .finished:
                    break
                }
                
            }) { [weak self] networkStatus in
                guard let self = self else { return }
                self.networkStatus = networkStatus
        }
        .store(in: &disposables)
    }
    
}

//MARK:- Log extensions
private let subsystem = "com.c3.swiftui.HomeNetworkStatus"

struct Log {
    //create log for decoding data structures
    static let decodingLogger = OSLog(subsystem: subsystem, category: "decoding")
    static let networkLogger = OSLog(subsystem: subsystem, category: "network")
    static let viewLogger = OSLog(subsystem: subsystem, category: "views")
    static let viewModelLogger = OSLog(subsystem: subsystem, category: "viewModels")
    
}


