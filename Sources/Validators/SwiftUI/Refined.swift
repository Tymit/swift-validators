import Foundation
import SwiftUI

public protocol FormPropertyWrapper {
  associatedtype Value
  var value: Value { get set }
}

@propertyWrapper
public struct Refined<Input, Error> {
  let validator: any Validator<Input, Error>
  public var wrappedValue: Validated<Input, Error>

  public init(
    wrappedValue value: Input,
    _ validator: some Validator<Input, Error>
  ) {
    self.validator = validator
    self.wrappedValue = validator(value).isValid ? .valid(value) : .idle(value)
  }

  public init<Validators: Validator>(
    wrappedValue value: Input,
    @ValidatorBuilder<Input, Error> _ build: () -> Validators
  )
  where Validators.Input == Input, Validators.Error == Error {
    self.validator = build()
    self.wrappedValue = validator(value).isValid ? .valid(value) : .idle(value)
  }

  public var projectedValue: Self {
    get { self }
    set { self = newValue }
  }
}

extension Refined: FormPropertyWrapper {
  public var value: Input {
    get { wrappedValue.value }
    set { wrappedValue = validator(newValue) }
  }
}

extension Refined: ValidatedProperty {
  public var isValid: Bool { wrappedValue.isValid }
}

extension Refined: Equatable where Input: Equatable, Error: Equatable {
  public static func == (lhs: Refined, rhs: Refined) -> Bool { lhs.wrappedValue == rhs.wrappedValue }
}
