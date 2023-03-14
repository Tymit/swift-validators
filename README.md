# Validators

`Validate form values made easy`


Validators is a library that allow you to build complex validators based on small ones composing them.


# How to build a validator?

Validators works based on `Validated` object inspired [here]() with two little differences. When used with SwiftUI TextFields, Validated has to keep the input value on all states (idle, valid and invalid). 
The `idle` state is to represent a value that hasn't been validated yet, so it is not valid yet but also isn't invalid.

```
enum StringValidationError {
    case notEmpty
}

struct NotEmpty: Validator<String, StringValidationError> {
    func validate(input: String) -> Validated<String, StringValidationError> {
        input.isEmpty
        ? .valid(input)
        : .invalid(input, .notEmpty)
    }
}
```

# How compose them?

Validators are [combinators], this means we can compose them with easeness. As [swift-composable-architecture] Reducers, Validators has a body
where you can place a bunch of validators to compose them.

```
enum StringValidationError {
    case notEmpty
    case notContainsAt
}

struct NotEmpty: Validator {
    func validate(_ input: String) -> Validated<String, StringValidationError> {
        input.isEmpty
        ? .valid(input)
        : .invalid(input, .notEmpty)
    }
}

struct ContainsAt: Validator {
    func validate(_ input: String) -> Validated<String, StringValidationError> {
        input.contains("at")
        ? .valid(input)
        : .invalid(input, .notContainsAt)
    }
}

struct Email: Validator {
    typealias Input = String
    typealias Error = StringValidationError

    var body: some Validator<String, StringValidationError> {
        NotEmpty()
        ContainsAt()
    }
}
```

# One step further

Validating data models are also easy based on composition.

```
struct User {
  let name: String
  let email: String
}

enum UserValidationError {
  case invalidName(StringValidationError)
  case invalidEmail(StringValidationError)
}

struct UserValidator: Validator {
  typealias Input = User
  typealias Error = UserValidationError

  var body: some Validator<User, UserValidationError> {
    Scope(
      validating: \.name,
      error: UserValidationError.invalidName
    ) {
      NotEmpty()
    }
    Scope(
      validating: \.email,
      error: UserValidationError.invalidEmail
    ) {
      Email()
    }
  }
}
```