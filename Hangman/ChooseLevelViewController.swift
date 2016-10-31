/*
 * ChooseLevelViewController.swift
 * Part of http://github.com/gfiumara/HangmanTV by Gregory Fiumara.
 * See LICENSE for details.
 */

import UIKit

class ChooseLevelViewController: UIViewController
{
	override func prepare(for segue:UIStoryboardSegue, sender:Any?)
	{
		/* Choose difficulty based on segue identifier */
		let vc:HMAGameViewController = segue.destination as! HMAGameViewController
		if segue.identifier == Difficulty.Medium.rawValue {
			vc.difficulty = .Medium
		} else if segue.identifier == Difficulty.Hard.rawValue {
			vc.difficulty = .Hard
		} else {
			vc.difficulty = .Easy
		}
	}
}

