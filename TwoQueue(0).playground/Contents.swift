import UIKit

struct Queue<T: Numeric & Comparable> {
	public var _queue: [T] = []
	
	public var count: Int {
		return _queue.count
	}
	
	public var isEmpty: Bool {
		return _queue.isEmpty
	}
	
	public mutating func enquene(_ element: T) {
		_queue.append(element)
	}
	
	public mutating func dequeue() -> T? {
		return isEmpty ? nil : _queue.removeFirst()
	}
	
	public func sum() -> T {
		return _queue.reduce(0) { x, y in
			x + y
		}
	}
}

extension Queue {
	init (queue: [T]) {
		self._queue = queue
	}
	
	public var firstElement: T {
		return _queue[0]
	}
	
	public var max: T {
		if let max = _queue.max() {
			return max
		}
		return 0
	}
	
	public func debug() {
		print(_queue)
	}
}

class TwoQueue {
	private var _queue1 = Queue<Int>()
	private var _queue2 = Queue<Int>()
	private var _totalTwoQueue: Int {
		return _totalQueue1 + _totalQueue2
	}
	private var targetSum: Int {
		return _totalTwoQueue / 2
	}
	private var _totalQueue1: Int = 0
	private var _totalQueue2: Int = 0
	private var _queue1Max: Int = 0
	private var _queue2Max: Int = 0
	private var _queue1Count: Int = 0
	private var _queue2Count: Int = 0
	
	public var totalMoveCount: Int = 0
	
	public var isEven: Bool {
		return _totalTwoQueue % 2 == 0 ? true : false
	}
	public var isFinish: Bool {
		return _totalQueue1 == _totalQueue2
	}
	public var isLargeThan1: Bool {
		return _totalQueue1 > _totalQueue2
	}
	public var isImpossible: Bool {
		var max = _queue1Max > _queue2Max ? _queue1Max : _queue2Max
		return max > targetSum || (_queue1Count + _queue2Count) % 2 == 1
	}
	public var firstQ1: Int {
		return _queue1.firstElement
	}
	public var firstQ2: Int {
		return _queue2.firstElement
	}
	
	func From1To2() {
		var queue1FirstElement = _queue1.firstElement
		_queue1.dequeue()
		_queue2.enquene(queue1FirstElement)
		_totalQueue1 -= queue1FirstElement
		_totalQueue2 += queue1FirstElement
		totalMoveCount += 1
	}
	func From2To1() {
		var queue2FirstElement = _queue2.firstElement
		_queue2.dequeue()
		_queue1.enquene(queue2FirstElement)
		_totalQueue1 += queue2FirstElement
		_totalQueue2 -= queue2FirstElement
		totalMoveCount += 1
	}
	
	func debugQueue1() {
		print("Queue1 is now ")
		_queue1.debug()
	}
	
	func debugQueue2() {
		print("Queue2 is now ")
		_queue2.debug()
	}
	
	func debugAll() {
		print("Queue1 is now ")
		_queue1.debug()
		print("Queue2 is now ")
		_queue2.debug()
	}
	
	init(queue1: [Int], queue2: [Int]) {
		self._queue1 = Queue(queue: queue1)
		self._queue2 = Queue(queue: queue2)
		self._totalQueue1 = _queue1.sum()
		self._totalQueue2 = _queue2.sum()
		self._queue1Max = _queue1.max
		self._queue2Max = _queue2.max
		self._queue1Count = queue1.count
		self._queue2Count = queue2.count
	}
	
	
}

func solution(_ queue1:[Int], _ queue2:[Int]) -> Int {
	var twoQueue = TwoQueue(queue1: queue1, queue2: queue2)
	if twoQueue.isFinish { return 0 }
	if twoQueue.isEven == false { return -1 }
	if twoQueue.isImpossible { return -1 }
	
	while true {
		if twoQueue.isFinish {
			return twoQueue.totalMoveCount
		}
		
		if twoQueue.isLargeThan1 {
			twoQueue.From1To2()
		} else {
			twoQueue.From2To1()
		}
	}
	
	return -1
}

//var queue1 = [100000000,100000000,100000000]
//var queue2 = [100000000,100000000,100000000,100000000,100000000,100000000]
//
//var queue3 = [1, 2, 1, 2]
//var queue4 = [1, 10, 1, 2]

//print(solution(queue1, queue2))
//print(solution(queue3, queue4))


