//
//  CategorySelectionView.swift
//  Boring
//
//  Created by Deniz Mersinlioğlu on 1.07.2022.
//

import ComposableArchitecture
import SwiftUI

// MARK: - CategorySelectionState

struct CategorySelectionState: Equatable {
	var activity: Activity?
}

// MARK: - CategorySelectionAction

enum CategorySelectionAction: Equatable {
	case categorySelected(Category)
}

// MARK: - CategorySelectionEnvironment

struct CategorySelectionEnvironment {
	var uuid: () -> UUID
	var mainQueue: AnySchedulerOf<DispatchQueue>
}

// MARK: - CategorySelectionView

struct CategorySelectionView: View {
	var body: some View {
		Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
	}
}

// MARK: - CategorySelectionView_Previews

struct CategorySelectionView_Previews: PreviewProvider {
	static var previews: some View {
		CategorySelectionView()
	}
}
