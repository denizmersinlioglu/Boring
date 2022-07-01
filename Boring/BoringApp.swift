//
//  BoringApp.swift
//  Boring
//
//  Created by Deniz Mersinlioğlu on 1.07.2022.
//

import ComposableArchitecture
import SwiftUI

@main
struct BoringApp: App {
	var body: some Scene {
		WindowGroup {
			AppView(
				store: .init(
					initialState: .welcome(.init()),
					reducer: appReducer,
					environment: .init(
						mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
						apiClient: ApiClient.live
					)
				)
			)
		}
	}
}
