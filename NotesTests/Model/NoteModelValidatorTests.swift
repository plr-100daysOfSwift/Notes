//
//  NoteModelValidatorTests.swift
//  NotesTests
//
//  Created by Paul Richardson on 29/05/2021.
//

import XCTest
@testable import Notes

class NoteModelValidatorTests: XCTestCase {

	var sut: NoteModelValidator!

	override func setUpWithError() throws {
		sut = NoteModelValidator()
	}

	override func tearDownWithError() throws {
		sut = nil
	}

	func testNoteModelValidator_WhenValidTitleIsProvided_ShouldReturnTrue() {

		// Arrange
		let title = "A New Note"
		let note = Note(title: title)

		// Act
		let isTitleValid = sut.isTitleValid(title: note.title)

		// Assert
		XCTAssertTrue(isTitleValid, "isTitleValid() should return TRUE for a non-empty title but returned FALSE")
	}

	func testNoteModelValidator_WhenInvalidTitleIsProvided_ShouldReturnFalse() {

		// Arrange
		let title = ""
		let note = Note(title: title)

		// Act
		let isTitleValid = sut.isTitleValid(title: note.title)

		// Assert
		XCTAssertFalse(isTitleValid, "isTitleValid should return FALSE for an empty title but returned TRUE")

	}

}
