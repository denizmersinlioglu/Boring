//
//  Logger.swift
//  Boring
//
//  Created by Deniz Mersinlioğlu on 1.07.2022.
//

import Foundation

struct Logger {

	func log(_ info: String) {
		print(info)
	}

	func log(_ title: String, _ info: [String]) {
		log("\n----- \(title) -----\n\(info.joined(separator: "\n"))\n")
	}

	func log(_ title: String, _ info: String) {
		log("\n----- \(title) -----\n\([info])\n")
	}

}
