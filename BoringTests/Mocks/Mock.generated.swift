// Generated using Sourcery 1.8.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// Generated with SwiftyMocky 4.1.0
// Required Sourcery: 1.6.0

@testable import Boring
import Combine
import Foundation
import SwiftyJSON
import SwiftyMocky
import XCTest

// MARK: - ApiClientProtocol

open class ApiClientProtocolMock: ApiClientProtocol, Mock {
	public init(
		sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst,
		stubbing stubbingPolicy: StubbingPolicy = .wrap,
		file: StaticString = #file,
		line: UInt = #line
	) {
		SwiftyMockyTestObserver.setup()
		self.sequencingPolicy = sequencingPolicy
		self.stubbingPolicy = stubbingPolicy
		self.file = file
		self.line = line
	}

	var matcher = Matcher.default
	var stubbingPolicy: StubbingPolicy = .wrap
	var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

	private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
	private var invocations: [MethodType] = []
	private var methodReturnValues: [Given] = []
	private var methodPerformValues: [Perform] = []
	private var file: StaticString?
	private var line: UInt?

	public typealias PropertyStub = Given
	public typealias MethodStub = Given
	public typealias SubscriptStub = Given

	/// Convenience method - call setupMock() to extend debug information when failure occurs
	public func setupMock(file: StaticString = #file, line: UInt = #line) {
		self.file = file
		self.line = line
	}

	/// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
	public func resetMock(_ scopes: MockScope...) {
		let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
		if scopes.contains(.invocation) { invocations = [] }
		if scopes.contains(.given) { methodReturnValues = [] }
		if scopes.contains(.perform) { methodPerformValues = [] }
	}

	open func request<T: JSONParsable>(_ target: ApiTargetProtocol, as: T.Type) -> AnyPublisher<T, Failure> {
		addInvocation(.m_request__targetas_as(Parameter<ApiTargetProtocol>.value(`target`), Parameter<T.Type>.value(`as`).wrapAsGeneric()))
		let perform =
			methodPerformValue(.m_request__targetas_as(Parameter<ApiTargetProtocol>.value(`target`),
			                                           Parameter<T.Type>.value(`as`).wrapAsGeneric())) as? (ApiTargetProtocol, T.Type) -> Void
		perform?(`target`, `as`)
		var __value: AnyPublisher<T, Failure>
		do {
			__value =
				try methodReturnValue(.m_request__targetas_as(Parameter<ApiTargetProtocol>.value(`target`), Parameter<T.Type>.value(`as`).wrapAsGeneric()))
				.casted()
		} catch {
			onFatalFailure("Stub return value not specified for request<T: JSONParsable>(_ target: ApiTargetProtocol, as: T.Type). Use given")
			Failure("Stub return value not specified for request<T: JSONParsable>(_ target: ApiTargetProtocol, as: T.Type). Use given")
		}
		return __value
	}

