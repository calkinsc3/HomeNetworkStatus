//
//  HomeNetworkStatusTests.swift
//  HomeNetworkStatusTests
//
//  Created by William Calkins on 4/29/20.
//  Copyright © 2020 Calkins Computer Consulting. All rights reserved.
//

import XCTest
@testable import HomeNetworkStatus

class HomeNetworkStatusTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNetworkStatusModel() throws {
        
        let networkStatus = self.getMockData(forResource: "NetworkStatusMock")
        
        if let givenNetworkStatusModel = networkStatus {
            
            do {
                let jsonDecoder = JSONDecoder()
                let networkModel = try jsonDecoder.decode(NetworkStatusModel.self, from: givenNetworkStatusModel)
                
                XCTAssert(networkModel.setupState == "GWIFI_OOBE_COMPLETE" , "The setupState should be GWIFI_OOBE_COMPLETE" )
                XCTAssert(networkModel.software.softwareVersion == "12371.71.11", "The softwareVersion should be 12371.71.11")
                XCTAssert(networkModel.system.modelID == "MISTRAL", "The model ID should be MISTRAL")
                
                //WAN data
                XCTAssert(networkModel.wan.ipAddress, "IP Address should be true")
                XCTAssert(networkModel.wan.localIPAddress == "47.34.57.92", "Local IP Address should be 47.34.57.92")
                
                
            } catch let error {
                XCTFail("Could not decode NetworkStatusModel: \(error)")
            }
        } else {
            XCTFail("Cannot unwrap the HomeNetworkStatusTest mock")
        }
        
    }
    
    //MARK:- Helper Functions
    private func createPath(forJSONFile: String) -> URL {
        
        let jsonURL = URL(
            fileURLWithPath: forJSONFile,
            relativeTo: FileManager.documentDirectoryURL?.appendingPathComponent("\(forJSONFile)")
        ).appendingPathExtension("json")
        
        print("json path for \(forJSONFile) = \(jsonURL.absoluteString)")
        
        return jsonURL
    }
    
    private func getMockData(forResource: String) -> Data? {
        
        //This is included in they myamfam target becasue it will be used the app.
        let currentBundle = Bundle(for: type(of: self))
        if let pathForRecommendationMock = currentBundle.url(forResource: forResource, withExtension: "json") {
            do {
                return try Data(contentsOf: pathForRecommendationMock)
            } catch {
                XCTFail("Unable to convert \(pathForRecommendationMock) to Data.")
                return nil
            }
        } else {
            XCTFail("Unable to load \(forResource).json.")
            return nil
        }
        
    }

}
