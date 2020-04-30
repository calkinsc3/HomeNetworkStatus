//
//  NetworkStatusModel.swift
//  HomeNetworkStatus
//
//  Created by William Calkins on 4/29/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import Foundation

struct NetworkStatusModel: Codable, Identifiable, Hashable, Equatable {
    let id = UUID()
    let setupState: String
    let software: Software
    let system: System
    let vorlonInfo: VorlonInfo
    let wan: WAN
    
    static let `placeholder` = NetworkStatusModel(setupState: "GWIFI_OOBE_COMPLETE", software: Software.placeholder, system: System.placeholder, vorlonInfo: VorlonInfo.placeholder, wan: WAN.placeholder)
}

struct Software: Codable, Identifiable, Hashable, Equatable {
    let id = UUID()
    let blockingUpdate: Int
    let softwareVersion, updateChannel, updateNewVersion: String
    let updateProgress: Double
    let updateRequired: Bool
    let updateStatus: String
    
    static let `placeholder` = Software(blockingUpdate: 1, softwareVersion: "12371.71.11", updateChannel: "stable-channel", updateNewVersion: "0.0.0.0", updateProgress: 0.0, updateRequired: false, updateStatus: "idle")
}

struct System: Codable, Identifiable, Hashable, Equatable {
    let id = UUID()
    let countryCode, groupRole, hardwareID: String
    let lan0Link: Bool
    let modelID: String
    let uptime: Int

    enum CodingKeys: String, CodingKey {
        case countryCode, groupRole
        case hardwareID = "hardwareId"
        case lan0Link
        case modelID = "modelId"
        case uptime
    }
    
    static let `placeholder` = System(countryCode: "us", groupRole: "root", hardwareID: "MISTRAL D2B-**-A3R-***", lan0Link: true, modelID: "MISTRAL", uptime: 68036)
}

struct VorlonInfo: Codable, Identifiable, Hashable, Equatable {
    let id = UUID()
    let migrationMode: String
    
    static let `placeholder` = VorlonInfo(migrationMode: "voobed")
}

struct WAN: Codable, Identifiable, Hashable, Equatable {
    let id = UUID()
    let captivePortal, ethernetLink: Bool
    let gatewayIPAddress: String
    let invalidCredentials, ipAddress: Bool
    let ipMethod: String
    let ipPrefixLength, leaseDurationSeconds: Int
    let localIPAddress: String
    let nameServers: [String]
    let online, pppoeDetected: Bool
    
    enum CodingKeys: String, CodingKey {
        case captivePortal, ethernetLink
        case gatewayIPAddress = "gatewayIpAddress"
        case invalidCredentials, ipAddress, ipMethod, ipPrefixLength, leaseDurationSeconds
        case localIPAddress = "localIpAddress"
        case nameServers, online, pppoeDetected
    }
    
    static let `placeholder` = WAN(captivePortal: false, ethernetLink: true, gatewayIPAddress: "47.34.57.1", invalidCredentials: false, ipAddress: true, ipMethod: "dhcp", ipPrefixLength: 21, leaseDurationSeconds: 21, localIPAddress: "47.34.57.93", nameServers: ["8.8.8.8","8.8.4.4","71.10.216.1","71.10.216.2"
    ], online: true, pppoeDetected: false)
    
}