	fileprivate enum MethodType {
		case m_request__targetas_as(Parameter<ApiTargetProtocol>, Parameter<GenericAttribute>)

		static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
			switch (lhs, rhs) {
			case let (.m_request__targetas_as(lhsTarget, lhsAs), .m_request__targetas_as(rhsTarget, rhsAs)):
				var results: [Matcher.ParameterComparisonResult] = []
				results
					.append(Matcher
						.ParameterComparisonResult(Parameter.compare(lhs: lhsTarget, rhs: rhsTarget, with: matcher), lhsTarget, rhsTarget, "_ target"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsAs, rhs: rhsAs, with: matcher), lhsAs, rhsAs, "as"))
				return Matcher.ComparisonResult(results)
			}
		}

		func intValue() -> Int {
			switch self {
			case let .m_request__targetas_as(p0, p1): return p0.intValue + p1.intValue
			}
		}

		func assertionName() -> String {
			switch self {
			case .m_request__targetas_as: return ".request(_:as:)"
			}
		}
	}

	open class Given: StubbedMethod {
		fileprivate var method: MethodType

		private init(method: MethodType, products: [StubProduct]) {
			self.method = method
			super.init(products)
		}

		public static func request<T: JSONParsable>(_ target: Parameter<ApiTargetProtocol>, as: Parameter<T.Type>,
		                                            willReturn: AnyPublisher<T, Failure>...) -> MethodStub
		{
			Given(method: .m_request__targetas_as(`target`, `as`.wrapAsGeneric()), products: willReturn.map { StubProduct.return($0 as Any) })
		}

		public static func request<T: JSONParsable>(_ target: Parameter<ApiTargetProtocol>, as: Parameter<T.Type>,
		                                            willProduce: (Stubber<AnyPublisher<T, Failure>>) -> Void) -> MethodStub
		{
			let willReturn: [AnyPublisher<T, Failure>] = []
			let given = Given(method: .m_request__targetas_as(`target`, `as`.wrapAsGeneric()), products: willReturn.map { StubProduct.return($0 as Any) })
			let stubber = given.stub(for: AnyPublisher<T, Failure>.self)
			willProduce(stubber)
			return given
		}
	}

	public struct Verify {
		fileprivate var method: MethodType

		public static func request<T>(_ target: Parameter<ApiTargetProtocol>, as: Parameter<T.Type>) -> Verify
		where T: JSONParsable { Verify(method: .m_request__targetas_as(`target`, `as`.wrapAsGeneric())) }
	}

	public struct Perform {
		fileprivate var method: MethodType
		var performs: Any

		public static func request<T>(_ target: Parameter<ApiTargetProtocol>, as: Parameter<T.Type>,
		                              perform: @escaping (ApiTargetProtocol, T.Type) -> Void) -> Perform where T: JSONParsable
		{
			Perform(method: .m_request__targetas_as(`target`, `as`.wrapAsGeneric()), performs: perform)
		}
	}

	public func given(_ method: Given) {
		methodReturnValues.append(method)
	}

	public func perform(_ method: Perform) {
		methodPerformValues.append(method)
		methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
	}

	public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
		let fullMatches = matchingCalls(method, file: file, line: line)
		let success = count.matches(fullMatches)
		let assertionName = method.method.assertionName()
		let feedback: String = {
			guard !success else { return "" }
			return Utils.closestCallsMessage(
				for: self.invocations.map { invocation in
					matcher.set(file: file, line: line)
					defer { matcher.clearFileAndLine() }
					return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
				},
				name: assertionName
			)
		}()
		MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
	}

	private func addInvocation(_ call: MethodType) {
		queue.sync { invocations.append(call) }
	}

	private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
		matcher.set(file: file, line: line)
		defer { matcher.clearFileAndLine() }
		let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
		let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
		guard let product = matched?.getProduct(policy: stubbingPolicy) else { throw MockError.notStubed }
		return product
	}

	private func methodPerformValue(_ method: MethodType) -> Any? {
		matcher.set(file: file, line: line)
		defer { matcher.clearFileAndLine() }
		let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
		return matched?.performs
	}

	private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
		matcher.set(file: file ?? self.file, line: line ?? self.line)
		defer { matcher.clearFileAndLine() }
		return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
	}

	private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
		matchingCalls(method.method, file: file, line: line).count
	}

	private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
		do {
			return try methodReturnValue(method).casted()
		} catch {
			onFatalFailure(message)
			Failure(message)
		}
	}

	private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
		do {
			return try methodReturnValue(method).casted()
		} catch {
			return nil
		}
	}

	private func onFatalFailure(_ message: String) {
		guard let file = file, let line = line else { return } // Let if fail if cannot handle gratefully
		SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
	}
}

// MARK: - ApiTargetProtocol

open class ApiTargetProtocolMock: ApiTargetProtocol, Mock {
	public init(
		sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst,
		stubbing stubbingPolicy: StubbingPolicy = .wrap,
		file: StaticString = #file,
		line: UInt = #line
	) {
		SwiftyMockyTestObserver.setup()
		self.sequencingPolicy = sequencingPolicy
		self.stubbingPolicy = stubbingPolicy
		self.file = file
		self.line = line
	}

