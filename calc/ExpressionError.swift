//
//  ExpressionError.swift
//  calc
//
//  Created by Jonathan Moallem on 27/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation

/*
 * A custom error enum that defines expression type errors.
 */
enum ExpressionError: Error {
    // Error for empty expressions
    case emptyExpression
    
    // Error for incomplete expressions
    case incompleteExpression
}

extension ExpressionError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .emptyExpression:
            return NSLocalizedString("ExpressionError.emptyExpression: Cannot solve empty expressions, please check input and try again.", comment: "Custom Error")
        case .incompleteExpression:
            return NSLocalizedString("ExpressionError.incompleteExpression: Cannot solve incomplete expressions, please check input and try again.", comment: "Custom Error")
        }
    }
}

