import Foundation

public protocol Validator<Input, Error> {
  associatedtype Input
  associatedtype Error

  associatedtype _Body

  typealias Body = _Body

  func validate(_ input: Input) -> Validated<Input, Error>

  @ValidatorBuilder<Input, Error>
  var body: Body { get }
}

public extension Validator {
  func callAsFunction(_ input: Input) -> Validated<Input, Error> {
    validate(input)
  }
}

extension Validator {
  public func validate(_ input: Validated<Input, Error>) -> Validated<Input, Error> {
    switch input {
    case .valid(let input):
      return validate(input)
    case .idle(let input):
      return validate(input)
    case .invalid(let input, let error):
      return .invalid(input, error)
    }
  }
}

public extension Validator where Body == Never {
  var body: Body {
    fatalError(
      """
        \(Self.self) has no body.

        Do not call a validator body property directly, as it may not exists.
        Call Validator.validate(input:) instead
      """
    )
  }
}

public extension Validator where Body: Validator, Body.Input == Input, Body.Error == Error {
  func validate(
    _ input: Input
  ) -> Validated<Input, Error> {
    self.body.validate(input)
  }
}
