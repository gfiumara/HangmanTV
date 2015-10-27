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
	private var wordlist:NSArray!
	public private(set) var difficulty:Difficulty

	public
	init(difficulty:Difficulty)
	{
		self.difficulty = difficulty
		self.loadWordlist(difficulty);
	}

	private
	mutating
	func loadWordlist(difficulty:Difficulty)
	{
		var wordlistPath:String
		switch (difficulty) {
		case .Easy:
			wordlistPath = NSBundle.mainBundle().pathForResource("easy", ofType:"plist")!
		case .Medium:
			wordlistPath = NSBundle.mainBundle().pathForResource("medium", ofType:"plist")!
		case .Hard:
			wordlistPath = NSBundle.mainBundle().pathForResource("hard", ofType:"plist")!
		}

		self.wordlist = NSArray(contentsOfFile:wordlistPath)
	}

	public
	func getWord() -> NSString
	{
		return self.wordlist.objectAtIndex(Int(arc4random_uniform(UInt32(self.wordlist.count)))).uppercaseString as NSString
	}
}
