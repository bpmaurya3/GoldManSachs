//
//  PlanetTransactionsTests.swift
//  GManSChallengeTests
//
//  Created by Bhuvanendra Pratap Maurya on 04/09/22.
//

import XCTest

class PlanetTransactionsTests: XCTestCase {

    var transaction: PlanetNetworkTransaction?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
    }

    override func setUp() {
        super.setUp()
        transaction = self.getCatalogTrasaction()
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

    func testGetPlanetSuccess() throws {
        transaction?.requestManager = GManSRequestResponseManagerGetPlanetSuccess(baseUrl: "")
        let promise = expectation(description: "Status code: 200")
        transaction?.getPlanet(date: nil) { status, _, _ in
            XCTAssertEqual(status, 200, "Response status code should be 200")
            promise.fulfill()
        } onFailure: { error, _ in
            XCTAssertNil(error, "Get Products Request shouldn't fail")
            promise.fulfill()
        }
        wait(for: [promise], timeout: 10)
    }

    func testGetCatalogProductsFailure() throws {
        transaction?.requestManager = GManSRequestResponseManagerGetPlanetsFailure(baseUrl: "")
        let promise = expectation(description: "Status code: 400")
        transaction?.getPlanet(date: nil) { status, _, _ in
            XCTAssert(status != 200, "Response status code shouldn't be 200")
            promise.fulfill()
        } onFailure: { error, _ in
            XCTAssertNotNil(error, "Error shouldn't be nil")
            XCTAssertEqual(error.code.rawValue, 400, "Error status code should be 400")
            promise.fulfill()
        }
        wait(for: [promise], timeout: 10)
    }

    func testGetPlanetForADateSuccess() throws {
        let date = "2022-09-03"
        transaction?.requestManager = GManSRequestResponseManagerGetPlanetSuccess(baseUrl: "")
        let promise = expectation(description: "Status code: 200")
        transaction?.getPlanet(date: date) { status, _, _ in
            XCTAssertEqual(status, 200, "Response status code should be 200")
            promise.fulfill()
        } onFailure: { error, _ in
            XCTAssertNil(error, "Get Products Request shouldn't fail")
            promise.fulfill()
        }
        wait(for: [promise], timeout: 10)
    }
}
