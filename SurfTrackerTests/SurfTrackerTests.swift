//
//  SurfTrackerTests.swift
//  SurfTrackerTests
//
//  Created by Cian Brassil on 10/08/2016.
//  Copyright © 2016 Cian Brassil. All rights reserved.
//

import XCTest
@testable import SurfTracker

class SurfTrackerTests: XCTestCase {
    
    // MARK: SurfTracker Tests
    
    // Tests to confirm that the Session initializer returns when no time or a negative rating is provided.
    func testMealInitialization() {
        
        // Success case.
        let potentialItem = Session(time: "October 8, 2016 at 5:28PM", rating: 5, photo: nil, tide: nil)
        XCTAssertNotNil(potentialItem)
        
        // Failure cases.
        let noTime = Session(time: "", rating: 0, photo: nil, tide: nil)
        XCTAssertNil(noTime, "Empty time is invalid")
        
        let badRating = Session(time: "October 8, 2016 at 5:28PM", rating: -1, photo: nil, tide: nil)
        XCTAssertNotNil(badRating)
        
    }
}
