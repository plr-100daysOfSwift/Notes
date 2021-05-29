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

	// MARK:- Table View Data Methods

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return notes?.notes.count ?? 0
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let notes = notes?.notes
		let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
		cell.textLabel?.text = notes?[indexPath.row].title
		return cell
	}

}
