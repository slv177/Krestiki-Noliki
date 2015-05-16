//
//  main.swift
//  Krestiki-Noliki
//
//  Created by Viacheslav Shambazov on 16/05/2015.
//  Copyright (c) 2015 Viacheslav Shambazov. All rights reserved.
//

//****DEFINITIONS****

import Foundation

//Cells states
enum state: String {
    case empty = "."
    case X = "X"
    case O = "O"
}

//board
var board: [[state]] = [
    [state.empty, state.empty, state.empty],
    [state.empty, state.empty, state.empty],
    [state.empty, state.empty, state.empty]
]

//Function for print board
func printBoard (Array: [[state]]) {
    for row in 0...2 {
        for col in 0...2 {
            print(board[row][col].rawValue)
        }
        println()
    }
}

//Function for text input
func input() -> String {
    var keyboard = NSFileHandle.fileHandleWithStandardInput()
    var inputData = keyboard.availableData
    var strData = NSString(data: inputData, encoding: NSUTF8StringEncoding)!
    
    return strData.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
}

//Function for users input
func gameCycle () {
    println("Your choise?")
    var userTurn = input()
    var turn = userTurn.toInt()!
    
    switch turn {
    case 1...3: board[0][turn - 1] = state.X
    case 4...6: board[1][turn - 4] = state.X
    case 7...9: board[2][turn - 7] = state.X
    default: break
    }
    printBoard(board)
}

//****GAME****

println("1, 2, 3")
println("4, 5, 6")
println("7, 8, 9")

gameCycle()
gameCycle()
gameCycle()


