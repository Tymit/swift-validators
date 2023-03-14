import XCTest
import Foundation
import Validators

final class ScopeTests: XCTestCase {
  struct User: Equatable {
    let name: String = ""
  }

  enum UserValidationError: Equatable {
    case invalidName(StringValidationError)
  }

  func test_validateValid_validate_returnsValid() {
    let validator = Scope<User, UserValidationError>(validating: \.name, error: UserValidationError.invalidName) {
      Validate<String, StringValidationError> { name in
        return .valid(name)
      }
    }
    let validated = validator.validate(User())

    XCTAssertEqual(validated, .valid(User()))
  }

  func test_validateInvalid_validate_returnsInvalid() {
    let validator = Scope<User, UserValidationError>(validating: \.name, error: UserValidationError.invalidName) {
      Validate<String, StringValidationError> { name in
        return .invalid(name, .empty)
      }
    }
    let validated = validator.validate(User())

    XCTAssertEqual(validated, .invalid(User(), .invalidName(.empty)))
  }
}

