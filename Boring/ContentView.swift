//
//  ContentView.swift
//  Boring
//
//  Created by Deniz Mersinlioğlu on 1.07.2022.
//

import SwiftUI

// MARK: - AppState

struct AppState: Equatable {
	var welcome: WelcomeState
}

// MARK: - AppAction

enum AppAction: Equatable {}

// MARK: - AppEnvironment

struct AppEnvironment {}

// MARK: - ContentView

struct ContentView: View {
	var body: some View {
		Text("Hello, world!")
			.padding()
	}
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
