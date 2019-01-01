/*
 * HMAKeyboardCollectionView.swift
 * Part of https://github.com/gfiumara/HangmanTV by Gregory Fiumara.
 * See LICENSE for details.
 */

import UIKit

class HMAKeyboardCollectionView : UICollectionView
{
	var usedIndexPaths:[IndexPath] = [IndexPath]()

	required init?(coder aDecoder:NSCoder)
	{
		super.init(coder:aDecoder);
		self.dataSource = self;
	}
}

extension HMAKeyboardCollectionView : UICollectionViewDataSource
{
	func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section:Int) -> Int
	{
		return (26)
	}

	func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
	{
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HMAConstants.Identifiers.KeyboardCellID, for:indexPath) as! HMAKeyboardCollectionViewCell
		cell.label.text = UnicodeScalar(HMAConstants.Values.UnicodeA + indexPath.row)?.escaped(asASCII:true)
		cell.button.tag = (HMAConstants.Values.UnicodeA + indexPath.row)

		cell.button.setTitleColor(UIColor.black, for:.focused)
		cell.button.setTitleColor(UIColor.lightGray, for:.disabled)
		
		return (cell)
	}
}
