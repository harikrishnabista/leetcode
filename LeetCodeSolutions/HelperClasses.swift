//
//  HelperClasses.swift
//  LeetCodeSolutions
//
//  Created by Hari Bista on 10/6/19.
//  Copyright © 2019 Bista. All rights reserved.
//

import Foundation

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

public class TreeNode {
    public var val: Int
    
    public var left: TreeNode?
    public var right: TreeNode?
    var parent:TreeNode?
    
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }

    var isLeft:Bool {
        if let parent = self.parent,
            let leftNode = parent.left,
                leftNode.val == self.val {
            return true
        }
        return false
    }
    
    func traversePreOrder() {
        self.traversePreOrder(node: self)
    }
    
    func traversePreOrder(node:TreeNode) {

        if let leftNode = node.left {
            traversePreOrder(node: leftNode)
        }
        
        print(node.val)
        
        if let rightNode = node.right {
            traversePreOrder(node: rightNode)
        }
    }
}

func createLinkedListFromArray(arr:[Int]) -> ListNode? {
    guard arr.count > 0 else {
        return nil
    }
    
    let linkedList = ListNode(arr[0])
    
    var runnerNode:ListNode? = linkedList
    
    guard arr.count > 1 else { return linkedList }
     
    for i in 1...(arr.count - 1) {
        runnerNode?.next = ListNode(arr[i])
        runnerNode = runnerNode?.next
    }

    return linkedList
}

func createBinaryTree(with arr:[Int?]) -> TreeNode? {
    
    if arr.count == 0 {
        return nil
    }
    
    var input = arr
    var queue:[TreeNode] = []
    
    var root:TreeNode?
    if let nodeVal = input.removeFirst() {
        let node = TreeNode(nodeVal)
        queue.append(node)
        root = node
    }
    
    while queue.isEmpty == false {
        let node = queue.removeFirst()
        
        if !input.isEmpty, let leftItemVal = input.removeFirst() {
            let leftNode = TreeNode(leftItemVal)
            node.left = leftNode
            queue.append(leftNode)
        }
        
        if !input.isEmpty, let rightItemVal = input.removeFirst() {
            let rightNode = TreeNode(rightItemVal)
            node.right = rightNode
            queue.append(rightNode)
        }
    }
    
    return root
}

func printLinkedList(head:ListNode?){
    var runnerNode = head
    while runnerNode != nil {
        print(runnerNode?.val ?? "")
        runnerNode = runnerNode?.next
    }
}

func getArray(from node:TreeNode?) -> [TreeNode] {
    
    guard let tree = node else {
        return []
    }
    
    var result:[TreeNode] = []
    
    var queue:[TreeNode] = []
    queue.append(tree)
    
    while queue.isEmpty == false {
        let node = queue.removeFirst()
        
        if let leftNode = node.left {
            queue.append(leftNode)
        }
        
        if let rightNode = node.right {
            queue.append(rightNode)
        }
        result.append(node)
    }
    return result
}

struct ArabicRomanConversion {
    static let conversions = [
        Conversion(arabic: 1000, roman: "M"),
        Conversion(arabic: 900, roman: "CM"),
        Conversion(arabic: 500, roman: "D"),
        Conversion(arabic: 400, roman: "CD"),
        Conversion(arabic: 100, roman: "C"),
        Conversion(arabic: 90, roman: "XC"),
        Conversion(arabic: 50, roman: "L"),
        Conversion(arabic: 40, roman: "XL"),
        Conversion(arabic: 10, roman: "X"),
        Conversion(arabic: 9, roman: "IX"),
        Conversion(arabic: 5, roman: "V"),
        Conversion(arabic: 4, roman: "IV"),
        Conversion(arabic: 1, roman: "I")
    ]
}

struct Conversion {
    let arabic: Int
    let roman: String
}

extension Int {
    var absVal: Int {
        self > 0 ? self: -self
    }
}

class TreeFactory {
    class func createTreeFromArray(arr: [Int?]) -> TreeNode? {
        
        let root: TreeNode = TreeNode(arr[0] ?? 0)
        var queue: [TreeNode] = [root]
        
        var i = 1
        while i < arr.count  {
            let currNode = queue.removeFirst()
            
            if let val = arr[i] {
                currNode.left = TreeNode(val)
            } else {
                currNode.left = nil
            }
            
            i = i + 1
            
            if let leftNode = currNode.left {
                queue.append(leftNode)
            }
            
            if i < arr.count {
                if let val = arr[i] {
                    currNode.right = TreeNode(val)
                } else {
                    currNode.right = nil
                }

                if let rightNode = currNode.right {
                    queue.append(rightNode)
                }
                i = i + 1
            }
        }
        
