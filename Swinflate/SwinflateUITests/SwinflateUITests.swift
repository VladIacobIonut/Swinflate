//
//  SwinflateUITests.swift
//  SwinflateUITests
//
//  Created by Vlad on 1/7/19.
//  Copyright © 2019 Vlad Iacob. All rights reserved.
//

import XCTest

class SwinflateUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDown() {
    }

    func testStackLayout() {
        let app = XCUIApplication()
        app.tables.staticTexts["Horizontal stack"].tap()
        
        let cellsQuery = app.collectionViews.cells
        
        let firstCell = cellsQuery.otherElements.containing(.staticText, identifier:"December 1").element
        let beforeSwipeHeight = firstCell.frame.height
    
        firstCell.swipeLeft()
        
        let afterSwipeHeight = firstCell.frame.height
        let afterSwipeXOffset = firstCell.frame.origin.x
    
        // Assert if the cell is scaled down after swiping
        XCTAssert(beforeSwipeHeight > afterSwipeHeight)
        
        // Assert if the cell is still visible in the screen behind the second cell
        XCTAssert(afterSwipeXOffset > 0)
    }
    
    func testInflateLayout() {
        let app = XCUIApplication()
        app.tables.staticTexts["Inflate"].tap()
        
        let cellQuery = app.collectionViews.cells
        
        let firstCell = cellQuery.otherElements.containing(.staticText, identifier:"December 1").element
        let secondCell = cellQuery.otherElements.containing(.staticText, identifier:"December 2").element
        
        let firstCellHeightBeforeSwipe = firstCell.frame.height
        let secondCellHeightBeforeSwipe = secondCell.frame.height

        firstCell.swipeLeft()
        let thirdCell = cellQuery.otherElements.containing(.staticText, identifier:"December 3").element
        
        let firstCellHeightAfterSwipe = firstCell.frame.height
        let secondCellHeightAfterSwipe = secondCell.frame.height
        let thirdCellHeight = thirdCell.frame.height
        
        // Assert if the first cell is bigger than the second initially
        XCTAssert(firstCellHeightBeforeSwipe > secondCellHeightBeforeSwipe)
        
        // Assert if the first cell is smaller than the second after swiping left once
        XCTAssert(firstCellHeightAfterSwipe < secondCellHeightAfterSwipe)
        
        // Assert if the third cell is smaller than the second after swiping left once
        XCTAssert(thirdCellHeight < secondCellHeightAfterSwipe)
    }
}
