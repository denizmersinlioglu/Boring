//
//  AppView.swift
//  Boring
//
//  Created by Deniz Mersinlioğlu on 1.07.2022.
//

import ComposableArchitecture
import SwiftUI

// MARK: - AppAction

enum AppAction: Equatable {
	case appDelegate(AppDelegateAction)
	case welcome(WelcomeAction)

	enum AppDelegateAction: Equatable {
		case didFinishLaunching
	}
}

// MARK: - AppState

enum AppState: Equatable {
	case welcome(WelcomeState)
}

// MARK: - AppEnvironment

struct AppEnvironment {
	var uuid: () -> UUID
	var mainQueue: AnySchedulerOf<DispatchQueue>
}

extension AppEnvironment {
	static var live: Self {
		.init(
			uuid: UUID.init,
			mainQueue: DispatchQueue.main.eraseToAnyScheduler()
		)
	}
}

let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
	welcomeReducer.pullback(
		state: /AppState.welcome,
		action: /AppAction.welcome,
		environment: { WelcomeEnvironment(uuid: $0.uuid, mainQueue: $0.mainQueue) }
	),
	.init { state, action, environment in
		switch action {
		case .appDelegate:
			// Do anything on app launch (UI configuration, token check etc.)
			return .none
		case .welcome:
			return .none
		}
	}
)

// MARK: - AppDelegate

final class AppDelegate: NSObject, UIApplicationDelegate {
	let store = Store(
		initialState: .welcome(.init()),
		reducer: appReducer,
		environment: .live
	)

	lazy var viewStore = ViewStore(
		store.scope(state: { _ in () }),
		removeDuplicates: ==
	)

	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
	) -> Bool {
		viewStore.send(.appDelegate(.didFinishLaunching))
		return true
	}
}

// MARK: - AppView

struct AppView: View {

	let store: Store<AppState, AppAction>

	var body: some View {
		SwitchStore(store) {
			CaseLet(state: /AppState.welcome, action: AppAction.welcome) { welcomeStore in
				WelcomeView(store: welcomeStore)
			}
		}
	}
}
