//
//  WelcomeView.swift
//  Boring
//
//  Created by Deniz Mersinlioğlu on 1.07.2022.
//

import ComposableArchitecture
import SwiftUI

struct WelcomeState: Equatable {
	var isSpammingOn = false
	var category: CategoryState?
}

enum WelcomeAction: Equatable {
	case letsGoPressed
	case spammingToggled
	case backButtonTapped
	case category(CategoryAction)
}

struct WelcomeEnvironment {
	var mainQueue: AnySchedulerOf<DispatchQueue>
	var apiClient: ApiClient
}

let welcomeReducer: Reducer<WelcomeState, WelcomeAction, WelcomeEnvironment> = .combine(
	categoryReducer.optional().pullback(
		state: \WelcomeState.category,
		action: /WelcomeAction.category,
		environment: { .init(mainQueue: $0.mainQueue, apiClient: $0.apiClient) }
	),
	.init { state, action, environment in
		switch action {
		case .letsGoPressed:
			state.category = CategoryState()
			return .none
		case .spammingToggled:
			state.isSpammingOn.toggle()
			return .none
		case .backButtonTapped:
			state.category = nil
			return .none
		case .category:
			return .none
		}
	}
)

struct WelcomeView: View {
	let store: Store<WelcomeState, WelcomeAction>

	var body: some View {
		WithViewStore(store) { viewStore in
			ZStack {
				Color("BRCream")
					.ignoresSafeArea(.all, edges: .all)

				VStack {
					Image("logo")
						.resizable()
						.scaledToFit()

					Text("Don’t think. We’ll just tell\n you what to do!")
						.multilineTextAlignment(.center)
						.font(.roboto.extraBold(20))
						.foregroundColor(.BRPrimaryText)
						.padding(.vertical, 40)

					Spacer()

					CheckBoxView(
						text: "Spam me stuff to do!",
						checked: viewStore.binding(
							get: \.isSpammingOn,
							send: .spammingToggled
						)
					)
					.padding(.bottom, 38)

					Button(action: { viewStore.send(.letsGoPressed) }) {
						Text("Let's Go!")
							.font(.system(.title3, design: .rounded))
							.fontWeight(.bold)
							.padding(.horizontal, 81)
					}
					.buttonStyle(.borderedProminent)
					.buttonBorderShape(.roundedRectangle(radius: 20))
					.tint(.BRGreen)
					.controlSize(.large)
					.shadow(color: .black.opacity(0.2), radius: 22, x: 0, y: 7)

					Spacer()
				}
				.padding(.all, 30)
			}.navigate(
				using: store.scope(state: \.category, action: WelcomeAction.category),
				destination: CategoryView.init(store:),
				onDismiss: { ViewStore(store.stateless).send(.backButtonTapped) }
			)
		}
	}
}

struct WelcomeView_Previews: PreviewProvider {
	static var previews: some View {
		WelcomeView(
			store: .init(
				initialState: WelcomeState(),
				reducer: welcomeReducer,
				environment: WelcomeEnvironment(
					mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
					apiClient: ApiClient.noop
				)
			)
		)
	}
}
