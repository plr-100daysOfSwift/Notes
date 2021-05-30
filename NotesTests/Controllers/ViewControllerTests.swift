//
//  ViewControllerTests.swift
//  NotesTests
//
//  Created by Paul Richardson on 29/05/2021.
//

import XCTest
@testable import Notes

class ViewControllerTests: XCTestCase {

	override func setUpWithError() throws {
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}

	override func tearDownWithError() throws {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
	}

	func testViewController_WhenCreated_HasValidNotesProperty() {

		// Arrange
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let sut = storyboard.instantiateViewController(identifier: "ViewController") as? ViewController

		// Act
		let placeholder = Note.placeholder
		let notes = [placeholder]
		sut?.notes = notes

		// Assert
		XCTAssertTrue(type(of: notes) == [Note].self, "The notes property should be of type [Note]")
		XCTAssertNotNil(notes, "View Controller should contain a notes property but returned NIL")

	}

}
