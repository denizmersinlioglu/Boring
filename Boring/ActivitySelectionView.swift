//
//  ActivitySelectionView.swift
//  Boring
//
//  Created by Deniz Mersinlioğlu on 1.07.2022.
//

import ComposableArchitecture
import SwiftUI

// MARK: - ActivitySelectionState

struct ActivitySelectionState: Equatable {
	var selectedActivity: Activity
}

// MARK: - ActivitySelectionAction

enum ActivitySelectionAction: Equatable {
	case restartButtonPressed
}

// MARK: - ActivitySelectionEnvironment

struct ActivitySelectionEnvironment {
	var uuid: () -> UUID
	var mainQueue: AnySchedulerOf<DispatchQueue>
}

// MARK: - ActivitySelectionView

struct ActivitySelectionView: View {
	var body: some View {
		Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
	}
}

// MARK: - ActivitySelectionView_Previews

struct ActivitySelectionView_Previews: PreviewProvider {
	static var previews: some View {
		ActivitySelectionView()
	}
}
