//
//  CategorySelectionView.swift
//  Boring
//
//  Created by Deniz Mersinlioğlu on 1.07.2022.
//

import ComposableArchitecture
import SwiftUI

struct CategorySelectionState: Equatable {
	var activity: Activity?
}

enum CategorySelectionAction: Equatable {
	case categorySelected(Category)
}

struct CategorySelectionEnvironment {
	var uuid: () -> UUID
	var mainQueue: AnySchedulerOf<DispatchQueue>
}

let categorySelectionReducer: Reducer<CategorySelectionState, CategorySelectionAction, CategorySelectionEnvironment> = .init { state, action, environment in
	switch action {
	case let .categorySelected(category):
		return .none
	}
}

struct CategorySelectionView: View {

	let store: Store<CategorySelectionState, CategorySelectionAction>

	var body: some View {
		Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
	}
}

struct CategorySelectionView_Previews: PreviewProvider {
	static var previews: some View {
		CategorySelectionView(
			store: .init(
				initialState: .init(),
				reducer: categorySelectionReducer,
				environment: CategorySelectionEnvironment(
					uuid: UUID.init,
					mainQueue: DispatchQueue.main.eraseToAnyScheduler()
				)
			)
		)
	}
}
