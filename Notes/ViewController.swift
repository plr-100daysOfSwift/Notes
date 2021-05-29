//
//  ViewController.swift
//  Notes
//
//  Created by Paul Richardson on 29/05/2021.
//

import UIKit

class ViewController: UITableViewController {

	var notes: Notes?

	override func viewDidLoad() {
		super.viewDidLoad()

		title = "Notes"

		if notes == nil {
			var dummyNotes: [Note] = []
			let dummyNote = Note(title: "A New Note")
			dummyNotes.append(dummyNote)
			notes = Notes(notes: dummyNotes)
		}

	}
	}

}
