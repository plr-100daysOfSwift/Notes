//
//  ViewController.swift
//  Notes
//
//  Created by Paul Richardson on 29/05/2021.
//

import UIKit

class ViewController: UITableViewController {

	var notes: [Note]?

	override func viewDidLoad() {
		super.viewDidLoad()

		title = "Notes"

		if notes == nil {
			loadNotes()
		}

	}

	fileprivate func loadNotes() {
		notes? = []
		notes?.append(Note.placeholder)
	}

	// MARK:- Table View Data Methods

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return notes?.count ?? 0
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
		if let note = notes?[indexPath.row] {
			cell.textLabel?.text = note.title
		}
		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let vc = DetailViewController()
		if let title = notes?[indexPath.row].title {
			vc.noteTitle = title
		}
		navigationController?.pushViewController(vc, animated: true)
	}

}
