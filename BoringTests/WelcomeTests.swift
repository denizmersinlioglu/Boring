//
//  WelcomeTests.swift
//  BoringTests
//
//  Created by Deniz Mersinlioğlu on 1.07.2022.
//

@testable import Boring
import ComposableArchitecture
import XCTest

class WelcomeTests: XCTestCase {

	let scheduler = DispatchQueue.test

	func testSpammingEnabledToggle() {
		let store = TestStore(
			initialState: WelcomeState(),
			reducer: welcomeReducer,
			environment: .init(mainQueue: scheduler.eraseToAnyScheduler(), apiClient: ApiClient.noop)
		)

		store.send(.spammingToggled) {
			$0.isSpammingOn = true
		}
	}

	func testLetsGoButtonTap() {
		let store = TestStore(
			initialState: WelcomeState(),
			reducer: welcomeReducer,
			environment: .init(mainQueue: scheduler.eraseToAnyScheduler(), apiClient: ApiClient.noop)
		)

		store.send(.letsGoTapped) {
			$0.category = CategoryState()
		}
	}

	func testBackButtonTap() {
		let store = TestStore(
			initialState: WelcomeState(category: CategoryState()),
			reducer: welcomeReducer,
			environment: .init(mainQueue: scheduler.eraseToAnyScheduler(), apiClient: ApiClient.noop)
		)

		store.send(.backButtonTapped) {
			$0.category = nil
		}
	}

}
