//
//  ViewController.swift
//  Notes
//
//  Created by Paul Richardson on 29/05/2021.
//

import UIKit

class ViewController: UITableViewController, DetailViewControllerDelegate {

	// MARK:- Properties

	var items: UIBarButtonItem!

	var notes: [Note]? {
		didSet {
			guard let _ = items  else { return }
			self.items.title = itemCountText
		}
	}

	var itemCountText: String {
		guard let count = notes?.count else { return "" }
		return "\(count) " + (count == 1 ? "Note" : "Notes")
	}
 // MARK:- Life Cycle

	override func viewDidLoad() {
		super.viewDidLoad()

		navigationController?.navigationBar.prefersLargeTitles = true
		title = "Notes"

		if notes == nil {
			loadNotes()
		}

		let space = UIBarButtonItem(systemItem: .flexibleSpace)
		let compose = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(compose))

		items = UIBarButtonItem(title: itemCountText, style: .plain, target: nil, action: nil)
		let attributes: [NSAttributedString.Key: Any] = [
			.font: UIFont.preferredFont(forTextStyle: .footnote),
			.foregroundColor: UIColor.label]
		items.setTitleTextAttributes(attributes, for: .disabled)
		items.isEnabled = false

		setToolbarItems([space, items, space, compose], animated: true)
		navigationController?.isToolbarHidden = false

		let notificationCenter = NotificationCenter.default
		notificationCenter.addObserver(self, selector: #selector(noteDidChange), name: .noteTextViewDidEndEditing, object: nil)

	}

	// MARK:- Private Methods

	fileprivate func loadNotes() {
		let defaults = UserDefaults.standard
		if let encodedData = defaults.data(forKey: .Notes) {
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
			defaults.set(encodedData, forKey: .Notes)
		}
	}

	@objc fileprivate func compose() {
		let vc = DetailViewController()
		let placeholder = Note.placeholder
		vc.note = placeholder
		vc.delegate = self
		if let _ = notes?.count {
			notes?.insert(placeholder, at: 0)
		} else {
			notes = [placeholder]
		}
		tableView.reloadData()
		navigationController?.pushViewController(vc, animated: true)
	}

	@objc fileprivate func noteDidChange(notification: Notification) {
		if let userInfo = notification.userInfo {
			if let editedNote = userInfo["note"] as? Note {
				if let index = notes?.firstIndex(where: { note in
					note.id == editedNote.id
				}) {
					notes?[index] = editedNote
				}
				save()
				tableView.reloadData()
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
		vc.delegate = self
		if let note = notes?[indexPath.row] {
			vc.note = note
		}
		navigationController?.pushViewController(vc, animated: true)
	}

	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		switch editingStyle {
		case .delete:
			notes?.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .automatic)
			save()
		default:
			break
		}
	}

	// MARK:- DetailViewController Delegate Methods

	func didLeavePlaceholderUnchanged(_ note: Note) {
		if let index = notes?.firstIndex(where: {$0.id == note.id}) {
			notes?.remove(at: index)
			tableView.reloadData()
		}
	}

}
