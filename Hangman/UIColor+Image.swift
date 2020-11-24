/*
 * Wordlist.swift
 * Part of https://github.com/gfiumara/HangmanTV by Gregory Fiumara.
 * See LICENSE for details.
 */

import UIKit

/**
 * @copyright CC BY-SA 4.0, https://stackoverflow.com/users/78336/neoneye
 * @see https://stackoverflow.com/a/48441178/
 */
extension UIColor {
	func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
		return UIGraphicsImageRenderer(size: size).image { rendererContext in
			self.setFill()
			rendererContext.fill(CGRect(origin: .zero, size: size))
		}
	}
}
