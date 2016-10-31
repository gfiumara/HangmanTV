/*
 * Wordlist.swift
 * Part of http://github.com/gfiumara/HangmanTV by Gregory Fiumara.
 * See LICENSE for details.
 */

import Foundation

public enum Difficulty:String
{
	case Easy = "Easy"
	case Medium = "Medium"
	case Hard = "Hard"
}

public struct Wordlist
{
	fileprivate var wordlist:NSArray!
	public fileprivate(set) var difficulty:Difficulty

	public
	init(difficulty:Difficulty)
	{
		self.difficulty = difficulty
		self.loadWordlist(difficulty);
	}

	fileprivate
	mutating
	func loadWordlist(_ difficulty:Difficulty)
	{
		var wordlistPath:String
		switch (difficulty) {
		case .Easy:
			wordlistPath = Bundle.main.path(forResource: "easy", ofType:"plist")!
		case .Medium:
			wordlistPath = Bundle.main.path(forResource: "medium", ofType:"plist")!
		case .Hard:
			wordlistPath = Bundle.main.path(forResource: "hard", ofType:"plist")!
		}

		self.wordlist = NSArray(contentsOfFile:wordlistPath)
	}

	public
	func getWord() -> NSString
	{
		return (self.wordlist.object(at: Int(arc4random_uniform(UInt32(self.wordlist.count)))) as AnyObject).uppercased as NSString
	}
}
