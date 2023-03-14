import Foundation

public protocol ValidatedForm {}

public extension ValidatedForm {
  var isValid: Bool {
    let mirror = Mirror(reflecting: self)
    return mirror.children.allSatisfy { ($0.value as? ValidatedProperty)?.isValid ?? true }
  }
}
