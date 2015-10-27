/*
 * HMAKeyboardCollectionView.swift
 * Part of http://github.com/gfiumara/HangmanTV by Gregory Fiumara.
 * See LICENSE for details.
 */

import UIKit

class HMAKeyboardCollectionView : UICollectionView
{
	var usedIndexPaths:[NSIndexPath] = [NSIndexPath]()

	required init?(coder aDecoder:NSCoder)
	{
		super.init(coder:aDecoder);
		self.dataSource = self;
	}
}

extension HMAKeyboardCollectionView : UICollectionViewDataSource
{
	func collectionView(collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
	{
		return (26)
	}

	func collectionView(collectionView:UICollectionView, cellForItemAtIndexPath indexPath:NSIndexPath) -> UICollectionViewCell
	{
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier(HMAConstants.Identifiers.KeyboardCellID, forIndexPath:indexPath) as! HMAKeyboardCollectionViewCell
		cell.label.text = UnicodeScalar(HMAConstants.Values.UnicodeA + indexPath.row).escape(asASCII:true)
		cell.button.tag = (HMAConstants.Values.UnicodeA + indexPath.row)

		cell.button.setTitleColor(UIColor.blackColor(), forState:.Focused)
		cell.button.setTitleColor(UIColor.lightGrayColor(), forState:.Disabled)
		
		return (cell)
	}
}
