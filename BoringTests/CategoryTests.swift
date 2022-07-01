//
//  CategoryTests.swift
//  BoringTests
//
//  Created by Deniz Mersinlioğlu on 1.07.2022.
//

@testable import Boring
import ComposableArchitecture
import XCTest

class CategoryTests: XCTestCase {

	let scheduler = DispatchQueue.test

	func testCategorySelect() {
		let store = TestStore(
			initialState: CategoryState(),
			reducer: categoryReducer,
			environment: .init(mainQueue: scheduler.eraseToAnyScheduler(), apiClient: ApiClient.noop)
		)

		store.send(.categorySelected(.social)) {
			$0.activity = ActivityState(category: .social)
		}
	}

	func testBackButtonTap() {
		let store = TestStore(
			initialState: CategoryState(activity: ActivityState(category: .social)),
			reducer: categoryReducer,
			environment: .init(mainQueue: scheduler.eraseToAnyScheduler(), apiClient: ApiClient.noop)
		)

		store.send(.backButtonTapped) {
			$0.activity = nil
		}
	}

	func testRestartButtonTap() {
		let store = TestStore(
			initialState: CategoryState(activity: ActivityState(category: .social)),
			reducer: categoryReducer,
			environment: .init(mainQueue: scheduler.eraseToAnyScheduler(), apiClient: ApiClient.noop)
		)

		store.send(.activity(.restartButtonTapped)) {
			$0.activity = nil
		}
	}

}
