//
//  NoteModelValidator.swift
//  Notes
//
//  Created by Paul Richardson on 29/05/2021.
//

import Foundation

class NoteModelValidator {

	func isTitleValid(title: String) -> Bool {
		return !title.isEmpty
	}

}
