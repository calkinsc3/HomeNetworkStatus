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

//MARK:- NetworkFetcher
class NetworkFetcher {
    
    private let session: URLSession
    
    init() {
        self.session = URLSession.shared
    }
    
}

//MARK:- NetworkFetch Extension
extension NetworkFetcher : NetworkFetchable {
    
    func networkStatus() -> NetworkStatusPublisher {
        return self.networkItems(with: self.makeNetworkStatusComps())
    }
    
    //MARK:- Generic Fetch
    private func networkItems<T>(with components: URLComponents) -> AnyPublisher<T, NetworkPublisherError> where T: Decodable {
        
        guard let url = components.url else {
            let error = NetworkPublisherError.network(description: "Couldn't create URL for Network API")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: url)
            .mapError { error in
                NetworkPublisherError.network(description: error.localizedDescription)
        }
        .flatMap { pair in
            self.decode(pair.data)
        }
        .eraseToAnyPublisher()
        
    }
    
    private func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, NetworkPublisherError> {
        
        let decoder = JSONDecoder()
        
        return Just(data)
            .decode(type: T.self, decoder: decoder)
            .mapError { error in
                .decoding(description: (error as? DecodingError).debugDescription)
        }
        .eraseToAnyPublisher()
    }
    
    
}

//MARK:- URL Construction
private extension NetworkFetcher {
    
    struct NetworkServerAPI {
        static let schema = "http"
        static let host = "192.168.86.1"
        static let path = "/api/v1/status"
        
    }
    
    func makeNetworkStatusComps() -> URLComponents {
        
        var components = URLComponents()
        
        components.scheme = NetworkServerAPI.schema
        components.host = NetworkServerAPI.host
        components.path = NetworkServerAPI.path
        
        return components
    }
    
    
    
}