        return root
    }
}

class LinkedListFactory {
    class func convertArrayToLinkedList(arr:[Int]) -> ListNode? {
        if arr.count == 0 { return nil }
        
        let root: ListNode? = ListNode(arr[0])
        
        if arr.count == 1 {
            return root
        }
        
        var runnerNode: ListNode? = root
        for i in 1...(arr.count - 1) {
            runnerNode?.next = ListNode(arr[i])
            runnerNode = runnerNode?.next
        }
        
        return root
    }

    class func convertLinkedListToArray(list: ListNode?) -> [Int] {
        var runnerNode = list
        var result: [Int] = []
        
        while runnerNode != nil {
            if let runnerNode = runnerNode {
                result.append(runnerNode.val)
            }
            runnerNode = runnerNode?.next
        }
        return result
    }
}


// Function to measure the time taken by another function
func measureTime<T>(_ function: () -> T) -> (T, TimeInterval) {
    let startTime = Date()
    let result = function()
    let endTime = Date()
    let timeTaken = endTime.timeIntervalSince(startTime)
    return (result, timeTaken)
}


class RandomIntFactory {
    private func randomBetween(min: Int, max: Int) -> Int {
        Int(arc4random_uniform(UInt32(max - min + 1))) + min
    }
    
    func getRandomInts(size: Int, min: Int, max: Int) -> [Int] {
        var result: [Int] = []
        
        for i in 0...(size-1) {
            result.append(randomBetween(min: min, max: max))
        }
        
        return result
    }

}

func radixSort(_ array: [Int]) -> [Int] {
    // Determine the maximum number of digits in the array
    let maxDigits = String(array.max() ?? 0).count
    
    // Array to store the buckets
    var buckets = [[Int]](repeating: [], count: 10)
    
    // Collect elements into buckets based on the current digit
    for digitIndex in 0..<maxDigits {
        for number in array {
            let digit = (number / Int(pow(10, Double(digitIndex)))) % 10
            buckets[digit].append(number)
        }
    }
    
    // Create a DispatchGroup
    let group = DispatchGroup()
    
    // Create a concurrent queue for sorting
    let queue = DispatchQueue(label: "com.radixsort.queue", attributes: .concurrent)
    
    // Perform sorting on each bucket asynchronously
    for i in 0..<buckets.count {
        group.enter()
        queue.async {
            buckets[i].sort()
            group.leave()
        }
    }
    
    // Wait for all sorting tasks to complete
    group.wait()
    
    // Flatten the sorted buckets and return the result
    return buckets.flatMap { $0 }
}

struct DateDiffLogger {
    static func secondsDifferenceBetweenDates(startDate: Date, endDate: Date) {
        let interval = endDate.timeIntervalSince(startDate)
        print("Difference in seconds: \(interval)")
    }
}

func aBusyFunc() {
    var sum = 0
    for i in 0...500000 {
        sum = sum + i
    }
    print(sum)
}

import CryptoKit

func hashPassword(_ password: String) -> String {
    let inputData = Data(password.utf8)
    let hashedData = SHA256.hash(data: inputData)
    let hashString = hashedData.compactMap { String(format: "%02x", $0) }.joined()
    return hashString
}

func authenticateUser(
    username: String,
    password: String,
    hashedPassword: String
) -> Bool {
    let enteredPasswordHash = hashPassword(password)
    return enteredPasswordHash == hashedPassword
}

func asyncMocked(seconds: Int) async -> String {
    try? await Task.sleep(nanoseconds: UInt64(1_000_000_000 * seconds))
    return "async"
}


func asyncOperation(completion: @escaping (Result<Int, Error>) -> Void) {
    DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
        // Simulating an asynchronous operation
        let result = Int.random(in: 1...10)
        completion(.success(result))
    }
}

func fetchData() async -> Result<Int, Error> {
    return await withCheckedContinuation { continuation in
        asyncOperation { result in
            continuation.resume(returning: result)
        }
    }
}

func print_aToZ() {
    for scalar in Unicode.Scalar("a").value...Unicode.Scalar("z").value {
        if let letter = Unicode.Scalar(scalar) {
            print(letter)
        }
    }
}
