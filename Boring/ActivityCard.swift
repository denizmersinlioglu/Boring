//
//  ActivityCard.swift
//  Boring
//
//  Created by Deniz Mersinlioğlu on 1.07.2022.
//

import SwiftUI

struct ActivityCard: View {

	var activity: Activity?
	var category: Category
	var onReloadPress: (() -> Void)?

	var body: some View {
		VStack {
			ZStack {
				LinearGradient(
					gradient: .init(colors: [.BRGreen, .BRLightGreen]),
					startPoint: .topLeading,
					endPoint: .bottomTrailing
				)

				VStack {
					VStack {
						Image("game_pad")
						Text(category.rawValue + " Activity")
							.foregroundColor(.BRSecondaryText)
							.font(.roboto.semibold(16))

						Spacer()

						if let activity = activity {
							Text(activity.title.uppercased())
								.foregroundColor(.white)
								.font(.roboto.bold(36))
								.multilineTextAlignment(.center)

							Spacer()

							VStack(spacing: 7) {
								Text("People Nedeed")
									.foregroundColor(.white)
									.font(.roboto.bold(15))

								Text("\(activity.participants)")
									.foregroundColor(.white)
									.font(.roboto.bold(36))
							}
							.padding(.bottom, 36)
						} else {
							ProgressView()
								.controlSize(.large)

							Spacer()
						}
					}
				}
				.padding(30)
			}
			.frame(height: 431)
			.clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
			.shadow(color: .black.opacity(0.25), radius: 28, x: 0, y: 11)

			Button(action: { onReloadPress?() }) {
				Image("reload")
					.padding(16)
					.background(.white)
					.clipShape(RoundedRectangle(cornerRadius: 36, style: .continuous))
					.overlay(
						RoundedRectangle(cornerRadius: 36)
							.stroke(Color.BRGreen, lineWidth: 4)
					)
			}
			.padding(.top, -46)
		}
	}
}

struct ActivityCard_Previews: PreviewProvider {
	static var previews: some View {
		ActivityCard(
			activity: Activity(
				title: "GO FOR A RUN",
				participants: 12,
				category: .recreational
			),
			category: .social,
			onReloadPress: { print("on restart press") }
		)
	}
}
