//
//  Font.swift
//  Boring
//
//  Created by Deniz Mersinlioğlu on 1.07.2022.
//

import SwiftUI

extension UILabel {
	var substituteFontName: String {
		get { font.fontName }
		set { font = UIFont(name: newValue, size: 17)! }
	}
}

extension Font {

	static let roboto = Roboto()

	struct Roboto {
		private let regular = "Roboto-Regular"
		private let black = "Roboto-Black"
		private let bold = "Roboto-Bold"
		private let light = "Roboto-Light"
		private let medium = "Roboto-Medium"

		fileprivate init() {}

		func regular(_ size: CGFloat) -> Font {
			Font
				.custom(regular, size: size)
				.weight(.regular)
		}

		func semibold(_ size: CGFloat) -> Font {
			Font
				.custom(regular, size: size)
				.weight(.semibold)
		}

		func medium(_ size: CGFloat) -> Font {
			Font
				.custom(medium, size: size)
				.weight(.medium)
		}

		func black(_ size: CGFloat) -> Font {
			Font
				.custom(black, size: size)
				.weight(.heavy)
		}

		func bold(_ size: CGFloat) -> Font {
			Font
				.custom(bold, size: size)
				.weight(.bold)
		}

		func light(_ size: CGFloat) -> Font {
			Font
				.custom(light, size: size)
				.weight(.light)
		}
	}
}
