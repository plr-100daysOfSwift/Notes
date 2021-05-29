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

		var dummyNotes: [Note] = []
		let dummyNote = Note(title: "A New Note")
		dummyNotes.append(dummyNote)
		sut?.notes = Notes(notes: dummyNotes)

		// Act
		let notes = sut?.notes

		// Assert
		XCTAssertTrue(type(of: notes) == Notes?.self, "The notes property should be of type Notes?")
		XCTAssertNotNil(notes, "View Controller should contain a notes property but returned NIL")

	}

}