	var matcher = Matcher.default
	var stubbingPolicy: StubbingPolicy = .wrap
	var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

	private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
	private var invocations: [MethodType] = []
	private var methodReturnValues: [Given] = []
	private var methodPerformValues: [Perform] = []
	private var file: StaticString?
	private var line: UInt?

	public typealias PropertyStub = Given
	public typealias MethodStub = Given
	public typealias SubscriptStub = Given

	/// Convenience method - call setupMock() to extend debug information when failure occurs
	public func setupMock(file: StaticString = #file, line: UInt = #line) {
		self.file = file
		self.line = line
	}

	/// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
	public func resetMock(_ scopes: MockScope...) {
		let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
		if scopes.contains(.invocation) { invocations = [] }
		if scopes.contains(.given) { methodReturnValues = [] }
		if scopes.contains(.perform) { methodPerformValues = [] }
	}

	public var request: ApiClient
		.Request {
		invocations
			.append(.p_request_get); return __p_request ?? givenGetterValue(.p_request_get, "ApiTargetProtocolMock - stub value for request was not defined") }

	private var __p_request: (ApiClient.Request)?

	fileprivate enum MethodType {
		case p_request_get

		static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
			switch (lhs, rhs) { case (.p_request_get, .p_request_get): return Matcher.ComparisonResult.match
			}
		}

		func intValue() -> Int {
			switch self {
			case .p_request_get: return 0
			}
		}

		func assertionName() -> String {
			switch self {
			case .p_request_get: return "[get] .request"
			}
		}
	}

	open class Given: StubbedMethod {
		fileprivate var method: MethodType

		private init(method: MethodType, products: [StubProduct]) {
			self.method = method
			super.init(products)
		}

		public static func request(getter defaultValue: ApiClient.Request...) -> PropertyStub {
			Given(method: .p_request_get, products: defaultValue.map { StubProduct.return($0 as Any) })
		}

	}

	public struct Verify {
		fileprivate var method: MethodType

		public static var request: Verify { Verify(method: .p_request_get) }
	}

	public struct Perform {
		fileprivate var method: MethodType
		var performs: Any

	}

	public func given(_ method: Given) {
		methodReturnValues.append(method)
	}

	public func perform(_ method: Perform) {
		methodPerformValues.append(method)
		methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
	}

	public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
		let fullMatches = matchingCalls(method, file: file, line: line)
		let success = count.matches(fullMatches)
		let assertionName = method.method.assertionName()
		let feedback: String = {
			guard !success else { return "" }
			return Utils.closestCallsMessage(
				for: self.invocations.map { invocation in
					matcher.set(file: file, line: line)
					defer { matcher.clearFileAndLine() }
					return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
				},
				name: assertionName
			)
		}()
		MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
	}

	private func addInvocation(_ call: MethodType) {
		queue.sync { invocations.append(call) }
	}

	private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
		matcher.set(file: file, line: line)
		defer { matcher.clearFileAndLine() }
		let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
		let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
		guard let product = matched?.getProduct(policy: stubbingPolicy) else { throw MockError.notStubed }
		return product
	}

	private func methodPerformValue(_ method: MethodType) -> Any? {
		matcher.set(file: file, line: line)
		defer { matcher.clearFileAndLine() }
		let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
		return matched?.performs
	}

	private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
		matcher.set(file: file ?? self.file, line: line ?? self.line)
		defer { matcher.clearFileAndLine() }
		return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
	}

	private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
		matchingCalls(method.method, file: file, line: line).count
	}

	private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
		do {
			return try methodReturnValue(method).casted()
		} catch {
			onFatalFailure(message)
			Failure(message)
		}
	}

	private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
		do {
			return try methodReturnValue(method).casted()
		} catch {
			return nil
		}
	}

	private func onFatalFailure(_ message: String) {
		guard let file = file, let line = line else { return } // Let if fail if cannot handle gratefully
		SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
	}
}
