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
    
    // MARK: Session Class Tests
    
    // Tests to confirm that the Session initializer returns when no time or a negative rating is provided.
    func testSessionInitialization() {
        
        // Success case.
        let potentialItem = Session(time: "October 8, 2016 at 5:28PM", rating: 5, photo: nil, tide: nil)
        XCTAssertNotNil(potentialItem)
        
        // Failure cases.
        let noTime = Session(time: "", rating: 0, photo: nil, tide: nil)
        XCTAssertNil(noTime, "Empty time is invalid")
        
        let badRating = Session(time: "October 8, 2016 at 5:28PM", rating: -1, photo: nil, tide: nil)
        XCTAssertNil(badRating)
        
    }
    
    // MARK: Spot Class Tests
    
    func testSpotInitialization(){
        // No sessions - should pass
        let noSessionsSpot = Spot.init(name: "Manly", sessions: nil, msw: ["Area": "Example"], windguru: ["Area": "Example"], photo: nil, notes: "Some notes")
        XCTAssertNotNil(noSessionsSpot)
        
        // No name - should fail
        let okSession = Session(time: "October 8, 2016 at 5:28PM", rating: 5, photo: nil, tide: nil)
        XCTAssertNotNil(noSessionsSpot)
        let noNameSpot = Spot.init(name: "", sessions: [okSession!], msw: ["Area": "Example"], windguru: ["Area": "Example"], photo: nil, notes: "Some notes")
        XCTAssertNil(noNameSpot)
    }
}
