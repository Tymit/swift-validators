import XCTest
import Foundation
import Validators

final class ValidateTests: XCTestCase {
  func test_validateInvalid_validate_returnsError() {
    let validator = Validate<String, StringValidationError> { input in
      return .invalid(input, .empty)
    }
    
    let validated = validator.validate("")
    
    XCTAssertEqual(validated, .invalid("", .empty))
  }
  
  func test_validateValid_validate_returnsValid() {
    let validator = Validate<String, StringValidationError> { input in
      return .valid(input)
    }
    
    let validated = validator.validate("")
    
    XCTAssertEqual(validated, .valid(""))
  }
}

