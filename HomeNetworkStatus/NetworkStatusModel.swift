//
//  NetworkStatusModel.swift
//  HomeNetworkStatus
//
//  Created by William Calkins on 4/29/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import Foundation

struct NetworkStatusModel: Codable {
    let setupState: String
    let software: Software
    let system: System
    let vorlonInfo: VorlonInfo
    let wan: WAN
}

struct Software: Codable {
    let blockingUpdate: Int
    let softwareVersion, updateChannel, updateNewVersion: String
    let updateProgress: Double
    let updateRequired: Bool
    let updateStatus: String
}

struct System: Codable {
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
}

struct VorlonInfo: Codable {
    let migrationMode: String
}

struct WAN: Codable {
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
    
}
