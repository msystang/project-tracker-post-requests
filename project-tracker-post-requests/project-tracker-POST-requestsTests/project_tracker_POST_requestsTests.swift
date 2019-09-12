//
//  project_tracker_POST_requestsTests.swift
//  project-tracker-POST-requestsTests
//
//  Created by Sunni Tang on 9/10/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import XCTest

class project_tracker_POST_requestsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetProjects() {
        // Arrange
        guard let jsonPath = Bundle.main.path(forResource: "testing-json", ofType: "json"),
            let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)) else {
                fatalError("Test JSON data not found")
        }
        
        // Act
        var projects = [Project]()
        
        do {
            projects = try Project.getProjects(from: jsonData)
        }
        catch {
            print(error)
        }
        
        // Assert
        XCTAssertEqual(projects.count, 16, "Was expecting 16 projects, but found \(projects.count)")
    }

}
