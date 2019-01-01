/*
 * HangmanGame.swift
 * Part of https://github.com/gfiumara/HangmanTV by Gregory Fiumara.
 * See LICENSE for details.
 */

import Foundation
import UIKit

public struct HangmanGame
{
	/** Wordlist from which this game is based */
	public fileprivate(set) var wordlist:Wordlist
	/** Array of letters that have been guessed */
	fileprivate var guessedLetters:[Character] = []
	/** The actual word that is being guessed */
	public fileprivate(set) var word:String
	/** Number of guesses that have been guessed */
	public var numberOfGuesses:Int
	{
		get
		{
			return self.guessedLetters.count
		}
	}
	/** Word where only guessed letters are printed */
	public var printableGuessedWord:String
	{
		get
		{
			var printableWord:String = ""
			for (i, c) in self.word.enumerated() {
				if self.guessedLetters.contains(c) {
					printableWord += String(c)
				} else {
					printableWord += String(HMAConstants.Values.UnguessedCharacter)
				}

				if i != (self.word.count - 1) {
					printableWord += " "
				}
			}

			return (printableWord)
		}
	}
	/** Space-separated word */
	public var printableWord:String
	{
		get
		{
			var printableWord:String = ""
			for (i, c) in self.word.enumerated() {
				printableWord += String(c)
				if i != (self.word.count - 1) {
					printableWord += " "
				}
			}

			return (printableWord)
		}
	}
	/** Number of guesses */
	public fileprivate(set) var remainingGuesses = HMAConstants.Values.NumberOfChances;
	/** Whether or not the game is over */
	public var gameOver:Bool
	{
		get
		{
			return (self.gameLost || self.gameWon)
		}
	}
	/** Whether or not the game has been won */
	public var gameWon:Bool
	{
		get
		{
			return ((!self.printableGuessedWord.contains(HMAConstants.Values.UnguessedCharacter)) &&
				(!self.gameLost))
		}
	}
	/** Whether or not the game has been lost */
	public var gameLost:Bool
	{
		get
		{
			return (self.remainingGuesses == 0)
		}
	}
	public var printableWordWithColoredUnguessedLetters:NSAttributedString
	{
		get
		{
			let coloredWord:NSMutableAttributedString = NSMutableAttributedString(string:self.printableWord)
			for (i, c) in self.printableWord.enumerated() {
				if self.guessedLetters.contains(c) {
					coloredWord.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor(red:0.36, green:0.76, blue:0.32, alpha:1.0), range:NSMakeRange(i, 1))
				} else {
					coloredWord.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor.red, range:NSMakeRange(i, 1))
				}
			}

			return (coloredWord)
		}
	}

	public
	init(difficulty:Difficulty)
	{
		self.wordlist = Wordlist(difficulty:difficulty)
		self.word = self.wordlist.getWord() as String
	}

	public
	mutating
	func guessLetter(_ letter:Character) -> Bool
	{
		if (self.remainingGuesses <= 0) {
			return (false)
		}

		self.guessedLetters.append(letter)

		let wordContainsGuess = self.word.contains(letter)
		if (!wordContainsGuess) {
			self.remainingGuesses -= 1
		}
		return (wordContainsGuess)
	}
}
