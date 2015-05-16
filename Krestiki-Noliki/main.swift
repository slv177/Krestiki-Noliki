//
//  main.swift
//  Krestiki-Noliki
//
//  Created by Viacheslav Shambazov on 16/05/2015.
//  Copyright (c) 2015 Viacheslav Shambazov. All rights reserved.
//

//  ****DEFINITIONS****

import Foundation

//Cells states
enum state: String {
    case empty = "."
    case X = "X"
    case O = "O"
}

//Users
enum Users: String {
    case X = "X"
    case O = "O"
    static var cases: [Users] = [X, O] //magic func for changing users
    mutating func advance() {
        var i = find(Users.cases, self)!
        i = (i + 1) % 2
        self = Users.cases[i]
    }
}

//Board
var board = [state] (count: 9, repeatedValue: state.empty)

//text input
func input() -> String {
    var keyboard = NSFileHandle.fileHandleWithStandardInput()
    var inputData = keyboard.availableData
    var strData = NSString(data: inputData, encoding: NSUTF8StringEncoding)!
    
    return strData.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
}

//Users inputs their turns
func userInput(user: String) -> Int {
    println()
    println("\(user) choise (1-9)?")
    var userTurn : String = input()
    var turn : Int = userTurn.toInt()!
    return turn
}

//Users changing the board
func setTurn(activeUser: String, turn: Int) -> () {
    board[turn-1] = state(rawValue: activeUser)!
}

//printing the board
func printBoard (Array: [state]) {
    var counter = 0
    for row in 0...2 {
       for col in 0...2 {
            print("\t\(board[counter].rawValue)")
            counter++
        }
        println()
    }
}

//isWin
func isWin (activeUser: String) -> Bool {
    switch board {
    case _ where (board[0] == board[1]) && (board[1] == board[2]) && board[0].rawValue != ".": return true
    case _ where (board[3] == board[4]) && (board[4] == board[5]) && board[3].rawValue != ".": return true
    case _ where (board[6] == board[7]) && (board[7] == board[8]) && board[6].rawValue != ".": return true
    case _ where (board[0] == board[3]) && (board[3] == board[6]) && board[0].rawValue != ".": return true
    case _ where (board[1] == board[4]) && (board[4] == board[7]) && board[1].rawValue != ".": return true
    case _ where (board[2] == board[5]) && (board[5] == board[8]) && board[2].rawValue != ".": return true
    case _ where (board[0] == board[4]) && (board[4] == board[8]) && board[0].rawValue != ".": return true
    case _ where (board[2] == board[4]) && (board[4] == board[6]) && board[2].rawValue != ".": return true
    default: break
    }
    return false
}

//  ****GAME****
var turn = 0 //the cell on the board, which active user will mark
printBoard(board)
var activeUser = Users.X
outer: for step in 1...8 {
    turn =  userInput(activeUser.rawValue) //demande
    setTurn(activeUser.rawValue, turn) //set turn on the board
    printBoard(board)
    if isWin(activeUser.rawValue) {
        println("\(activeUser.rawValue) win!")
        break outer
    }
    activeUser.advance() //changing users
}

