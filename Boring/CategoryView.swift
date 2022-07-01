//
//  CategoryView.swift
//  Boring
//
//  Created by Deniz Mersinlioğlu on 1.07.2022.
//

import ComposableArchitecture
import SwiftUI

struct CategoryState: Equatable {
	var activity: ActivityState?
}

enum CategoryAction: Equatable {
	case categorySelected(Category)
	case activity(ActivityAction)
	case backButtonTapped
}

struct CategoryEnvironment {
	var mainQueue: AnySchedulerOf<DispatchQueue>
	var apiClient: ApiClientProtocol
}

let categoryReducer = Reducer<CategoryState, CategoryAction, CategoryEnvironment>.combine(
	activityReducer.optional().pullback(
		state: \.activity,
		action: /CategoryAction.activity,
		environment: { .init(mainQueue: $0.mainQueue, apiClient: $0.apiClient) }
	),
	.init { state, action, environment in
		switch action {
		case let .categorySelected(category):
			state.activity = ActivityState(category: category)
			return .none
		case let .activity(activityAction):
			if activityAction == .restartButtonTapped { state.activity = nil }
			return .none
		case .backButtonTapped:
			state.activity = nil
			return .none
		}
	}
)

struct CategoryView: View {
	let store: Store<CategoryState, CategoryAction>

	var body: some View {
		WithViewStore(store) { viewStore in
			ZStack {
				Color("BRCream")
					.ignoresSafeArea(.all, edges: .all)

				VStack {
					VStack {
						Text("First, pick a category")
							.font(.roboto.bold(24))
							.foregroundColor(.BRPrimaryText)

						Divider()
							.frame(height: 1)
							.background(Color.BRPrimaryText)
							.padding(.horizontal, 70)
							.padding(.bottom, 18)
					}
					.padding(.top, 60)
					.frame(alignment: .center)

					TabView {
						ForEach(Category.allCases, id: \.rawValue) { category in
							Button(action: { viewStore.send(.categorySelected(category)) }) {
								VStack {
									Image(category.imageName)
										.resizable()
										.scaledToFit()
										.shadow(color: .BRShadow, radius: 16, x: 0, y: 13)
										.frame(width: 218, height: 218)

									Text(category.rawValue)
										.font(.roboto.bold(24))
										.foregroundColor(.BRPrimaryText)
										.padding(.top, 36)
								}
							}
						}
					}
					.frame(width: UIScreen.main.bounds.width, height: 362)
					.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

					Spacer()
				}
			}
			.navigate(
				using: store.scope(state: \.activity, action: CategoryAction.activity),
				destination: ActivityView.init(store:),
				onDismiss: { ViewStore(store.stateless).send(.backButtonTapped) }
			)
		}
	}
}

struct CategoryView_Previews: PreviewProvider {
	static var previews: some View {
		CategoryView(
			store: .init(
				initialState: .init(),
				reducer: categoryReducer,
				environment: CategoryEnvironment(
					mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
					apiClient: ApiClient.noop
				)
			)
		)
	}
}
