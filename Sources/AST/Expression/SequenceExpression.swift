/*
   Copyright 2017 Ryuichi Laboratories and the Yanagiba project contributors

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

import Source

/*
 SequenceExpression stores a list of binary operations in a flat structure.

 There always be at least two binary operations in this structure.
 When there is only one operation, we simply return it directly instead of
 building it into this sequence.

 The operations in SequenceExpression should be folded into a tree structure after
 semantic analysis. Therefore, SequenceExpression should only exist in parsing
 results and/or when the sematic analysis is disabled intentionally. In other
 words, if a SequenceExpression survives even after an active semantic analysis,
 there must be an error in the sema process, thus, error needs to be reported.
 */
public class SequenceExpression : ASTNode, Expression {
  public enum ElementKind {
    case expression(Expression)
    case assignmentOperator
    case binaryOperator(Operator)
    case ternaryConditionalOperator(Expression)
    case typeCheck(Type)
    case typeCast(Type)
    case typeConditionalCast(Type)
    case typeForcedCast(Type)
  }

  public typealias Element = (ElementKind, SourceRange)

  public let elements: [Element]

  public init(elements: [Element]) {
    self.elements = elements
  }

  // MARK: - ASTTextRepresentable

  override public var textDescription: String {
    return elements.map({ $0.0.textDescription }).joined(separator: " ")
  }
}

extension SequenceExpression.ElementKind : ASTTextRepresentable {
  public var textDescription: String {
    switch self {
    case .expression(let expr):
      return expr.textDescription
    case .assignmentOperator:
      return "="
    case .binaryOperator(let op):
      return op
    case .ternaryConditionalOperator(let expr):
      return "? \(expr.textDescription) :"
    case .typeCheck(let type):
      return "as \(type.textDescription)"
    case .typeCast(let type):
      return "as \(type.textDescription)"
    case .typeConditionalCast(let type):
      return "as \(type.textDescription)"
    case .typeForcedCast(let type):
      return "as \(type.textDescription)"
    }
  }
}
