//
//  ActivityTests.swift
//  BoringTests
//
//  Created by Deniz Mersinlioğlu on 1.07.2022.
//

@testable import Boring
import Combine
import ComposableArchitecture
import SwiftyMocky
import XCTest

class ActivityTests: XCTestCase {

	let scheduler = DispatchQueue.test
	let category: Boring.Category = .social
	let apiClient = ApiClientProtocolMock()

	func testFetchActivitySuccess() {
		let activity = Activity(
			title: "Activity",
			participants: .random(in: 0 ... 1000),
			category: category
		)

		apiClient.given(
			.request(
				.any,
				as: .any,
				willReturn: Just(activity)
					.setFailureType(to: Failure.self)
					.eraseToAnyPublisher()
			)
		)

		let store = TestStore(
			initialState: ActivityState(category: category),
			reducer: activityReducer,
			environment: .init(mainQueue: scheduler.eraseToAnyScheduler(), apiClient: apiClient)
		)

		store.send(.fetchActivity)

		scheduler.advance()

		store.receive(.activityResponse(.success(activity))) {
			$0.activity = activity
		}
	}

	func testFetchActivityFailure() {
		let error = Failure()

		apiClient.given(
			.request(
				.any,
				as: .any,
				willReturn: Fail<Activity, Failure>(error: error)
					.eraseToAnyPublisher()
			)
		)

		let store = TestStore(
			initialState: ActivityState(category: category),
			reducer: activityReducer,
			environment: .init(mainQueue: scheduler.eraseToAnyScheduler(), apiClient: apiClient)
		)

		store.send(.fetchActivity)

		scheduler.advance()

		store.receive(.activityResponse(.failure(error)))
	}

	func testReloadButtonTap() {
		let activity = Activity(
			title: "Activity",
			participants: .random(in: 0 ... 1000),
			category: category
		)

		let secondActivity = Activity(
			title: "Second Activity",
			participants: .random(in: 0 ... 1000),
			category: category
		)

		apiClient.given(
			.request(
				.any,
				as: .any,
				willReturn: Just(secondActivity)
					.setFailureType(to: Failure.self)
					.eraseToAnyPublisher()
			)
		)

		let store = TestStore(
			initialState: ActivityState(category: category, activity: activity),
			reducer: activityReducer,
			environment: .init(mainQueue: scheduler.eraseToAnyScheduler(), apiClient: apiClient)
		)

		store.send(.reloadButtonTapped) {
			$0.activity = nil
		}

		scheduler.advance()

		store.receive(.fetchActivity)

		scheduler.advance()

		store.receive(.activityResponse(.success(secondActivity))) {
			$0.activity = secondActivity
		}
	}

}
