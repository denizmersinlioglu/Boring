//
//  Activity.swift
//  Boring
//
//  Created by Deniz Mersinlioğlu on 1.07.2022.
//

import SwiftyJSON

struct Activity: Equatable, JSONParsable {
	var title: String
	var participants: Int
	var category: Category

	init(title: String, participants: Int, category: Category) {
		self.title = title
		self.participants = participants
		self.category = category
	}

	init?(_ json: JSON) {
		if json["key"].string == nil { return nil }
		title = json["activity"].stringValue
		participants = json["participants"].intValue
		category = Category(rawValue: json["type"].stringValue) ?? .social
	}
}
