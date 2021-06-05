//
//  DetailViewController.swift
//  Notes
//
//  Created by Paul Richardson on 30/05/2021.
//

import UIKit

class DetailViewController: UIViewController, UITextViewDelegate {

	@IBOutlet var noteTextView: UITextView!
	var note: Note?

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		navigationController?.navigationBar.prefersLargeTitles = false

		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(endEditing))

		noteTextView = UITextView()
		noteTextView.delegate = self

		if let noteText = note?.text {
			let attributedString = NSMutableAttributedString(string: noteText, attributes: [.font: UIFont.preferredFont(forTextStyle: .body)])
			if let firstParagraphIndex = noteText.components(separatedBy: .newlines).first?.count {
			attributedString.addAttribute(.font, value: UIFont.preferredFont(forTextStyle: .largeTitle), range: NSRange(location: 0, length: firstParagraphIndex))
			}
			noteTextView.attributedText = attributedString
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

		let notificationCenter = NotificationCenter.default
		notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
		notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

	}

	@objc func endEditing() {
		note?.text = noteTextView.text
		noteTextView.resignFirstResponder()
	}

	func textViewDidEndEditing(_ textView: UITextView) {
		let notificationCenter = NotificationCenter.default
		let notification = Notification(name: .noteTextViewDidEndEditing, object: nil, userInfo: ["note": note as Any])
		notificationCenter.post(notification)
	}

	@objc func adjustForKeyboard(notification: Notification) {
		guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

		let keyboardScreenEndFrame = keyboardValue.cgRectValue
		let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

		if notification.name == UIResponder.keyboardWillHideNotification {
			noteTextView.contentInset = .zero
		} else {
			noteTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
		}

		noteTextView.scrollIndicatorInsets = noteTextView.contentInset

		let selectedRange = noteTextView.selectedRange
		noteTextView.scrollRangeToVisible(selectedRange)

	}
}
