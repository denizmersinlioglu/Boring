//
//  Activity.swift
//  Boring
//
//  Created by Deniz Mersinlioğlu on 1.07.2022.
//

import Foundation

struct Activity: Equatable {
	var key: String
	var title: String
	var price: Float
	var participants: Int
	var category: Category
	var accessibility: Float
}
