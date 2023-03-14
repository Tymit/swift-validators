import XCTest
import Foundation
import Validators

final class CombineValidatorTests: XCTestCase {
  func test_combineTwoValidatorsFailingFirst_validate_returnsFirstError() {
    let validator = CombineValidator<String, StringValidationError> {
      Validate { input in
        return .invalid(input, .empty)
      }
      Validate { input in
        return .valid(input)
      }
    }

    let validated = validator.validate("")

    XCTAssertEqual(validated, .invalid("", .empty))
  }

  func test_combineTwoValidatorsFailingSecond_validate_returnsSecondError() {
    let validator = CombineValidator<String, StringValidationError> {
      Validate { input in
        return .valid(input)
      }
      Validate { input in
        return .invalid(input, .empty)
      }
    }

    let validated = validator.validate("")

    XCTAssertEqual(validated, .invalid("", .empty))
  }

  func test_combineTwoValidatorsValid_validate_returnsValid() {
    let validator = CombineValidator<String, StringValidationError> {
      Validate { input in
        return .valid(input)
      }
      Validate { input in
        return .valid(input)
      }
    }

    let validated = validator.validate("")

    XCTAssertEqual(validated, .valid(""))
  }
}

