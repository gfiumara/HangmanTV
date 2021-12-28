/*
 * HMAGameViewController.swift
 * Part of https://github.com/gfiumara/HangmanTV by Gregory Fiumara.
 * See LICENSE for details.
 */

import UIKit

open class HMAGameViewController: UIViewController
{
	open var difficulty:Difficulty {
		didSet
		{
			self.game = HangmanGame(difficulty:self.difficulty)
		}
	}

	@IBOutlet weak fileprivate var keyboardView:HMAKeyboardCollectionView!
	@IBOutlet weak fileprivate var guessedWordLabel: UILabel!
	@IBOutlet weak fileprivate var gallowsDrawingView: GallowsView!
	@IBOutlet weak var difficultyLabel: UILabel!
	@IBOutlet weak fileprivate var afterGameNextStepView: UIStackView!
	fileprivate var game:HangmanGame
	fileprivate var usedLetters: [IndexPath] = [IndexPath]()

	public
	required
	init?(coder aDecoder: NSCoder)
	{
		self.difficulty = .Easy
		self.game = HangmanGame(difficulty:self.difficulty)
		super.init(coder:aDecoder)
	}

	override open func viewWillAppear(_ animated:Bool)
	{
		super.viewWillAppear(animated)
		self.guessedWordLabel.text = self.game.printableGuessedWord
		self.updateDifficultyLabel()
	}

	@IBAction func keyboardButtonPressed(_ sender:UIButton)
	{
		let indexPath = IndexPath(row:sender.tag - HMAConstants.Values.UnicodeA, section:0)
		self.usedLetters.append(indexPath)

		let cell:HMAKeyboardCollectionViewCell? = keyboardView.cellForItem(at: indexPath) as! HMAKeyboardCollectionViewCell?
		cell?.label.textColor = UIColor.systemGray
		cell?.button.isEnabled = false
		cell?.isUserInteractionEnabled = false

		/* Guess the letter */
		if let guessedLetter = UnicodeScalar(sender.tag) {
			let correctGuess = self.game.guessLetter(guessedLetter.escaped(asASCII:true).first!)
			if (correctGuess) {
				cell?.button.setBackgroundImage(UIColor.systemGreen.withAlphaComponent(0.3).image(), for:.disabled)
				cell?.button.setBackgroundImage(UIColor.systemGreen.withAlphaComponent(0.9).image(), for:.focused)
			} else {
				cell?.button.setBackgroundImage(UIColor.systemRed.withAlphaComponent(0.3).image(), for:.disabled)
				cell?.button.setBackgroundImage(UIColor.systemRed.withAlphaComponent(0.9).image(), for:.focused)
			}

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
	}

	@IBAction func newGameButtonPressed(_ sender:UIButton)
	{
		self.beginNewGame()
	}

	@IBAction func menuButtonPressed(_ sender:UIButton)
	{
		self.dismiss(animated: true, completion: nil)
	}

	fileprivate
	func beginNewGame()
	{
		self.game = HangmanGame(difficulty:self.difficulty)

		self.afterGameNextStepView.isHidden = true

		/* Update labels */
		self.updateDifficultyLabel()
		self.guessedWordLabel.text = self.game.printableGuessedWord
		/* Update drawing parameters on the gallows view */
		self.gallowsDrawingView.remainingChances = self.game.remainingGuesses
		self.gallowsDrawingView.gameLost = false
		self.gallowsDrawingView.gameWon = false
		gallowsDrawingView.setNeedsDisplay()

		/* Restore keyboard */
		self.resetKeyboardViewColors()
		self.keyboardView.isUserInteractionEnabled = true
		self.keyboardView.setNeedsFocusUpdate()
		self.keyboardView.setNeedsDisplay()
		self.setNeedsFocusUpdate()
	}

	fileprivate
	func resetKeyboardViewColors()
	{
		for row in 0...(self.keyboardView.numberOfItems(inSection: 0) - 1) {
			let cell:HMAKeyboardCollectionViewCell? = keyboardView.cellForItem(at: IndexPath(row: row, section: 0)) as! HMAKeyboardCollectionViewCell?
			cell?.label.textColor = UIColor.white
			cell?.button.isEnabled = true
			cell?.isUserInteractionEnabled = true
			cell?.button.setBackgroundImage(nil, for:.disabled)
			cell?.button.setBackgroundImage(nil, for:.focused)
		}

		self.usedLetters.removeAll()
	}

	fileprivate
	func endOfGameDisplay()
	{
		if !self.game.gameOver {
			return;
		}

		self.keyboardView.isUserInteractionEnabled = false
		self.keyboardView.setNeedsFocusUpdate()
		self.guessedWordLabel.attributedText = self.game.printableWordWithColoredUnguessedLetters
		self.afterGameNextStepView.isHidden = false

		for row in 0...(self.keyboardView.numberOfItems(inSection: 0) - 1) {
			let cell:HMAKeyboardCollectionViewCell? = keyboardView.cellForItem(at: IndexPath(row:row, section: 0)) as! HMAKeyboardCollectionViewCell?
			cell?.label.textColor = UIColor.systemGray
		}
	}

	fileprivate
	func updateDifficultyLabel()
	{
		self.difficultyLabel.text = "Guesses: " + String(self.game.numberOfGuesses) + " (" + String(self.game.remainingGuesses) + " remaining), Difficulty: " + self.game.wordlist.difficulty.rawValue
	}
}


extension HMAGameViewController : UICollectionViewDelegate
{
	public func collectionView(_ collectionView:UICollectionView, didUpdateFocusIn context:UICollectionViewFocusUpdateContext, with coordinator:UIFocusAnimationCoordinator)
	{
		if context.nextFocusedIndexPath != nil {
			let currentCell:HMAKeyboardCollectionViewCell?  = collectionView.cellForItem(at: context.nextFocusedIndexPath!) as! HMAKeyboardCollectionViewCell?
			currentCell?.label.textColor = UIColor.black
		}

		if context.previouslyFocusedIndexPath != nil {
			let previousCell:HMAKeyboardCollectionViewCell? = collectionView.cellForItem(at: context.previouslyFocusedIndexPath!) as! HMAKeyboardCollectionViewCell?
			if previousCell?.isUserInteractionEnabled ?? false {
				previousCell?.label.textColor = UIColor.white
			}
		}
	}

	public func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool
	{
		return (false)
	}
}
