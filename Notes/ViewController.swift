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

		navigationController?.navigationBar.prefersLargeTitles = true
		title = "Notes"

		let space = UIBarButtonItem(systemItem: .flexibleSpace)
		let compose = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(compose))
		setToolbarItems([space, compose], animated: true)
		navigationController?.isToolbarHidden = false

		if notes == nil {
			loadNotes()
		}

		let notificationCenter = NotificationCenter.default
		notificationCenter.addObserver(self, selector: #selector(noteDidChange), name: .noteTextViewDidEndEditing, object: nil)

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
		let encoder = JSONEncoder()
		if let encodedData = try? encoder.encode(notes) {
			let defaults = UserDefaults.standard
			defaults.set(encodedData, forKey: UserDefaultsNotesKey)
		}
	}

	@objc fileprivate func compose() {
		let vc = DetailViewController()
		let placeholder = Note.placeholder
		vc.note = placeholder
		if let _ = notes?.count {
			notes?.insert(placeholder, at: 0)
		} else {
			notes = [placeholder]
		}
		tableView.reloadData()
		navigationController?.pushViewController(vc, animated: true)
	}

	@objc func noteDidChange(notification: Notification) {
		if let userInfo = notification.userInfo {
			if let note = userInfo["note"] as? Note {
				// do stuff
				print("ID: \(note.id)")
			}
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
		if let note = notes?[indexPath.row] {
			vc.note = note
		}
		navigationController?.pushViewController(vc, animated: true)
	}

}
