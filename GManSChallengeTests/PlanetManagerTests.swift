//
//  PlanetManagerTests.swift
//  GManSChallengeTests
//
//  Created by Bhuvanendra Pratap Maurya on 04/09/22.
//

import XCTest
@testable import GManSChallenge

class PlanetManagerTests: XCTestCase {

    var planetManager: PlanetManager?
    var transaction: PlanetNetworkTransaction?


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        self.transaction = nil
        self.planetManager = PlanetManager()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()
    }

    override func tearDown() {
        super.tearDown()
        self.transaction = nil
    }

    override func setUp() {
        super.setUp()
        self.transaction = self.getCatalogTrasaction()
    }

    func getCatalogTrasaction() -> PlanetNetworkTransaction? {
        if transaction == nil {
            self.transaction = PlanetNetworkTransaction(baseUrl: "https://api.nasa.gov")
        }
        return transaction
    }

    func testGetTransaction() {
        if self.transaction == nil {
            self.transaction = getCatalogTrasaction()
        }
        XCTAssertNotNil(self.transaction, "Transaction should not be nil on load")
    }

    func testGetCatalogProductsRequestSuccess() throws {
        self.transaction?.requestManager = GManSRequestResponseManagerGetPlanetSuccess(baseUrl: "")
        self.planetManager?.planetTransaction = self.transaction ?? PlanetNetworkTransaction(baseUrl: "")
        let promise = expectation(description: "Status code: 200")
        self.planetManager?.getPlanets(date: nil, onSuccess: { status, _ in
                XCTAssertEqual(status, 200, "Response status code is 200")
                promise.fulfill()
        }, onFailure: { error in
                XCTAssertNotNil(error, "Error shouldn't be nil")
                XCTAssertEqual(error.code.rawValue, 400, "Error status code should be 400")
                promise.fulfill()
        })
        wait(for: [promise], timeout: 5)
    }


}
