//
//  CalculationError.swift
//  calc
//
//  Created by Jonathan Moallem on 16/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation

enum CalculationError: Error {
    case undefinedOperator(undefinedOperator: String)
    case dividedByZero
    case valueOutOfBounds
}
