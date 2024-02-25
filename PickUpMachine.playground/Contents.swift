import UIKit

struct PickUpMachine {
	var boardByY:[[Int]] = []
	var boardCount = 0
	var moves: [Int] = []
	var popCount = 0
	var moveCount = 0
	var basket: [Int] = []
	
	mutating func letsPickUp() {
		var currentLine: [Int] = []
		var currentMove = 0
//		print(moves, moveCount)
		for index in 0..<moveCount {
			currentMove = moves[index] - 1
			currentLine = boardByY[currentMove]
//			print(currentMove, currentLine)
			for idx in 0..<boardCount {
				if currentLine[idx] != 0 {
					if currentLine[idx] == basket.last {
//						print("Match!", currentLine[index], basket.last)
						basket.removeLast()
						boardByY[currentMove][idx] = 0
						popCount += 2
						break
					} else {
						basket.append(currentLine[idx])
						boardByY[currentMove][idx] = 0
						break
					}
				}
			}
//			print(currentMove, boardByY, basket)
		}
	}
	
	init(_ board: [[Int]], _ moves: [Int]) {
		self.boardCount = board.count
		var tempBoard: [Int] = []
		for x in 0..<boardCount {
			tempBoard = []
			for y in 0..<boardCount {
				tempBoard.append(board[y][x])
			}
			boardByY.append(tempBoard)
		}
		self.moves = moves
		self.moveCount = moves.count
	}
}

func solution(_ board:[[Int]], _ moves:[Int]) -> Int {
	var pickUpMachine = PickUpMachine(board, moves)
	
	pickUpMachine.letsPickUp()
	
	return pickUpMachine.popCount
}

var testboard = [[0,0,0,0,0],[0,0,1,0,3],[0,2,5,0,1],[4,2,4,4,2],[3,5,1,3,1]]
var testmove = [1,5,3,5,1,2,1,4]
solution(testboard, testmove)
