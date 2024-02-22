/**
 
 1번 지표	라이언형(R), 튜브형(T)
 2번 지표	콘형(C), 프로도형(F)
 3번 지표	제이지형(J), 무지형(M)
 4번 지표	어피치형(A), 네오형(N)
 */

func solution(_ survey:[String], _ choices:[Int]) -> String {
	var result = ""
	let kakaoPersonal = "RTCFJMAN"
	var store = [String:Int]()
	for index in kakaoPersonal {
		store.updateValue(0, forKey: String(index))
	}
	
	for index in 0..<survey.count {
		var firstPersonal = String(survey[index].first!)
		var secondPersonal = String(survey[index].last!)
		var oldValue = 0
		
		if choices[index] > 4 {
			oldValue = store[secondPersonal]!
			store.updateValue(abs(4 - choices[index]) + oldValue, forKey: secondPersonal)
		} else if choices[index] < 4 {
			oldValue = store[firstPersonal]!
			store.updateValue(abs(4 - choices[index]) + oldValue, forKey: firstPersonal)
		}
	}
	
	
	let kakaoPersonalType = ["RT", "CF", "JM", "AN"]
	
	for type in kakaoPersonalType {
		var firstType = String(type.first!)
		var secondType = String(type.last!)
		
		print(store[firstType]!, store[secondType]!)
		
		if store[firstType]! >= store[secondType]! {
			result += firstType
		} else if store[firstType]! < store[secondType]! {
			result += secondType
		}
	}
	
	return result
}

var testSurvey = ["AN", "CF", "MJ", "RT", "NA"]
var testValue = [5, 3, 2, 7, 3]

print(solution(testSurvey, testValue))
