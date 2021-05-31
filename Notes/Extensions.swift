//
//  Extensions.swift
//  Notes
//
//  Created by Paul Richardson on 31/05/2021.
//

import Foundation

extension Notification.Name {
	static let noteTextViewDidEndEditing = NSNotification.Name("noteTextViewDidEndEditing")
}

extension UserDefaults {
	enum Key: String {
		case Notes = "notes"
	}

	func data(forKey key: Key) -> Data? {
		return data(forKey: key.rawValue)
	}

	func set(_ data: Data?, forKey key: Key) {
		set(data, forKey: key.rawValue)
	}
}
