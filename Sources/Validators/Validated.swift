import Foundation

public enum Validated<Value, Error> {
  case idle(Value)
  case valid(Value)
  case invalid(Value, Error)

  public var value: Value {
    switch self {
    case .idle(let value): return value
    case .invalid(let value, _): return value
    case .valid(let value): return value
    }
  }

  public var isValid: Bool {
    switch self {
    case .idle, .invalid: return false
    case .valid: return true
    }
  }

  public var error: Error? {
    switch self {
    case .idle, .valid: return nil
    case .invalid(_, let validationError): return validationError
    }
  }
}

extension Validated: Equatable where Value: Equatable, Error: Equatable {
  public static func == (lhs: Validated, rhs: Validated) -> Bool {
    switch (lhs, rhs) {
    case (.idle(let lValue), .idle(let rValue)): return lValue == rValue
    case (.valid(let lValue), .valid(let rValue)): return lValue == rValue
    case (.invalid(let lValue, let lError), .invalid(let rValue, let rError)): return lValue == rValue && lError == rError
    default: return false
    }
  }
}

public extension Validated {
  func replacing(error: Error) -> Validated {
    switch self {
    case .idle, .valid: return self
    case .invalid(let value, _): return .invalid(value, error)
    }
  }
}

