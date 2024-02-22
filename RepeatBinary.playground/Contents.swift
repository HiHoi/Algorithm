import UIKit

extension String {
	var removeZero: String {
		let splitString = self.split(separator: "0")
		let newString: String = splitString.joined()
		
		return newString
	}
}

func solution(_ s:String) -> [Int] {
	if s == "1" {
		return [0,0]
	}
	var str: String = s
	var result: [Int] = []
	var countToChange: Int = 1
	var countToRemoveZero: Int = 0
	
	while str != "1" {
		var removeZero: String = str.removeZero
		// 0이 있는 경우
			// countZero를 한 뒤 현재 str의 길이 - countZero를 한 1로 찬 문자열을 생성
		if removeZero != str {
			var removeZeroLen = str.count - removeZero.count
			countToRemoveZero += removeZeroLen
			str = removeZero
		}
		// 0이 없는 경우
			// str의 길이를 재고 이를 이진법으로 변환
		else {
			var newStringLen = str.count
			str = String(newStringLen, radix: 2)
			countToChange += 1
		}
	}
	result = [countToChange, countToRemoveZero]
	return result
}

var test = "110010101001"
var test1 = "01110"
var test2 = "1111111"

print(solution(test))
print(solution(test1))
print(solution(test2))
