//
//  NetworkStatusFetcher.swift
//  HomeNetworkStatus
//
//  Created by William Calkins on 4/29/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import Foundation
import Combine

enum NetworkPublisherError: Error {
    case network(description: String)
    case decoding(description: String)
    case apiError(description: String)
}

typealias NetworkStatusPublisher = AnyPublisher<NetworkStatusModel, NetworkPublisherError>

protocol NetworkFetchable {
    func networkStatus() -> NetworkStatusPublisher
}


