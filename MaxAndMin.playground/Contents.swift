import UIKit

func solution(_ s:String) -> Bool
{
	if s.count % 2 == 1 { return false }
	if s.first == ")" { return false }
	var isMatched: Int = 0
	
	for letter in s {
		if letter == "(" {
			isMatched += 1
		} else if letter == ")" {
			isMatched -= 1
		}
	}
	
	if isMatched == 0 { return true }
	else { return false }
}

solution(")()(")


