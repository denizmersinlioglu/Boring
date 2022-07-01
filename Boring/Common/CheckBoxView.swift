//
//  CheckBoxView.swift
//  Boring
//
//  Created by Deniz Mersinlioğlu on 1.07.2022.
//

import SwiftUI

// MARK: - CheckBoxView

struct CheckBoxView: View {

	var text: String
	@Binding var checked: Bool

	var body: some View {
		HStack {
			Image(checked ? "check_box_filled" : "check_box")
			Text(text)
				.font(.roboto.medium(14))
				.foregroundColor(.BRPrimaryText)
		}
		.onTapGesture { checked.toggle() }
	}
}

// MARK: - CheckBoxView_Previews

struct CheckBoxView_Previews: PreviewProvider {

	struct CheckBoxViewHolder: View {
		@State var checked = false

		var body: some View {
			CheckBoxView(
				text: "Spam me stuff to do!",
				checked: $checked
			)
		}
	}

	static var previews: some View {
		CheckBoxViewHolder()
	}
}
