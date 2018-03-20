//
//  CalculationError.swift
//  calc
//
//  Created by Jonathan Moallem on 16/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation

/*
 * An custom error enum that defines calculation type errors.
 */
enum CalculationError: Error {
    // Error for unknown operators
    case undefinedOperator(undefinedOperator: String)
    
    // Error for dividing by zero
    case dividedByZero
    
    // Error for out-of-bounds Int values
    case operandOutOfBounds(operand: String)
}

extension CalculationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .undefinedOperator(let undefinedOperator):
            return NSLocalizedString("CalculationError.undefinedOperator: Found unspecified operator \(undefinedOperator), please check input and try again.", comment: "Custom Error")
        case .dividedByZero:
            return NSLocalizedString("CalculationError.dividedByZero: Cannot divide operand by zero.", comment: "Custom Error")
        case .operandOutOfBounds(let operand):
            return NSLocalizedString("CalculationError.operandOutOfBounds: Operand [\(operand)] too small or large to handle.", comment: "Custom Error")
        }
    }
}
