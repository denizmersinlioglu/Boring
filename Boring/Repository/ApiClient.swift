//
//  ApiClient.swift
//  Boring
//
//  Created by Deniz Mersinlioğlu on 1.07.2022.
//

import Combine
import Foundation
import SwiftyJSON

struct Failure: Error, Equatable {}

// sourcery: AutoMockable
protocol ApiTargetProtocol {
	var request: ApiClient.Request { get }
}

// sourcery: AutoMockable
protocol ApiClientProtocol {
	func request<T: JSONParsable>(_ target: ApiTargetProtocol, as: T.Type) -> AnyPublisher<T, Failure>
}

struct ApiClient: ApiClientProtocol {
	private let baseUrl: String
	private let logger = Logger()

	func request<T: JSONParsable>(_ target: ApiTargetProtocol, as: T.Type) -> AnyPublisher<T, Failure> {
		URLSession.shared.dataTaskPublisher(for: httpRequest(for: target))
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
			.tryMap {
				let json = try JSON(data: $0.data)
				if let parsed = T(json) { return parsed }
				else { throw Failure() }
			}
			.mapError { _ in Failure() }
			.eraseToAnyPublisher()
	}
}

extension ApiClient {

	private func httpRequest(for target: ApiTargetProtocol) -> URLRequest {
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
		return urlRequest
	}

	struct Request {
		var method: Method
		var endPoint: String
		var parameters: [String: Any]
		var encoding: ParameterEncoding?

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

extension ApiClient {
	static var live: Self = ApiClient(baseUrl: Config.API.baseUrl)
	static let noop: Self = ApiClient(baseUrl: "")
	//    static let mock: ApiClientProtocol =
}
