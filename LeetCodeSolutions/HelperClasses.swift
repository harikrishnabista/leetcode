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



