//
//  Note.swift
//  Notes
//
//  Created by Paul Richardson on 29/05/2021.
//

import Foundation

struct Note: Codable {

	var id: UUID = UUID()
	var text: String

	var title: String {
		return text.components(separatedBy: .newlines).first ?? ""
	}

	static var placeholderText = """
		New Note
		This is a new note.
		"""

	static var placeholder: Note {
		return Note(text: placeholderText)
	}

}
