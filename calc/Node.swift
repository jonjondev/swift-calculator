//
//  Node.swift
//  calc
//
//  Created by Jonathan Moallem on 14/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation

/*
 * A struct to represent a given Node.
 */
struct Node {
    
    // Struct fields
    let value: String
    
    
    /*
     * A constructor that initialises the value of the Node.
     */
    init(value: String) {
        self.value = value
    }
    
    
    /*
     * A public function that returns the value of the Node as an Int.
     */
    func intValue() -> Int {
        return Int(value)!
    }
    
    
    /*
     * A public method that returns whether the Node's value can
     * be converted to (and therefor must be) an operand as a Bool.
     *
     * Throws an error if the value is a number but it is too
     * big or small to parse into an Int.
     */
    func isOperandNode() throws -> Bool  {
        if isNumber() && Int(value) == nil {
            throw CalculationError.operandOutOfBounds(operand: self.value)
        }
        return Int(value) != nil
    }
    
    
    /*
     * A helper function to determine if the value of the Node looks
     * like a number (either negative or positive).
     */
    private func isNumber() -> Bool {
        let numericalCharacters: CharacterSet = CharacterSet.decimalDigits
        let valueAllNumbers: Bool = CharacterSet(charactersIn: value).isSubset(of: numericalCharacters)
        let valueIsNegative: Bool = value.hasPrefix("-")
        
        if valueAllNumbers {
            return true
        }
        else if valueIsNegative && value.count > 1 {
            var firstValueSliced: String = value
            firstValueSliced.remove(at: firstValueSliced.startIndex)
            return CharacterSet(charactersIn: firstValueSliced).isSubset(of: numericalCharacters)
        }
        return false
    }
}
