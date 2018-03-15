//
//  main.swift
//  calc
//
//  Created by Jesse Clark on 12/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation


var args = ProcessInfo.processInfo.arguments
args.removeFirst() // remove the name of the program

let postfixNodes: [Node] = ExpressionHelper.createPostfix(values: args)

ExpressionHelper.printExpression(nodeArray: postfixNodes)
