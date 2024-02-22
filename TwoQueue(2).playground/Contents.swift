import UIKit

class Node {
	let value: Int
	var next: Node?
	
	init(value: Int, next: Node? = nil) {
		self.value = value
		self.next = next
	}
}

struct Queue {
	private var head: Node? = nil
	private var tail: Node? = nil
	
	public mutating func pop() -> Node? {
		let temp = head
		head = head?.next
		return temp
	}
	
	public mutating func push(_ node: Node) {
		node.next = nil
		if tail != nil {
			tail!.next = node
			tail = node
		} else {
			head = node
			tail = node
		}
	}
}
