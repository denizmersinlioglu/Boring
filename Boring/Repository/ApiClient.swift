//
//  ApiClient.swift
//  Boring
//
//  Created by Deniz Mersinlioğlu on 1.07.2022.
//

import Combine
import ComposableArchitecture
import Foundation
import SwiftyJSON

struct Failure: Error, Equatable {}

struct ApiClient {
	private let baseUrl: String
	private let logger = Logger()

	init(baseUrl: String) {
		self.baseUrl = baseUrl
	}

	func request<T: JSONParsable>(_ target: ApiTargetProtocol, as: T.Type) -> Effect<T, Failure> {
		print(target)
		let request = target.request
		var urlComponents = URLComponents(string: baseUrl + target.request.endPoint)!

		if request.encoding == .query {
			let parameters = request.parameters
			urlComponents.queryItems = parameters.map { URLQueryItem(name: $0, value: "\($1)") }
		}

		var urlRequest = URLRequest(url: urlComponents.url!)
		urlRequest.httpMethod = request.method.rawValue

		if request.encoding == .body {
			urlRequest.httpBody = try? JSON(target.request.parameters).rawData()
		}
		urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")

		return URLSession.shared.dataTaskPublisher(for: urlRequest)
			.handleEvents(
				receiveSubscription: { _ in
					logger.log(
						"Api Request",
						[
							"URL: \(baseUrl + target.request.endPoint)",
							"Method: \(target.request.method.rawValue)",
							"Target: \(target)",
							"Parameters: \(target.request.parameters)"
						]
					)
				},
				receiveOutput: {
					logger.log(
						"Api Response",
						[
							"URL: \(baseUrl + target.request.endPoint)",
							"Method: \(target.request.method.rawValue)",
							"Status: \(($0.response as? HTTPURLResponse)?.statusCode ?? 0)",
							"Target: \(target)",
							"Parameters: \(target.request.parameters)",
							"Data: \(String(describing: try? JSON(data: $0.data))))"
						]
					)
				}
			)
			.tryMap { response in
				let json = try JSON(data: response.data)
				if let parsed = T(json) { return parsed }
				else { throw Failure() }
			}
			.mapError { _ in Failure() }
			.eraseToEffect()
	}
}

extension ApiClient {

	struct Request {
		var method: Method
		var endPoint: String
		var parameters: [String: Any]
		var encoding: ParameterEncoding

		init(
			method: Method,
			endPoint: String,
			parameters: [String: Any] = [:],
			encoding: ParameterEncoding? = nil
		) {
			self.method = method
			self.endPoint = endPoint
			self.parameters = parameters

			switch method {
			case .get, .delete: self.encoding = encoding ?? .query
			case .put, .post: self.encoding = encoding ?? .body
			}
		}

		enum Method: String {
			case post = "POST"
			case get = "GET"
			case put = "PUT"
			case delete = "DELETE"
		}

		enum ParameterEncoding {
			case body
			case query
		}
	}

}

// MARK: - ApiTargetProtocol

protocol ApiTargetProtocol {
	var request: ApiClient.Request { get }
	var retryCount: Int { get }
}

extension ApiTargetProtocol {
	var retryCount: Int { 2 }
}

// MARK: - ApiClient Instances

extension ApiClient {

	static var live: Self = ApiClient(baseUrl: Config.API.baseUrl)
	static let noop: Self = ApiClient(baseUrl: "")
}

// MARK: - Targets

extension ApiClient {

	enum Target: ApiTargetProtocol {
		case getActivity(category: Category)

		var request: ApiClient.Request {
			switch self {
			case let .getActivity(category):
				return .init(
					method: .get,
					endPoint: "/activity",
					parameters: ["type": category.rawValue.lowercased()]
				)
			}
		}
	}

}
