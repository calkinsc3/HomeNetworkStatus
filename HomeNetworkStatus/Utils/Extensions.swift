//
//  Extensions.swift
//  HomeNetworkStatus
//
//  Created by William Calkins on 4/29/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import Foundation

extension FileManager {
    static var documentDirectoryURL: URL? {
        do {
            return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        } catch {
            return nil //if there is an error return nil
        }
    }
}
