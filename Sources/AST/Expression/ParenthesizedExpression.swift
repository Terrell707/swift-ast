/*
   Copyright 2016-2017 Ryuichi Laboratories and the Yanagiba project contributors

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

public class ParenthesizedExpression : ASTNode, PrimaryExpression {
  public private(set) var expression: Expression

  public init(expression: Expression) {
    self.expression = expression
  }

  // MARK: - Node Mutations

  public func reset(with newExpression: Expression) {
    expression = newExpression
  }

  // MARK: - ASTTextRepresentable

  override public var textDescription: String {
    return "(\(expression.textDescription))"
  }
}
