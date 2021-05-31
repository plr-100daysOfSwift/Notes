//
//  Note.swift
//  Notes
//
//  Created by Paul Richardson on 29/05/2021.
//

import Foundation

struct Note: Codable {
	
	var text: String

	var title: String {
		return text.components(separatedBy: "\n").first ?? ""
	}

	static var placeholder: Note {
		return Note(text: "New Note")
	}
	
}
