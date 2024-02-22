import UIKit

/**
 1. 회전하는 로직 구현 필수
 2. 회전 이후 해당 괄호들이 올바르게 되어 있는지 체크
	2-1. 괄호 체크는 여는 괄호 이후 닫는 괄호가 무조건 있어야
	2-2. {[}]는 올바른 것인가? 아니다.
 3. 맞으면 +1
 */

/**
 1. 단순 Bool 값으로 확인
 2. 여는 괄호는 더하고 닫는 괄호는 빼는 방식
 3. 짝이 맞는 괄호를 찾아서 대칭
 */


let bracketType = ["{}", "[]", "()"]
let openBracket = "{[("
let closeBracket = "}])"

extension String {
	var isOpenBracket: Bool {
		return openBracket.contains(self)
	}
	
	var isCloseBracket: Bool {
		return closeBracket.contains(self)
	}
	
	func whatType() -> String {
		var typeString = ""
		bracketType.map { type in
			guard type.contains(self) else {
				return
			}
			typeString = type
		}
		return typeString
	}
}

func solution(_ s:String) -> Int {
	var returnValue = 0 // 올바른 괄호가 몇개인지
	var bracketStore: [String] = []
	var currentString: String = ""
	var isBreak: Bool = false
	var sLen = s.count

	for letters in s {
		bracketStore.append(String(letters))
	}
	
	for currentTurn in 0..<sLen {
		for index in 0..<sLen {
			var index = index
			if currentTurn + index >= sLen {
				index = currentTurn + index - sLen
			} else {
				index = currentTurn + index
			}
			let currentCharecter = bracketStore[index]
			
			if currentCharecter.isOpenBracket {
				currentString += currentCharecter
			} else {
				if currentString == "" {
					isBreak = true
					break
				}
				let lastBracket = currentString.last!
				
				if lastBracket == "{" && currentCharecter == "}" {
					currentString.removeLast()
				} else if lastBracket == "[" && currentCharecter == "]" {
					currentString.removeLast()
				} else if lastBracket == "(" && currentCharecter == ")" {
					currentString.removeLast()
				}
			}
		}
		if currentString == "" && isBreak == false {
			returnValue += 1
		}
		currentString = ""
		isBreak = false
	}
	return returnValue
}

var test = "[](){}"
var test1 = "}]()[{"
var test2 = "[)(]"
var test3 = "}}}"

solution(test)
//solution(test1)
//solution(test2)
//solution(test3)
