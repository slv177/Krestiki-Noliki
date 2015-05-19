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
    }       //magic func for changing users
}

//Board
var board = [state] (count: 9, repeatedValue: state.empty)

//Text input
func input() -> String {
    var keyboard = NSFileHandle.fileHandleWithStandardInput()
    var inputData = keyboard.availableData
    var strData = NSString(data: inputData, encoding: NSUTF8StringEncoding)!
    
    return strData.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
}

//Users inputs their turns
func userInput(user: String) -> Int {
    func gettingInput(user: String) -> String{  //getting a value from keyboard
        println("\(user) choise (1-9)?")
        var userTurn : String = input()
        return userTurn
    }
    var userTurn = gettingInput(user)
    if count(userTurn) != 1 {  //checking the value
        println("Choose only one digit.")
        gettingInput(user)
    }
    var turn : Int = userTurn.toInt()!
    return turn
}

//Users changing the board
func setTurn(activeUser: String, turn: Int) -> () {
    board[turn-1] = state(rawValue: activeUser)!
}

//Printing the board
func printBoard (Array: [state]) {
    var counter = 0
    println("\u{250c}\u{2500}\u{2500}\u{252c}\u{2500}\u{2500}\u{252c}\u{2500}\u{2500}\u{2510}")
    for row in 0...2 {
       for col in 0...2 {
        print("\u{2502}\(counter+1)\(board[counter].rawValue)")
            counter++
        }
        println("\u{2502}")
        if row < 2 {println("\u{251c}\u{2500}\u{2500}\u{253c}\u{2500}\u{2500}\u{253c}\u{2500}\u{2500}\u{2524}")
        } else {
            println("\u{2514}\u{2500}\u{2500}\u{2534}\u{2500}\u{2500}\u{2534}\u{2500}\u{2500}\u{2518}")
        }
    }
    println()

}

//Is active user win?
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
outer: for step in 1...9 {
    turn =  userInput(activeUser.rawValue) //demande
    setTurn(activeUser.rawValue, turn) //set turn on the board
    printBoard(board)
    if isWin(activeUser.rawValue) {
        println("\(activeUser.rawValue) win!")
        break outer
    }
    activeUser.advance() //changing users
}
println("Game is ower")

