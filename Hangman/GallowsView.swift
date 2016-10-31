/*
 * GallowsView.swift
 * Part of http://github.com/gfiumara/HangmanTV by Gregory Fiumara.
 * See LICENSE for details.
 */

import UIKit

open class GallowsView : UIView
{
	open var remainingChances:UInt8 = HMAConstants.Values.NumberOfChances
	{
		didSet
		{
			self.setNeedsDisplay()
		}
	}
	open var gameLost:Bool = false
	open var gameWon:Bool = false

	override
	open
	func draw(_ rect: CGRect)
	{
		self.drawGallows()

		switch (self.remainingChances) {
		case 0:
			self.drawRightLeg()
			fallthrough
		case 1:
			self.drawLeftLeg()
			fallthrough
		case 2:
			self.drawRightArm()
			fallthrough
		case 3:
			self.drawLeftArm()
			fallthrough
		case 4:
			self.drawChest()
			fallthrough
		case 5:
			self.drawHead()
			break;
		default:
			break;
		}

		/* Draw "Game Over" last so that it goes overtop the body */
		if (self.gameLost) {
			self.drawGameOver()
		} else if (self.gameWon) {
			self.drawGameWon()
		}
	}

	open
	func decrementChances()
	{
		if (self.remainingChances > 0) {
			self.remainingChances -= 1
		}

		if (self.remainingChances == 0) {
			self.gameLost = true
		}
	}

	fileprivate
	func drawGallows()
	{
		UIColor.brown.setFill()

		let ground = UIBezierPath(rect: CGRect(x: 40, y: 0, width: 20, height: 800))
		ground.fill()

		let leftSide = UIBezierPath(rect: CGRect(x: 0, y: 780, width: 100, height: 20))
		leftSide.fill()

		let nooseHolder = UIBezierPath(rect: CGRect(x: 40, y: 0, width: 400, height: 20))
		nooseHolder.fill()

		let noose = UIBezierPath(rect: CGRect(x: 420, y: 0, width: 20, height: 100))
		noose.fill()
	}

	fileprivate
	func drawHead()
	{
		let ovalPath = UIBezierPath(ovalIn: CGRect(x: 355, y: 100, width: 150, height: 150))
		UIColor.gray.setFill()
		ovalPath.fill()
	}

	fileprivate
	func drawChest()
	{
		let rectangle5Path = UIBezierPath(rect: CGRect(x: 420, y: 250, width: 20, height: 300))
		UIColor.gray.setFill()
		rectangle5Path.fill()
	}

	fileprivate
	func drawRightArm()
	{
		let bezierPath = UIBezierPath()
		bezierPath.move(to: CGPoint(x: 436, y: 400))
		bezierPath.addLine(to: CGPoint(x: 562, y: 274))
		bezierPath.lineCapStyle = .round;

		bezierPath.lineJoinStyle = .round;

		UIColor.gray.setStroke()
		bezierPath.lineWidth = 20
		bezierPath.stroke()
	}

	fileprivate
	func drawLeftArm()
	{
		let bezier2Path = UIBezierPath()
		bezier2Path.move(to: CGPoint(x: 424, y: 400))
		bezier2Path.addLine(to: CGPoint(x: 298, y: 274))
		bezier2Path.lineCapStyle = .round;

		bezier2Path.lineJoinStyle = .round;

		UIColor.gray.setStroke()
		bezier2Path.lineWidth = 20
		bezier2Path.stroke()
	}

	fileprivate
	func drawLeftLeg()
	{
		let bezier3Path = UIBezierPath()
		bezier3Path.move(to: CGPoint(x: 428, y: 546))
		bezier3Path.addLine(to: CGPoint(x: 302, y: 672))
		bezier3Path.lineCapStyle = .round;

		bezier3Path.lineJoinStyle = .round;

		UIColor.gray.setStroke()
		bezier3Path.lineWidth = 20
		bezier3Path.stroke()
	}

	fileprivate
	func drawRightLeg()
	{
		let bezier4Path = UIBezierPath()
		bezier4Path.move(to: CGPoint(x: 432, y: 546))
		bezier4Path.addLine(to: CGPoint(x: 558, y: 672))
		bezier4Path.lineCapStyle = .round;

		bezier4Path.lineJoinStyle = .round;

		UIColor.gray.setStroke()
		bezier4Path.lineWidth = 20
		bezier4Path.stroke()
	}

	fileprivate
	func drawGameOver()
	{
		//// General Declarations
		let context = UIGraphicsGetCurrentContext()

		//// Game Over Drawing
		let gameOverRect = CGRect(x: 0, y: 0, width: 800, height: 800)
		let gameOverTextContent = NSString(string: "GAME\nOVER")
		let gameOverStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
		gameOverStyle.alignment = .center

		let gameOverFontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 200), NSForegroundColorAttributeName: UIColor.red, NSParagraphStyleAttributeName: gameOverStyle]

		let gameOverTextHeight: CGFloat = gameOverTextContent.boundingRect(with: CGSize(width: gameOverRect.width, height: CGFloat.infinity), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: gameOverFontAttributes, context: nil).size.height
		context?.saveGState()
		context?.clip(to: gameOverRect);
		gameOverTextContent.draw(in: CGRect(x: gameOverRect.minX, y: gameOverRect.minY + (gameOverRect.height - gameOverTextHeight) / 2, width: gameOverRect.width, height: gameOverTextHeight), withAttributes: gameOverFontAttributes)
		context?.restoreGState()
	}

	fileprivate
	func drawGameWon()
	{
		//// General Declarations
		let context = UIGraphicsGetCurrentContext()

		//// win Drawing
		let winRect = CGRect(x: 0, y: 0, width: 800, height: 800)
		let winTextContent = NSString(string: "WIN!")
		let winStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
		winStyle.alignment = .center

		let winFontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 200), NSForegroundColorAttributeName: UIColor(red:0.36, green:0.76, blue:0.32, alpha:1.0), NSParagraphStyleAttributeName: winStyle]

		let winTextHeight: CGFloat = winTextContent.boundingRect(with: CGSize(width: winRect.width, height: CGFloat.infinity), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: winFontAttributes, context: nil).size.height
		context?.saveGState()
		context?.clip(to: winRect);
		winTextContent.draw(in: CGRect(x: winRect.minX, y: winRect.minY + (winRect.height - winTextHeight) / 2, width: winRect.width, height: winTextHeight), withAttributes: winFontAttributes)
		context?.restoreGState()
	}
}
