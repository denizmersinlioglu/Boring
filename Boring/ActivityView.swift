//
//  ActivityView.swift
//  Boring
//
//  Created by Deniz Mersinlioğlu on 1.07.2022.
//

import ComposableArchitecture
import SwiftUI

struct ActivityState: Equatable {
	var category: Category
	var activity: Activity?
}

enum ActivityAction: Equatable {
	case fetchActivity
	case activityResponse(Result<Activity, Failure>)
	case restartButtonTapped
	case reloadButtonTapped
}

struct ActivityEnvironment {
	var mainQueue: AnySchedulerOf<DispatchQueue>
	var apiClient: ApiClientProtocol
}

let activityReducer: Reducer<ActivityState, ActivityAction, ActivityEnvironment> = .init { state, action, environment in
	switch action {
	case .fetchActivity:
		enum ActivitySearchId {}
		return environment.apiClient.request(
			ApiClient.Target.getActivity(category: state.category),
			as: Activity.self
		)
		.receive(on: environment.mainQueue)
		.catchToEffect()
		.map { .activityResponse($0) }
		.cancellable(id: ActivitySearchId.self, cancelInFlight: true)

	case let .activityResponse(.success(activity)):
		state.activity = activity
		return .none

	case let .activityResponse(.failure(error)):
		return .none

	case .reloadButtonTapped:
		state.activity = nil
		return Effect(value: .fetchActivity)

	case .restartButtonTapped:
		return .none
	}
}

struct ActivityView: View {
	let store: Store<ActivityState, ActivityAction>

	var body: some View {
		WithViewStore(store) { viewStore in
			ZStack {
				Color("BRCream")
					.ignoresSafeArea(.all, edges: .all)

				VStack {
					Spacer()

					VStack {
						Text("You should...")
							.font(.roboto.medium(24))
							.foregroundColor(.BRPrimaryText)
							.padding(.bottom, 21)

						ActivityCard(activity: viewStore.activity, category: viewStore.category) {
							viewStore.send(.reloadButtonTapped)
						}
					}

					Spacer()

					Button(action: { viewStore.send(.restartButtonTapped) }) {
						Text("Restart")
							.font(.system(.title3, design: .rounded))
							.fontWeight(.bold)
							.foregroundColor(.BRGreen)
							.padding(.horizontal, 86)
					}
					.buttonStyle(.borderedProminent)
					.buttonBorderShape(.roundedRectangle(radius: 20))
					.tint(.white)
					.controlSize(.large)
					.shadow(color: .black.opacity(0.25), radius: 22, x: 0, y: 7)

					Spacer()
				}
				.padding(.horizontal, 30)
			}
			.navigationBarHidden(true)
			.onAppear { viewStore.send(.fetchActivity) }
		}
	}
}

struct ActivityView_Previews: PreviewProvider {
	static var previews: some View {
		ActivityView(store: .init(
			initialState: .init(category: .social),
			reducer: activityReducer,
			environment: ActivityEnvironment(
				mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
				apiClient: ApiClient.noop
			)
		))
	}
}
