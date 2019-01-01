/*
 * Constants.swift
 * Part of https://github.com/gfiumara/HangmanTV by Gregory Fiumara.
 * See LICENSE for details.
 */

import Foundation

struct HMAConstants
{
	struct Identifiers
	{
		/** ID for HMAKeyboardCollectionView cells */
		static let KeyboardCellID = "HMAKeyboardCollectionViewCellIdentifier";
	}

	struct Values
	{
		/** Unicode value for uppercase "A" */
		static let UnicodeA = 65;
		/** Number of chances to guess the word */
		static let NumberOfChances:UInt8 = 6
		/** Placeholder empty string */
		static let UnguessedCharacter:Character = "—"
	}
}
