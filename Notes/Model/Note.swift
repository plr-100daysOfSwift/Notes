//
//  Note.swift
//  Notes
//
//  Created by Paul Richardson on 29/05/2021.
//

import Foundation

struct Note {
	
	var title: String

	static var placeholder: Note {
		return Note(title: "My First Note")
	}
	
}
