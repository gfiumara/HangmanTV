/*
 * GallowsView.swift
 * Part of http://github.com/gfiumara/HangmanTV by Gregory Fiumara.
 * See LICENSE for details.
 */

import UIKit

public class GallowsView : UIView
{
	public var remainingChances:UInt8 = HMAConstants.Values.NumberOfChances
	{
		didSet
		{
			self.setNeedsDisplay()
		}
	}
	public var gameLost:Bool = false
	public var gameWon:Bool = false

	override
	public
	func drawRect(rect: CGRect)
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

	public
	func decrementChances()
	{
		if (self.remainingChances > 0) {
			self.remainingChances -= 1
		}

		if (self.remainingChances == 0) {
			self.gameLost = true
		}
	}

	private
	func drawGallows()
	{
		UIColor.brownColor().setFill()

		let ground = UIBezierPath(rect: CGRectMake(40, 0, 20, 800))
		ground.fill()

		let leftSide = UIBezierPath(rect: CGRectMake(0, 780, 100, 20))
		leftSide.fill()

		let nooseHolder = UIBezierPath(rect: CGRectMake(40, 0, 400, 20))
		nooseHolder.fill()

		let noose = UIBezierPath(rect: CGRectMake(420, 0, 20, 100))
		noose.fill()
	}

	private
	func drawHead()
	{
		let ovalPath = UIBezierPath(ovalInRect: CGRectMake(355, 100, 150, 150))
		UIColor.grayColor().setFill()
		ovalPath.fill()
	}

	private
	func drawChest()
	{
		let rectangle5Path = UIBezierPath(rect: CGRectMake(420, 250, 20, 300))
		UIColor.grayColor().setFill()
		rectangle5Path.fill()
	}

	private
	func drawRightArm()
	{
		let bezierPath = UIBezierPath()
		bezierPath.moveToPoint(CGPointMake(436, 400))
		bezierPath.addLineToPoint(CGPointMake(562, 274))
		bezierPath.lineCapStyle = .Round;

		bezierPath.lineJoinStyle = .Round;

		UIColor.grayColor().setStroke()
		bezierPath.lineWidth = 20
		bezierPath.stroke()
	}

	private
	func drawLeftArm()
	{
		let bezier2Path = UIBezierPath()
		bezier2Path.moveToPoint(CGPointMake(424, 400))
		bezier2Path.addLineToPoint(CGPointMake(298, 274))
		bezier2Path.lineCapStyle = .Round;

		bezier2Path.lineJoinStyle = .Round;

		UIColor.grayColor().setStroke()
		bezier2Path.lineWidth = 20
		bezier2Path.stroke()
	}

	private
	func drawLeftLeg()
	{
		let bezier3Path = UIBezierPath()
		bezier3Path.moveToPoint(CGPointMake(428, 546))
		bezier3Path.addLineToPoint(CGPointMake(302, 672))
		bezier3Path.lineCapStyle = .Round;

		bezier3Path.lineJoinStyle = .Round;

		UIColor.grayColor().setStroke()
		bezier3Path.lineWidth = 20
		bezier3Path.stroke()
	}

	private
	func drawRightLeg()
	{
		let bezier4Path = UIBezierPath()
		bezier4Path.moveToPoint(CGPointMake(432, 546))
		bezier4Path.addLineToPoint(CGPointMake(558, 672))
		bezier4Path.lineCapStyle = .Round;

		bezier4Path.lineJoinStyle = .Round;

		UIColor.grayColor().setStroke()
		bezier4Path.lineWidth = 20
		bezier4Path.stroke()
	}

	private
	func drawGameOver()
	{
		//// General Declarations
		let context = UIGraphicsGetCurrentContext()

		//// Game Over Drawing
		let gameOverRect = CGRectMake(0, 0, 800, 800)
		let gameOverTextContent = NSString(string: "GAME\nOVER")
		let gameOverStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
		gameOverStyle.alignment = .Center

		let gameOverFontAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(200), NSForegroundColorAttributeName: UIColor.redColor(), NSParagraphStyleAttributeName: gameOverStyle]

		let gameOverTextHeight: CGFloat = gameOverTextContent.boundingRectWithSize(CGSizeMake(gameOverRect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: gameOverFontAttributes, context: nil).size.height
		CGContextSaveGState(context)
		CGContextClipToRect(context, gameOverRect);
		gameOverTextContent.drawInRect(CGRectMake(gameOverRect.minX, gameOverRect.minY + (gameOverRect.height - gameOverTextHeight) / 2, gameOverRect.width, gameOverTextHeight), withAttributes: gameOverFontAttributes)
		CGContextRestoreGState(context)
	}

	private
	func drawGameWon()
	{
		//// General Declarations
		let context = UIGraphicsGetCurrentContext()

		//// win Drawing
		let winRect = CGRectMake(0, 0, 800, 800)
		let winTextContent = NSString(string: "WIN!")
		let winStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
		winStyle.alignment = .Center

		let winFontAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(200), NSForegroundColorAttributeName: UIColor(red:0.36, green:0.76, blue:0.32, alpha:1.0), NSParagraphStyleAttributeName: winStyle]

		let winTextHeight: CGFloat = winTextContent.boundingRectWithSize(CGSizeMake(winRect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: winFontAttributes, context: nil).size.height
		CGContextSaveGState(context)
		CGContextClipToRect(context, winRect);
		winTextContent.drawInRect(CGRectMake(winRect.minX, winRect.minY + (winRect.height - winTextHeight) / 2, winRect.width, winTextHeight), withAttributes: winFontAttributes)
		CGContextRestoreGState(context)
	}
}
