/*
 * HMAGameViewController.swift
 * Part of http://github.com/gfiumara/HangmanTV by Gregory Fiumara.
 * See LICENSE for details.
 */

import UIKit

public class HMAGameViewController: UIViewController
{
	public var difficulty:Difficulty {
		didSet
		{
			self.game = HangmanGame(difficulty:self.difficulty)
		}
	}

	@IBOutlet weak private var keyboardView:HMAKeyboardCollectionView!
	@IBOutlet weak private var guessedWordLabel: UILabel!
	@IBOutlet weak private var gallowsDrawingView: GallowsView!
	@IBOutlet weak var difficultyLabel: UILabel!
	private var game:HangmanGame

	public
	required
	init?(coder aDecoder: NSCoder)
	{
		self.difficulty = .Easy
		self.game = HangmanGame(difficulty:self.difficulty)
		super.init(coder:aDecoder)
	}

	override public func viewWillAppear(animated:Bool)
	{
		super.viewWillAppear(animated)
		self.guessedWordLabel.text = self.game.printableGuessedWord
		self.updateDifficultyLabel()
	}

	@IBAction func keyboardButtonPressed(sender:UIButton)
	{
		let cell:HMAKeyboardCollectionViewCell? = keyboardView.cellForItemAtIndexPath(NSIndexPath(forRow:sender.tag - HMAConstants.Values.UnicodeA, inSection:0)) as! HMAKeyboardCollectionViewCell?
		cell?.label.textColor = UIColor.lightGrayColor()
		cell?.button.enabled = false
		cell?.userInteractionEnabled = false

		/* Guess the letter */
		self.game.guessLetter(UnicodeScalar(sender.tag).escape(asASCII:true).characters.first!)

		/* Update labels */
		self.updateDifficultyLabel()
		self.guessedWordLabel.text = self.game.printableGuessedWord
		/* Update drawing parameters on the gallows view */
		self.gallowsDrawingView.remainingChances = self.game.remainingGuesses
		self.gallowsDrawingView.gameLost = self.game.gameLost
		self.gallowsDrawingView.gameWon = self.game.gameWon
		gallowsDrawingView.setNeedsDisplay()

		/* Change focus of elements if the game is over */
		if self.game.gameOver {
			self.endOfGameDisplay()
		}
	}

	private
	func endOfGameDisplay()
	{
		if !self.game.gameOver {
			return;
		}

		self.keyboardView.userInteractionEnabled = false
		self.keyboardView.setNeedsFocusUpdate()
		self.guessedWordLabel.attributedText = self.game.printableWordWithColoredUnguessedLetters
	}

	private
	func updateDifficultyLabel()
	{
		self.difficultyLabel.text = "Guesses: " + String(self.game.numberOfGuesses) + " (" + String(self.game.remainingGuesses) + " remaining), Difficulty: " + self.game.wordlist.difficulty.rawValue
	}
}


extension HMAGameViewController : UICollectionViewDelegate
{
	public func collectionView(collectionView:UICollectionView, didUpdateFocusInContext context:UICollectionViewFocusUpdateContext, withAnimationCoordinator coordinator:UIFocusAnimationCoordinator)
	{
		if context.nextFocusedIndexPath != nil {
			let currentCell:HMAKeyboardCollectionViewCell?  = collectionView.cellForItemAtIndexPath(context.nextFocusedIndexPath!) as! HMAKeyboardCollectionViewCell?
			currentCell?.label.textColor = UIColor.blackColor()
		}

		if context.previouslyFocusedIndexPath != nil {
			let previousCell:HMAKeyboardCollectionViewCell? = collectionView.cellForItemAtIndexPath(context.previouslyFocusedIndexPath!) as! HMAKeyboardCollectionViewCell?
			if previousCell?.userInteractionEnabled ?? false {
				previousCell?.label.textColor = UIColor.whiteColor()
			}
		}
	}

	public func collectionView(collectionView: UICollectionView, canFocusItemAtIndexPath indexPath: NSIndexPath) -> Bool
	{
		return (false)
	}
}
