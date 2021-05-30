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
		let defaults = UserDefaults.standard
		if let encodedData = defaults.data(forKey: UserDefaultsNotesKey) {
			let decoder = JSONDecoder()
			if let decodedData = try? decoder.decode([Note].self, from: encodedData) {
				notes = decodedData
			}
		}
	}

	fileprivate func save() {
		let defaults = UserDefaults.standard
		let encoder = JSONEncoder()
		if let encodedData = try? encoder.encode(notes) {
			defaults.set(encodedData, forKey: UserDefaultsNotesKey)
		}
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
