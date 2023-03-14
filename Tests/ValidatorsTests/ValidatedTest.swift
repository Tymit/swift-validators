import XCTest
import Foundation
import Validators

final class ValidatedTest: XCTestCase {
  // MARK: - invalid
  func test_invalid_error_returnsError() {
    XCTAssertEqual(Validated<String, StringValidationError>.invalid("", .empty).error, .empty)
  }
  
  func test_invalid_isValid_returnsFalse() {
    XCTAssertFalse(Validated<String, StringValidationError>.invalid("", .empty).isValid)
  }
  
  func test_invalid_value_returnsValue() {
    XCTAssertEqual(Validated<String, StringValidationError>.invalid("", .empty).value, "")
  }
  
  // MARK: - idle
  func test_idle_error_returnsNil() {
    XCTAssertNil(Validated<String, StringValidationError>.idle("").error)
  }
  
  func test_idle_isValid_returnsFalse() {
    XCTAssertFalse(Validated<String, StringValidationError>.idle("").isValid)
  }
  
  func test_idle_value_returnsValue() {
    XCTAssertEqual(Validated<String, StringValidationError>.invalid("", .empty).value, "")
  }
  
  // MARK: - valid
  func test_valid_error_returnsNil() {
    XCTAssertNil(Validated<String, StringValidationError>.valid("").error)
  }
  
  func test_valid_isValid_returnsTrue() {
    XCTAssertTrue(Validated<String, StringValidationError>.valid("").isValid)
  }
  
  func test_valid_value_returnsValue() {
    XCTAssertEqual(Validated<String, StringValidationError>.valid("").value, "")
  }
}

