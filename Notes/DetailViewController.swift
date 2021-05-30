//
//  DetailViewController.swift
//  Notes
//
//  Created by Paul Richardson on 30/05/2021.
//

import UIKit

class DetailViewController: UIViewController {

	var noteTitle: String?

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white

		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(save))

		let titleTextField = UITextField()
		if let noteTitle = noteTitle {
			titleTextField.text = noteTitle
		}
		titleTextField.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(titleTextField)

		let constraints = [
			titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
			titleTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
			titleTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
		]

		NSLayoutConstraint.activate(constraints)

	}

	@objc func save() {
		//
	}

}
