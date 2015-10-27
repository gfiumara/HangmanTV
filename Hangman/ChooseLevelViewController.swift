/*
 * ChooseLevelViewController.swift
 * Part of http://github.com/gfiumara/HangmanTV by Gregory Fiumara.
 * See LICENSE for details.
 */

import UIKit

class ChooseLevelViewController: UIViewController
{
	override func prepareForSegue(segue:UIStoryboardSegue, sender:AnyObject?)
	{
		/* Choose difficulty based on segue identifier */
		let vc:HMAGameViewController = segue.destinationViewController as! HMAGameViewController
		if segue.identifier == Difficulty.Medium.rawValue {
			vc.difficulty = .Medium
		} else if segue.identifier == Difficulty.Hard.rawValue {
			vc.difficulty = .Hard
		} else {
			vc.difficulty = .Easy
		}
	}
}

