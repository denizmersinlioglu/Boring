//
//  Category.swift
//  Boring
//
//  Created by Deniz Mersinlioğlu on 1.07.2022.
//

import Foundation

enum Category: String, Equatable, CaseIterable {
	case recreational = "Recreational"
	case social = "Social"
	case education = "Education"

	var imageName: String {
		switch self {
		case .recreational: return "recreational"
		case .education: return "education"
		case .social: return "social"
		}
	}
}
