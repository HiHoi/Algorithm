import UIKit

struct QuadSqueeze {
	var arr: [[Int]] = []
	var result: [Int] = [0, 0]
	
	func isSame(_ startX: Int, _ startY: Int, width: Int) -> Int {
		let initNumber = arr[startX][startY]
		for x in startX..<startX + width {
			for y in startY..<startY + width {
				if arr[x][y] != initNumber {
					return -1
				}
			}
		}
		return initNumber
	}
	
	mutating func dfs(_ width: Int, _ startXY: [Int]) {
		var startX = startXY[0]
		var startY = startXY[1]
		
		// 0. 탈출 조건
		if width == 1 {
			result[arr[startX][startY]] += 1
			return
		}
		// 1. 4등분
		var checkSame = isSame(startX, startY, width: width)
		
		if checkSame != -1 {
			result[checkSame] += 1
			return
		} else {
			var half = width / 2
			dfs(half, [startX, startY])
			dfs(half, [startX + half, startY])
			dfs(half, [startX, startY + half])
			dfs(half, [startX + half, startY + half])
		}
	}
	
	mutating func quad() {
		var width = arr[0].count
		var startXY = [0, 0]
		
		dfs(width, startXY)
	}
	
	init(arr: [[Int]]) {
		self.arr = arr
	}
}


func solution(_ arr:[[Int]]) -> [Int] {
	var quadSqueeze = QuadSqueeze(arr: arr)
	quadSqueeze.quad()
	return quadSqueeze.result
}

var test = [[1,1,0,0],[1,0,0,0],[1,0,0,1],[1,1,1,1]]
var test1 = [[1,1,1,1,1,1,1,1],[0,1,1,1,1,1,1,1],[0,0,0,0,1,1,1,1],[0,1,0,0,1,1,1,1],[0,0,0,0,0,0,1,1],[0,0,0,0,0,0,0,1],[0,0,0,0,1,0,0,1],[0,0,0,0,1,1,1,1]]
print(solution(test))
print(solution(test1))
