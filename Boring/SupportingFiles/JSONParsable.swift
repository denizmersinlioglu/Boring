//
//  JSONParsable.swift
//  Boring
//
//  Created by Deniz Mersinlioğlu on 1.07.2022.
//

import SwiftyJSON

protocol JSONParsable {
	init?(_ json: JSON)
}

extension Array: JSONParsable where Element: JSONParsable {
	init?(_ json: JSON) {
		self = json.arrayValue.compactMap(Element.init)
	}
}
