//
//  WelcomeView.swift
//  Boring
//
//  Created by Deniz Mersinlioğlu on 1.07.2022.
//

import ComposableArchitecture
import SwiftUI

// MARK: - WelcomeState

struct WelcomeState: Equatable {
	var isSpammingOn = false
	var categorySelection: CategorySelectionState?
}

// MARK: - WelcomeAction

enum WelcomeAction: Equatable {
	case letsGoPressed
	case spammingToggled
}

// MARK: - WelcomeEnvironment

struct WelcomeEnvironment {
	var uuid: () -> UUID
	var mainQueue: AnySchedulerOf<DispatchQueue>
}

let welcomeReducer = Reducer<WelcomeState, WelcomeAction, WelcomeEnvironment> { state, action, environment in
	switch action {
	case .letsGoPressed:
		state.categorySelection = CategorySelectionState()
		return .none
	case .spammingToggled:
		state.isSpammingOn.toggle()
		return .none
	}
}

// MARK: - WelcomeView

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
						.padding(.top, 70)

					Text("Don’t think. We’ll just tell\n you what to do!")
						.multilineTextAlignment(.center)
						.font(.custom("Roboto-Black", size: 20))
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

					Button(action: {}) {
						Text("Let's Go!")
							.font(.system(.title3, design: .rounded))
							.fontWeight(.bold)
							.padding(.horizontal, 81)
					}
					.buttonStyle(.borderedProminent)
					.buttonBorderShape(.roundedRectangle(radius: 20))
					.tint(Color("BRGreen"))
					.controlSize(.large)
					.shadow(color: .black.opacity(0.2), radius: 22, x: 0, y: 7)

					Spacer()
				}
				.padding(.all, 30)

			}
		}
	}
}

// MARK: - WelcomeView_Previews

struct WelcomeView_Previews: PreviewProvider {
	static var previews: some View {
		WelcomeView(
			store: .init(
				initialState: WelcomeState(),
				reducer: welcomeReducer,
				environment: WelcomeEnvironment(
					uuid: UUID.init,
					mainQueue: DispatchQueue.main.eraseToAnyScheduler()
				)
			)
		)
	}
}
