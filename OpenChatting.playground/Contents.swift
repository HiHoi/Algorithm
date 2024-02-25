import UIKit

enum Act: String {
	case Enter = "들어왔습니다."
	case Leave = "나갔습니다."
	case Change = ""
}

// 채팅의 순서대로 uid와 행동만 넣고
// 마지막에 userDB의 닉네임과 행동을 합치면?
/**
 func monitorChats:
	 대화 내역과 유저 정보를 파싱
	 while 대화 내역 배열의 수:
		 if 행동 키워드 확인:
			 그에 알맞는 대화 타입 체크
		 else
			 if 행동 키워드가 있으면
				 대화 저장소에 uid와 행동 체크
			 else
				 닉네임이 변경되었는지 확인해서 유저 DB에 uid와 nickname 저장

 func logAll: // 모든 로그의 문자열 출력
	 while 대화 저장소의 수:
		 대화 저장소의 uid로 닉네임과 행동 양식 맞추기
 */

struct OpenChatting {
	var allRecord: [String] = []
	var recordCount: Int = 0
	var chattingStore: Array<Array<String>> = []
	var chattingUserDB: [String:String] = [String:String]()
	
	mutating func monitoringChats() {
		var actType = ""
		var chattingIndex = 0
		var isCheckNickname = false
		for index in 0..<recordCount {
			if allRecord[index] == "Enter" {
				// 입장
				actType = "Enter"
			} else if allRecord[index] == "Change" {
				// 닉네임 수정
				actType = "Change"
			} else if allRecord[index] == "Leave" {
				// 퇴장
				actType = "Leave"
			} else {
				if actType != "" {
					// 키 추가
					var key = allRecord[index]
					var newChat = [key, actType]
					chattingIndex += 1
					chattingStore.append(newChat)
					if chattingUserDB[key] == nil {
						chattingUserDB.updateValue("", forKey: allRecord[index])
					}
					actType = ""
					
				} else {
					// 닉네임 체크
					var uid = allRecord[index - 1]
					var nickname = allRecord[index]
					
					chattingUserDB.updateValue(nickname, forKey: uid)
					actType = ""
				}
			}
		}
	}
	
	func logAll() -> [String] {
		var result: [String] = []
		chattingStore.map { element in
			var nickname = chattingUserDB[element[0]]
			var actType: String {
				if element[1] == "Enter" {
					return Act.Enter.rawValue
				} else if element[1] == "Leave" {
					return Act.Leave.rawValue
				} else {
					return ""
				}
			}
			if actType != "" {
				var new = "\(nickname!)님이 \(actType)"
				result.append(new)
			}
		}
		return result
	}
	
	init(_ records:[String]) {
		records.map { record in
			var splitRecord: [String] = record.components(separatedBy: " ")
			allRecord += splitRecord
		}
		recordCount = allRecord.count
	}
}

func solution(_ record:[String]) -> [String] {
	var openChatting = OpenChatting(record)
	openChatting.monitoringChats()
	
	return openChatting.logAll()
}

var test = ["Enter uid1234 Muzi", "Enter uid4567 Prodo","Leave uid1234","Enter uid1234 Prodo","Change uid4567 Ryan"]
var test1 = ["Enter uid1234 Muzi", "Enter uid4567 Prodo", "Enter uid2345 Apichi","Leave uid1234","Enter uid1234 Prodo", "Change uid2345 uid1234","Change uid4567 Ryan", "Leave uid2345"]
var test2 = ["Enter uid1234 Muzi", "Change uid1234 123412312", "Leave uid1234"]
var test3 = ["Enter uid1234 Muzi", "Leave uid1234", "Enter uid1234 hoslim", "Change uid1234 cleancode", "Leave uid1234"]
var test4 = ["Enter uid1234 Muzi", "Enter uid2345 Muzi", "Enter uid2345 Muzi", "Leave uid1234","Leave uid1234", "Leave uid1234"]
print(solution(test))
print(solution(test1))
print(solution(test2))
print(solution(test3))
