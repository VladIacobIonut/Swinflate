//
//  SWInflateLayoutUnitTest.swift
//  SwinflateTests
//
//  Created by Vlad on 12/20/18.
//  Copyright © 2018 Vlad Iacob. All rights reserved.
//

import XCTest
@testable import Swinflate

final class SWInflateLayoutUnitTest: XCTestCase {
    
    private let collectionViewLayout = SWInflateLayout()

    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
    
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Functions
    
    func testScrollDirection() {
        XCTAssertEqual(collectionViewLayout.scrollDirection.rawValue, 0)
    }
}
