//
//  DetailViewController.swift
//  Notes
//
//  Created by Paul Richardson on 30/05/2021.
//

import UIKit

class DetailViewController: UIViewController {

	@IBOutlet var noteTextView: UITextView!
	var noteText: String?

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white

		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(save))

		noteTextView = UITextView()
		noteTextView.backgroundColor = .green
		if let noteTitle = noteText {
			noteTextView.text = noteTitle
		}
		noteTextView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(noteTextView)

		let constraints = [
			noteTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
			noteTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
			noteTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
			noteTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
		]

		NSLayoutConstraint.activate(constraints)

	}

	@objc func save() {
		//
	}

}
