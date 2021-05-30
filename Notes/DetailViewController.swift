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

		let titleTextField = UITextField()
		titleTextField.text = noteTitle ?? "My New Note"
		titleTextField.sizeToFit()
		titleTextField.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(titleTextField)

		let constraints = [
			titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
			titleTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
		]

				NSLayoutConstraint.activate(constraints)

	}


	/*
	// MARK: - Navigation

	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destination.
	// Pass the selected object to the new view controller.
	}
	*/

}
