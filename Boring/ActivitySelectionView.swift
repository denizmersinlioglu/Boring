//
//  ActivitySelectionView.swift
//  Boring
//
//  Created by Deniz Mersinlioğlu on 1.07.2022.
//

import ComposableArchitecture
import SwiftUI

struct ActivitySelectionState: Equatable {
	var selectedActivity: Activity
}

enum ActivitySelectionAction: Equatable {
	case restartButtonPressed
}

struct ActivitySelectionEnvironment {
	var uuid: () -> UUID
	var mainQueue: AnySchedulerOf<DispatchQueue>
}

struct ActivitySelectionView: View {
	var body: some View {
		Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
	}
}

struct ActivitySelectionView_Previews: PreviewProvider {
	static var previews: some View {
		ActivitySelectionView()
	}
}
