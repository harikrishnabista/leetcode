//
//  main.swift
//  LeetCodeSolutions
//
//  Created by Hari Bista on 10/5/19.
//  Copyright © 2019 Bista. All rights reserved.
//

import Foundation

/***********************************************************************************/

// move non-zero to the beginning of the array
func moveNonZeroToFront_1(inputArr: [Any]) -> [Any] {
    var resultArr:[Any] = []
    for item in inputArr {
        if let item = item as? Int, item == 0 {
            // do nothing
        }else{
            resultArr.append(item)
        }
    }
    return resultArr
}

func moveNonZeroToFront_2(inputArr:inout [Any]) -> [Any] {
    for (i,item) in inputArr.enumerated() {
        if let item = item as? Int, item == 0 {
            inputArr.remove(at: i)
        }

        print(inputArr)
    }
    return inputArr
}

/*
// test code
 
var input1:[Any] = [ 4, 1, 3, 2, "X", "Y", "Z", 0, 1, 3, 4 ]
let result = moveNonZeroToFront_2(inputArr: &input1)
print(result)
 
*/

/***********************************************************************************/

// Fibonacci sequence

func fib(n:Int) -> Int {
    if n == 0 {
        return 0
    }

    if n == 1 {
        return 1
    }

    return fib(n: n-1) + fib(n: n-2)
}

/*
let n = 5
print(fib(n: n))
*/

/***********************************************************************************/

// Flat nested multi-dimensional array

func flatMe(arr:[Any]) -> [Int] {
    var result:[Int] = []
    for item in arr {
        if let intg = item as? Int {
            result.append(intg)
        }else if let arr = item as? [Any] {
            result.append(contentsOf: flatMe(arr: arr))
        }
    }
    return result
}

/*
let input: [Any] = [1,[4,3],6,[5,[1,0]]]
print(flatMe(arr: input))
*/

/***********************************************************************************/
// check if string is palindrome or not recursively

func isPalindrome(input: String) -> Bool {

    var tempInput = input

    if tempInput.count == 0 || tempInput.count == 1 {
        return true
    }

    let firstChar = tempInput.removeFirst()
    let lastChar = tempInput.removeLast()

    if firstChar != lastChar {
        return false
    }else{
        return isPalindrome(input: tempInput)
    }
}

/*
print(isPalindrome(input: "2001002"))
*/

/***********************************************************************************/

// given an array of words, how to eliminate the duplicates words ?

func removeDuplicateWords(input:[String]) -> Set<String> {
    var setOfWords:Set<String> = []
    for word in input {
        setOfWords.insert(word)
    }
    return setOfWords
}

func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {

    var result: ListNode? = ListNode(-1)
    var previousNode: ListNode? = result

    var firstCurrent: ListNode? = l1
    var secondCurrent: ListNode? = l2

    var carry = 0
    while (firstCurrent != nil || secondCurrent != nil) {

        // if both not nil
        var tempSum = 0
        if let firstCurrent = firstCurrent,
            let secondCurrent = secondCurrent {
            tempSum = firstCurrent.val + secondCurrent.val + carry
        }

        // if firstCurrent nil and secondCurrent not nil
        if let firstCurrent = firstCurrent,
            secondCurrent == nil {
            tempSum = firstCurrent.val + carry
        }

        // if firstCurrent not nil and secondCurrent nil
        if let secondCurrent = secondCurrent,
            firstCurrent == nil {
            tempSum = secondCurrent.val + carry
        }

        if tempSum > 9 {
            carry = tempSum / 10
            tempSum = tempSum % 10
        }else {
            carry = tempSum / 10
        }

        previousNode?.next = ListNode(tempSum)
        previousNode = previousNode?.next

        firstCurrent = firstCurrent?.next
        secondCurrent = secondCurrent?.next
    }

    if carry > 0 {
        previousNode?.next = ListNode(carry)
        previousNode = previousNode?.next
    }

    // removing first Node that is: -1
    if result != nil {
        result = result?.next
    }

    return result
}

/*
let num11 = ListNode(9)
let num12 = ListNode(9)
let num13 = ListNode(9)

num11.next = num12
num12.next = num13

let number1 = num11
let num21 = ListNode(5)
let num22 = ListNode(6)
let num23 = ListNode(4)

num21.next = num22
num22.next = num23

let number2 = num21

if let ret = Solution().addTwoNumbers(number1, number2) {
    var currNode: ListNode? = ret
    repeat {
        print(currNode?.val ?? "nil")
        currNode = currNode?.next

    } while(currNode != nil)
}
*/


/***********************************************************************************/

/*
Given a 32-bit signed integer, reverse digits of an integer.

Assume we are dealing with an environment which could only store integers within the 32-bit signed integer range: [−231,  231 − 1]. For the purpose of this problem, assume that your function returns 0 when the reversed integer overflows.

*/

func getMultiplyer( _ x: Int) -> Int {
    var multiplyer = 1
    var n = x

    while (n >= 10){
        multiplyer = multiplyer * 10
        n = n / 10
    }
    return multiplyer
}

func reverse(_ x: Int) -> Int {

    var n = x > 0 ? x : -x
    var result = 0
    var multiplyer = getMultiplyer(n)

    while (n > 0) {
        let rem = n % 10

        result = result + multiplyer * rem

        // next multiplyer
        multiplyer = multiplyer / 10

        // next number
        n = n / 10
    }

    result = x > 0 ? result : -result

    if result < Int32.min || result > Int32.max {
        return 0
    }

    return result
}


//let result = Solution().reverse(1534236469)
//print(result)

/***********************************************************************************/

/*
leet code
https://leetcode.com/problems/string-to-integer-atoi/
*/

class SolutionMyAtoi {
    func myAtoi(_ str: String) -> Int {
        var result = 0

        if let inputStr = self.validateAtoi(str){
            if let res = Int(inputStr){
                result = res
            }else{
                // if conversion of string to Int is nil, then it must be overflowed
                if let firsChar = inputStr.first, firsChar == "-" {
                    result = Int(Int32.min)
                }else{
                    result = Int(Int32.max)
                }
            }
        } else{
            result = 0
        }

        if result < Int32.min {
            result = Int(Int32.min)
        }

        if result > Int32.max {
            result = Int(Int32.max)
        }

        return result
    }

    func validateAtoi(_ str: String) -> String? {

        var input = str

        // trim white spaces
        input = input.trimmingCharacters(in: .whitespaces)

        // remove post non-digit characters
        var validInput = ""
        for (i,digitChar) in input.enumerated() {

            // for the first char it should be either valid sign or valid digit
            if  i == 0 {
                if self.intSigns.contains(digitChar) || self.digits.contains(digitChar){
                    validInput.append(digitChar)
                }else{
                    break
                }
            }else{
                if self.digits.contains(digitChar){
                    validInput.append(digitChar)
                }else{
                    break
                }
            }
        }

        if validInput == "+" || validInput == "-" {
            return nil
        }

        if validInput.count > 0 {
            return validInput
        }else{
            return nil
        }
    }

    var digits:[Character] = ["0","1","2","3","4","5","6","7","8","9"]
    var intSigns:[Character] = ["+","-"]
}


/*
let result = SolutionMyAtoi().myAtoi("2147483648")
print(result)
 */

/***********************************************************************************/

/*
https://leetcode.com/problems/palindrome-number/
Leet code
Determine whether an integer is a palindrome. An integer is a palindrome when it reads the same backward as forward.
*/

class Solution1_isPalindrome3 {
    func isPalindrome(_ x: Int) -> Bool {
        let strX = String(x)

        var leadCounter = strX.startIndex
        var trailCounter = strX.index(before: strX.endIndex)

        var result = true
        while leadCounter < trailCounter {
            let leadChar = strX[leadCounter]
            let trailChar = strX[trailCounter]

            if leadChar == trailChar {

            }else{
                result = false
                break;
            }

            leadCounter = strX.index(after: leadCounter)
            trailCounter = strX.index(before: trailCounter)
        }

        return result
    }
}

/*
let result = Solution1_isPalindrome3().isPalindrome(0)
print(result)
 */

/***********************************************************************************/

/*
Integer to Roman : LeetCode
https://leetcode.com/problems/integer-to-roman/
*/

class Solution_intToRoman {

    let arabicsToRoman : [Int:String] = [
        1 : "I",
        5 : "V",
        10 : "X",
        50 : "L",
        100 : "C",
        500 : "D",
        1000 : "M"
    ]

    func intToRoman(_ num: Int) -> String {
        var n = num

        var result = ""

        var range = 1
        while n > 0 {
            let rem = n % 10
            result = self.singleDigitIntToRoman(num: rem, range: range) + result
            n = n / 10
            range = range * 10
        }

        return result
    }

    private func singleDigitIntToRoman(num: Int, range: Int) -> String {
        switch num {
        case 1...3:
            var result = ""
            for _ in 1...num {
                if let roman = self.arabicsToRoman[range] {
                    result = result + roman
                }
            }
            return result
        case 4:
            var roman = ""
            if let leadingVal = self.arabicsToRoman[range],
                let trailingVal = self.arabicsToRoman[range * 5] {
                roman = leadingVal + trailingVal
            }

            if range >= 1000 {
                for _ in 1...num {
                    if let romanVal = self.arabicsToRoman[range] {
                        roman = roman + romanVal
                    }
                }
            }

            return roman

        case 5:
            if let roman = self.arabicsToRoman[range * 5] {
                return roman
            }
        case 6...8:
            var roman = ""
            if let leadingVal = self.arabicsToRoman[range * 5] {
                roman = leadingVal + self.singleDigitIntToRoman(num: num - 5, range: range)
            }
            return roman
        case 9:
            var roman = ""
            if let leadingVal = self.arabicsToRoman[range],
                let trailingVal = self.arabicsToRoman[range * 10] {
                roman = leadingVal + trailingVal
            }
            return roman
        case 10:
            if let roman = self.arabicsToRoman[range * 10] {
                return roman
            }
        default:
            print("")
        }
        return ""
    }
}

func toRoman(number: Int) -> String {
    let romanValues = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
    let arabicValues = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]

    var romanValue = ""
    var startingValue = number

    for (index, romanChar) in romanValues.enumerated() {
        let arabicValue = arabicValues[index]

        let div = startingValue / arabicValue

        if (div > 0){
            for _ in 0..<div {
                romanValue += romanChar
            }
            startingValue -= arabicValue * div
        }
    }

    return romanValue
}


//let input = 4999
//print(Solution_intToRoman().intToRoman(input))
//print(toRoman(number: input))

/***********************************************************************************/

/*
Longest Common Prefix
https://leetcode.com/problems/longest-common-prefix/
*/

class Solution_longestCommonPrefix {
    func longestCommonPrefix(_ strs: [String]) -> String {

        guard strs.count > 1 else {

            if strs.count == 1 {
                return strs[0]
            }

            return ""
        }

        var result = commonPrefix(firstStr: strs[0], secondStr: strs[1])

        for str in strs {
            result = commonPrefix(firstStr: result, secondStr: str)
        }

        return result
    }

    private func commonPrefix(firstStr:String, secondStr:String) -> String {
        var result = ""
        let count = min(firstStr.count, secondStr.count)

        for i in 0..<count {
            let firstChar = firstStr[firstStr.index(firstStr.startIndex, offsetBy: i)]
            let secondChar = secondStr[secondStr.index(secondStr.startIndex, offsetBy: i)]
            if firstChar == secondChar {
                result.append(firstChar)
            }else{
                break
            }
        }

        return result
    }
}

//let input = ["ow", "flower", "flow"]
//print(Solution_longestCommonPrefix().longestCommonPrefix(input))

/***********************************************************************************/

/*
Leet Code
letterCombinations
*/

class Solution_letterCombinations {

    private var kvp:[String:String] = [
        "2":"abc",
        "3":"def",
        "4":"ghi",
        "5":"jkl",
        "6":"mno",
        "7":"pqrs",
        "8":"tuv",
        "9":"wxyz"
    ]

    private func getArrayOfChars(str:String) -> [String] {
        var result:[String] = []
        for ch in str {
            result.append(String(ch))
        }
        return result
    }

    func letterCombinations(_ digits: String) -> [String] {

        var result :[String] = []

        for digit in digits {
            if let keys = kvp[String(digit)] {
                let keyArr = self.getArrayOfChars(str: keys)
                result = multiply(firstArr: result, secondArr: keyArr)
            }
        }

        return result
    }

    private func multiply(firstArr: [String], secondArr:[String]) -> [String] {

        guard firstArr.count > 0 && secondArr.count > 0 else {
            if firstArr.count == 0 {
                return secondArr
            }

            if secondArr.count == 0 {
                return firstArr
            }

            return [String]()
        }

        var result:[String] = []
        for firstStr in firstArr {
            for secondStr in secondArr {
                result.append(firstStr + secondStr)
            }
        }

        return result
    }
}

// let result = Solution_letterCombinations().letterCombinations("9999999")

/***********************************************************************************/

/* O(n*n*n) solution brute force */

class Solution1_threeSum {
    func threeSum(_ nums: [Int]) -> [[Int]] {

        var result = Set<Array<Int>>()
        for i in 0..<nums.count {
            for j in (i + 1)..<nums.count {
                for k in (j + 1)..<nums.count {
                    if nums[i] + nums[j] + nums[k] == 0 {
                        let items = [nums[i], nums[j], nums[k]].sorted()
                        result.insert(items)
                    }
                }
            }
        }
        return Array(result)
    }
}

/***********************************************************************************/

// O(n*n) solution
class Solution2_threeSum {
    func threeSum(_ nums: [Int]) -> [[Int]] {

        let sortedNums = nums.sorted()

        if let firstNum = sortedNums.first,
            let lastNum = sortedNums.last,
                firstNum == lastNum {

            if sortedNums.count > 2, firstNum == 0 {
                return [[0, 0, 0]]
            }else{
                return []
            }
        }

        var result = Set<Array<Int>>()

        for (index,num) in sortedNums.enumerated() {

            // remove num itself from the array input
            var tempSortedInput:[Int] = sortedNums
            tempSortedInput.remove(at: index)

            let twoSumResult = twoSum(nums: tempSortedInput, k: num)

            for arr in twoSumResult {
                result.insert(arr.sorted())
            }
        }

        return Array(result)
    }

    func twoSum(nums:[Int], k:Int) -> [[Int]] {

        // leading counter
        var i = 0

        // trailing counter
        var j = nums.count - 1

        var result :[[Int]] = []
        while j > i {
            let sum = nums[i] + nums[j] + k

            if sum > 0 {
                j = j - 1
            } else if sum < 0 {
                i = i + 1
            } else {
                result.append([nums[i], nums[j], k])
                i = i + 1
                j = j - 1

            }
        }

        return result
    }
}

//var input = [-4,-1,-4,0,2,-2,-4,-3,2,-3,2,3,3,-4]
//let res = Solution2_threeSum().threeSum(input)
//print(res)

/***********************************************************************************/

// write program to generate binary numbers

func generateBinary(n:Int){

    let size = Decimal(n)
    let totalCount:Int = (pow(size, 2) as NSDecimalNumber).intValue

    for i in 0...(totalCount-1) {
        var binNumber = ""
        for j in 0...(n-1) {
            if (i & (1 << j)) > 0 {
                binNumber = "1" + binNumber
            }else{
                binNumber = "0" + binNumber
            }
        }
        print(binNumber)
    }
}

// generateBinary(n: 4)


/***********************************************************************************/

// write program to generate power set of given set

//- Given an array, remove the duplicates and return a unique array keeping the first occurrence of the duplicates and the order.
//[@2, @1, @3, @1, @2] --&gt [@2, @1, @3]

func removeDupAndGetUnique(input:[Int]) -> [Int] {

    var dict:[Int:Int] = [:]

    for number in input {
        if let val = dict[number] {
            dict[number] = val + 1
        }else{
            dict[number] = 1
        }
    }

    var result:[Int] = []

    for (key,val) in dict {
        if val > 1 {
            result.insert(key, at: 0)
        }else{
            result.append(key)
        }
    }

    return result
}

//let input = [1,1,2,2,3,4,5,6,7,7,4,7]
//print(removeDupAndGetUnique(input: input))

/***********************************************************************************/

//Input: 1 -> 2 -> 3 -> 4 -> 5
//Output: 2 -> 1 -> 4 -> 3 -> 5

//func reverseAlternateNode(ll:LinkedList<Int>) {
//
//    var prevNode = ll.head?.next
//    var currNode = prevNode?.next
//    var nextNode = currNode?.next
//
//    while(currNode != nil && nextNode != nil && prevNode != nil){
//        if let tempCurrNode = currNode, let tempNextNode = nextNode {
//
//            tempCurrNode.next = tempNextNode.next
//            tempNextNode.next = tempCurrNode
//            prevNode?.next = nextNode
//
//            prevNode = tempCurrNode
//            currNode = prevNode?.next
//            nextNode = currNode?.next
//        }
//    }
//}

/*
let linkedList = LinkedList<Int>()

linkedList.append(1)
linkedList.append(2)
linkedList.append(3)
linkedList.append(4)
linkedList.append(5)
linkedList.append(6)
linkedList.append(7)
linkedList.append(8)

print("Input")
print(linkedList)

print("")
print("Output")
reverseAlternateNode(ll: linkedList)
print(linkedList)
print("")

*/

/***********************************************************************************/

class Node {
    var name: String
    var value: Int
    var children: [Node] = []
    weak var parent: Node?

    weak var searchNode:Node?

    init(name: String, value:Int) {
        self.value = value
        self.name = name
    }

    func traverse() {
        self.postOrderTraverse(node: self)

        if let node = self.searchNode {
            print("\(node.name) : \(node.value)")
        }
    }

    func find() {
        let result = self.findChildHaving1(node: self)
        if let result = result {
            print("\(result.name) : \(result.value)")
        }
    }

    func findChildHaving1(node:Node) ->Node?{
        for child in node.children {
            if(child.value>0){
                return child
            }else{
                let returnNOde = findChildHaving1(node: child)

                if(returnNOde != nil){
                    return returnNOde
                }
            }
        }

        return nil
    }

    func postOrderTraverse(node:Node) {
        for child in node.children {
            if(child.value>0){
                self.searchNode = child
//                print("\(child.name) : \(child.value) : childrens: \(child.children.count)")
            }else{
                postOrderTraverse(node: child)
            }
        }
    }
}

/*
let aNode = Node(name: "A", value: 0)

let bNode = Node(name: "B", value: 0)
let dNode = Node(name: "D", value: 0)
let eNode = Node(name: "E", value: 0)

let cNode = Node(name: "C", value: 0)
let fNode = Node(name: "F", value: 1)
let gNode = Node(name: "G", value: 0)

//let hNode = Node(name: "H", value: 1)
//let iNode = Node(name: "I", value: 1)
//let jNode = Node(name: "J", value: 1)

aNode.children.append(bNode)
aNode.children.append(cNode)

bNode.children.append(dNode)
bNode.children.append(eNode)

cNode.children.append(fNode)
cNode.children.append(gNode)

//dNode.children.append(hNode)
//dNode.children.append(iNode)

aNode.find()

func postOrderTraverse(node:Node)->Node {
    for child in node.children {
        if(child.children.count > 0){
            postOrderTraverse(node: child)

            if(child.value > 0){
                return child;
            }
        }else{
            if(child.value > 0){
                return child;
            }
        }

    }

    return node;
}
*/

/***********************************************************************************/

// Given an array, without using extra space, move all zeros  to the end and no-zeros to the beginning. The function should return the number of non-zeros.

class solution_zerosCounter {
    func zerosCounter() {
        var input = [1,0,0,1,2,3]
        var counter = 0
        var zerosCounter = 0
        
        while(counter < input.count){
           if input[counter] == 0 {
               input.remove(at: counter)
               zerosCounter = zerosCounter + 1
           } else {
               counter = counter + 1
           }
        }
        
        while(zerosCounter > 0) {
           input.append(0)
           zerosCounter = zerosCounter - 1
        }
    }
}

/***********************************************************************************/

/*
Given a string, find the length of the longest substring without repeating characters.

Example 1:

Input: "abcabcbb"
Output: 3
Explanation: The answer is "abc", with the length of 3.
Example 2:

Input: "bbbbb"
Output: 1
Explanation: The answer is "b", with the length of 1.
Example 3:

Input: "pwwkew"
Output: 3
Explanation: The answer is "wke", with the length of 3.
Note that the answer must be a substring, "pwke" is a subsequence and not a substring.

*/

func lengthOfLongestSubstring(_ s: String) -> Int {

    var result = ""
    var tempResult = ""

    var index = s.startIndex

    while index < s.endIndex {

        let char = s[index]
        if tempResult.contains(char){
            if let charIndex = tempResult.lastIndex(of: char){
                let distance = tempResult.distance(from: charIndex, to: tempResult.endIndex)
                index = s.index(index, offsetBy: -distance)
                index = s.index(after: index)
            }
            tempResult = ""

        }else{
            tempResult = tempResult + [char]
            index = s.index(after: index)
        }

        if tempResult.count > result.count {
            result = tempResult
        }
    }

    return result.count
}

//let s = " "
//let result = lengthOfLongestSubstring(s)
//print(result)

/***********************************************************************************/

/* https://leetcode.com/problems/first-missing-positive/ */
/* Given an unsorted integer array, find the smallest missing positive integer. */

class Solution_firstMissingPositive {
    func firstMissingPositive(_ nums: [Int]) -> Int {
        var storage:[Bool] = [Bool](repeating: false, count: nums.count + 2)
        for num in nums {
            if num > 0 && num < storage.count {
                storage[num] = true
            }
        }
        for (i,hasValue) in storage.enumerated() {
            if hasValue == false && i > 0 {
                return i
            }
        }
        return 1
    }
}

/*
let input = [7,8,9,11,12]
let result = Solution_firstMissingPositive().firstMissingPositive(input)
print(result)
*/

/***********************************************************************************/

//Given two non-negative integers num1 and num2 represented as strings, return the product of num1 and num2, also represented as a string.

class Solution1_multiply {
    func multiply(_ num1: String, _ num2: String) -> String {
        // convert num2 into array of numbers
        // most significant number at last index order
        var multipliers:[Int8] = []
        for num in num2 {
            if let num = Int8(String(num)) {
                multipliers.insert(num, at: 0)
            }
        }
        // convert num1 into array of numbers
        // least significant number first
        // revisit this later to refactor there are two consequtive redundant code
        var multiplends:[Int8] = []
        for num in num1 {
            if let num = Int8(String(num)) {
                multiplends.insert(num, at: 0)
            }
        }
        var sum = 0
        var tenth_i = 1
        for mutipler in multipliers {
            var tenth_j = 1
            for multiplend in multiplends {
                let x = Int(mutipler) * tenth_i
                let y = Int(multiplend) * tenth_j
                sum = sum + x * y
                // incrementing the 10th multiplend
                tenth_j = tenth_j * 10
            }
            // incrementing the 10th mutipler
            tenth_i = tenth_i * 10
        }
        return String(sum)
    }

}

/*
"498828660196"
"840477629533"
 this below solution is not effective as it fails for following test case
let num1 = "498828660196", num2 = "840477629533"
let result = Solution1_multiply().multiply(num1, num2)
print(result)
 */


// efficient solution

class Solution_multiply {
    func multiply(_ num1: String, _ num2: String) -> String {
        if num1 == "0" || num2 == "0" {
            return "0"
        }
        // convert num2 into array of numbers
        // most significant number at last index order
        var multipliers:[Int8] = []
        for num in num2 {
            if let num = Int8(String(num)) {
                multipliers.insert(num, at: 0)
            }
        }
        // convert num1 into array of numbers
        // least significant number first
        // revisit this later to refactor there are two consequtive redundant code
        var multiplends:[Int8] = []
        for num in num1 {
            if let num = Int8(String(num)) {
                multiplends.insert(num, at: 0)
            }
        }
        var result:[[Int8]] = []
        for (i,multiplier) in multipliers.enumerated() {
            var carry:Int8 = 0
            var tempResultArr:[Int8] = []
            for _ in 0..<i {
                tempResultArr.insert(0, at: 0)
            }
            for multiplend in multiplends {
                let tempRes = multiplend * multiplier + carry
                let rem = tempRes % 10
                carry = tempRes / 10
                tempResultArr.append(rem)
            }
            if carry > 0 {
                tempResultArr.append(carry)
            }
            result.append(tempResultArr)
        }
        let longestArrayCount = result[result.count-1].count
        var ultimateResultArray:[String] = []
        var carry = 0
        // loop through all the results and sum corresponding bits
        for i in 0...(longestArrayCount-1) {
            var sum = 0
            for arr in result {
                if i < arr.count {
                    sum = sum + Int(arr[i])
                }
            }
            sum = sum + carry
            let rem = sum % 10
            carry = sum / 10
            if rem == 0 {
                print("")
            }
            // bringing back most significant part to first index. (Human readable)
            ultimateResultArray.insert(String(rem), at: 0)
        }
        if carry > 0 {
            ultimateResultArray.insert(String(carry), at: 0)
        }
        return ultimateResultArray.joined()
    }

}

/*
//let num1 = "54321", num2 = "543"
//let num1 = "498828660196", num2 = "840477629533"
let num1 = "9133", num2 = "0"
let result = Solution_multiply().multiply(num1, num2)
print(result)
*/

/***********************************************************************************/

class Solution_longestUnivaluePath {
    
    func longestUnivaluePath(_ root: TreeNode?) -> Int {
        var count = 0
        if let runnerRoot = root {
            
            var leftCount = longestUnivaluePath(runnerRoot.left)
            var rightCount = longestUnivaluePath(runnerRoot.right)
            
            if runnerRoot.val == runnerRoot.left?.val {
                leftCount = leftCount + 1
            }
            
            if runnerRoot.val == runnerRoot.right?.val {
                rightCount = rightCount + 1
            }
            
            if runnerRoot.val == runnerRoot.left?.val && runnerRoot.val == runnerRoot.right?.val {
                count = max(count, rightCount + leftCount)
            } else {
                count = max(count, rightCount, leftCount)
            }
            
        } else {
            return count
        }
        return count
    }
}

/*
let node = TreeNode(5)

let node1 = TreeNode(4)
node.left = node1

let node2 = TreeNode(5)
node.right = node2

let node3 = TreeNode(1)
node1.left = node3

let node4 = TreeNode(1)
node2.right = node4

let node5 = TreeNode(5)
node2.right = node5

let result = Solution_longestUnivaluePath().longestUnivaluePath(node)
print(result)
 
*/

/***********************************************************************************/

// flatten array

func flatten(arr:[Any]) -> [Int] {
    var result:[Int] = []
    for item in arr {
        if let number = item as? Int {
            result.append(number)
        }
        else if let newArr = item as? [Any] {
            result.append(contentsOf: flatten(arr: newArr))
        }
    }

    return result
}

/*
let input:[Any] = [3, 4, [4, [[55]]]]
let result = flatten(arr: input)
print(result)
*/

/***********************************************************************************/

// Permutation

func permutate(arr:[String]) -> [[String]] {
    let result = permuteMe(arr: arr, l: 0, r: arr.count-1)
    return result
}

func permuteMe(arr: [String],l:Int, r:Int) -> [[String]] {
    var result:[[String]] = []
    
    if l == r {
        result.append(arr)
    } else {
        for i in l...r {
            var tempArr:[String] = arr
            tempArr.swapAt(l, i)
            result.append(contentsOf: permuteMe(arr: tempArr, l: l+1, r: r))
        }
    }
    return result
}

/*
var arr = ["A","B","C","D"]
let result = permutate(arr: arr)
print(result)
*/

/***********************************************************************************/

class Solution_mySqrt {
    func mySqrt(_ x: Int) -> Int {
        
        var counter = x
        
        while counter*counter > x {
            counter = counter/2
        }
        
        while(counter <= x){
            if checkIfSqrtFound(counter, x: x) {
                return counter
            }
            counter = counter + 1
        }
        
        return 0
    }
    
    func checkIfSqrtFound(_ n:Int, x:Int) -> Bool {
        
        if n*n == x {
            return true
        }
        
        let range:Range = Range(uncheckedBounds: (lower: n*n, upper: (n+1)*(n+1)))
        return range.contains(x)
    }
}

/*
let result = Solution_mySqrt().mySqrt(101)
print(result)
*/

/***********************************************************************************/

// Permutation using String instead [String]

func permutate(input:String) -> [String] {
    
    func swapCharacters(input: String, index1: Int, index2: Int) -> String {
        var characters = Array(input)
        characters.swapAt(index1, index2)
        return String(characters)
    }
    
    func permuteMe(input: String, pivotIndex:Int) -> [String] {
        var result:[String] = []
        
        if pivotIndex == (input.count - 1) {
            result.append(input)
        } else {
            for i in pivotIndex...(input.count - 1) {
                let nextInput = swapCharacters(input: input, index1: pivotIndex, index2: i)
                result.append(contentsOf: permuteMe(input: nextInput, pivotIndex: pivotIndex + 1))
            }
        }
        return result
    }
    
    let result = permuteMe(input: input, pivotIndex: 0)
    return result
}

/*
let result = permutate(input: "ABCD")
for str in result {
    print(str)
}
*/

/***********************************************************************************/

 // NOt efficient solution
 
 //class Solution1 {
 //    func myPow(_ x: Double, _ n: Int) -> Double {
 //        var counter = 0
 //        var result:Double = 1
 //
 //        while (counter < abs(n) ) {
 //            result = result * x
 //            counter = counter + 1
 //        }
 //
 //        if n < 0 {
 //            return 1/result
 //        }
 //
 //        return result
 //    }
 //}

 // efficient solution
 
class Solution_myPow {
    func myPow(_ x: Double, _ n: Int) -> Double {
        
        var base = x
        let exponent = abs(n)
        
        if n < 0 {
            base = 1 / base
        }
        
        if exponent == 0 {
            return 1
        } else if exponent == 1 {
            return base
        } else if exponent % 2 == 0 {
            return myPow(base * base, exponent/2)
        } else if exponent % 2 == 1 {
            return base * myPow(base * base, exponent/2)
        } else {
            return 0
        }
    }
}

//let result = Solution().myPow(0.00001, 2147483647)
//let result = Solution().myPow(5, 20)
//print(result)


/***********************************************************************************/

class Solution_generateParenthesis {
    func generateParenthesis(_ n: Int) -> [String] {
        var result:[String] = []
        self.backTrack(result: &result, ans: "", open: 0, close: 0, n: n)
        return result
    }
    
    private func backTrack(result:inout [String], ans:String, open:Int, close:Int, n:Int) {
        
        if ans.count == n * 2 {
            result.append(ans)
            return
        }
        
        if open < n {
            self.backTrack(result: &result, ans: ans + "(", open: open + 1, close: close, n: n)
        }
        
        if open > close {
            self.backTrack(result: &result, ans: ans + ")", open: open, close: close + 1, n: n)
        }
    }
}

/*
let result = Solution_generateParenthesis().generateParenthesis(5)
print(result)
*/


/***********************************************************************************/

// https://leetcode.com/problems/remove-element/

/* Not efficiet but does not uses any library function, good for practice */

class Solution1_removeElement {
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var count = 0
        var shiftCount = 0
        
        while count < nums.count - shiftCount {
            
            if nums[count] == val {
                self.shiftToLeft(index: count, nums: &nums)
                shiftCount = shiftCount + 1
            } else {
                count = count + 1
            }
        }
        
        return nums.count - shiftCount
    }
    
    fileprivate func shiftToLeft(index:Int, nums: inout [Int]) {
        // we must have nums greater than 1 in order to use shift
        if nums.count > 1, index < nums.count - 1 {
            let firstNum = nums[index]
            
            for i in (index+1)...nums.count - 1 {
                nums[i-1] = nums[i]
            }
            
            nums[nums.count - 1] = firstNum
        }
    }
}

class Solution2_removeElement {
    func strStr(_ haystack: String, _ needle: String) -> Int {
        if needle.isEmpty {
            return 0
        }
        
        if needle.count > haystack.count {
            return -1
        }
        
        var needleCounter = 0
        var i = 0
        
        while i < haystack.count {
            
            let haystackCharIndex = haystack.index(haystack.startIndex, offsetBy: i)
            let needleIndex = needle.index(needle.startIndex, offsetBy: needleCounter)
            
            if haystack[haystackCharIndex] == needle[needleIndex] {
                needleCounter = needleCounter + 1
            } else {
                if needleCounter > 0 {
                    i = (i - needleCounter)
                    needleCounter = 0
                }
            }
            
            if needleCounter == needle.count {
                return i + 1 - needle.count
            }
            
            i = i + 1
        }
        
        return -1
    }
}

/*
let input = "mississippi"
let result = Solution2_removeElement().strStr(input, "pi")
*/

/* Seems like efficient solution but leed code does not accept and I gave up on this
class Solution {
    func strStr(_ haystack: String, _ needle: String) -> Int {
        
        if needle.isEmpty {
            return 0
        }
        
        if let range = haystack.range(of: needle) {
            let startPos = haystack.distance(from: haystack.startIndex, to: range.lowerBound)
            return startPos
        }
        return -1
    }
}

let input = "mississippi"
let result = Solution().strStr(input, "mississippio")

 */



/***********************************************************************************/


class Solution_isValidCondition {
    
    private func isValidCondition(startChar:Character,endChar:Character) -> Bool {
        
        let isValid_1 = (startChar == "(" && endChar == ")")
        let isValid_2 = (startChar == "{" && endChar == "}")
        let isValid_3 = (startChar == "[" && endChar == "]")
        
        return isValid_1 || isValid_2 || isValid_3
    }
    
    func isValid(_ s: String) -> Bool {
        
        var stack:[Character] = []
        
        for ch in s {
            if ch == "(" || ch == "{" || ch == "[" {
                stack.append(ch)
            } else if stack.isEmpty {
                return false
            } else {
                let popVal = stack.removeLast()
                if !self.isValidCondition(startChar: popVal, endChar: ch) {
                    return false
                }
            }
        }
        
        return stack.isEmpty
    }
}

/*
let result = Solution_isValidCondition().isValid("{}{[]}[{}]()")
print(result)
 */

/***********************************************************************************/

// Permutate the string into all possible substrings

func permutate1(input:String) -> [String] {
    func permuteMe(input: String, start:Int, end:Int) -> [String] {
        
        func swapCharacters(input: String, index1: Int, index2: Int) -> String {
            var characters = Array(input)
            characters.swapAt(index1, index2)
            return String(characters)
        }
        
        var result:[String] = []
        
        if start > 0 {
            // collecting intermediate results
            let sIndex = input.index(input.startIndex, offsetBy: start)
            let newStr = String(input[..<sIndex])
            result.append(newStr)
        }
        
        if start == end {
            // collecting final results
            result.append(input)
        } else {
            for i in start...end {
                let nextInput = swapCharacters(input: input, index1: start, index2: i)
                result.append(contentsOf: permuteMe(input: nextInput, start: start + 1, end: end))
            }
        }
        return result
    }
    
    let result = permuteMe(input: input, start: 0, end: input.count - 1)
    return result
}

/***********************************************************************************/

class Solution_permutations {
    private func permutations(arr: [Int],l:Int, r:Int) -> [[Int]] {
        var result:[[Int]] = []
        
        if l == r {
            result.append(arr)
        } else {
            for i in l...r {
                var tempArr:[Int] = arr
                tempArr.swapAt(l, i)
                result.append(contentsOf: permutations(arr: tempArr, l: l+1, r: r))
            }
        }
        return result
    }
    
    func permute(_ nums: [Int]) -> [[Int]] {
        if nums.count > 0 {
            return permutations(arr: nums, l: 0, r: nums.count-1)
        } else {
            return []
        }
    }
}


/*
var jpt:[Int] = []
let result = Solution_permutations().permute(jpt)
print(result)
*/

/***********************************************************************************/

class Solution_maxSubArray {
    func maxSubArray(_ nums: [Int]) -> Int {
        var max = Int.min
        var max_end_here = 0
        
        for num in nums {
            max_end_here = max_end_here + num
            
            if max_end_here > max {
                max = max_end_here
            }
            
            if max_end_here < 0 {
                max_end_here = 0
            }
        }
        return max
    }
}

/*
let input = [-2,1,-3,4,-1,2,1,-5,4]
let res = Solution_maxSubArray().maxSubArray(input)
print(res)
*/

/***********************************************************************************/

class Solution_lengthOfLastWord {
    func lengthOfLastWord(_ s: String) -> Int {
        let arr = s.split(separator: " ")
        
        if arr.count > 0 {
            return arr[arr.count-1].count
        }
        
        return 0
    }
}

/*
let res = Solution_lengthOfLastWord().lengthOfLastWord("")
print(res)
*/

/***********************************************************************************/

class Solution_deleteDuplicates {
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        
        var prevNode = head
        var currNode = prevNode?.next
        
        while currNode != nil {
            
            if currNode?.val == prevNode?.val {
                prevNode?.next = currNode?.next
            } else {
                prevNode = currNode
            }
            currNode = prevNode?.next
        }
        
        return head
    }
}

/*
let head = ListNode(1)
let secondNode = ListNode(2)
let thirdNode = ListNode(2)
let fourthNode = ListNode(2)
let fivthNode = ListNode(3)
let sixthNode = ListNode(4)
let seventhNode = ListNode(4)
let eiththNode = ListNode(4)

head.next = secondNode
secondNode.next = thirdNode
thirdNode.next = fourthNode
fourthNode.next = fivthNode
fivthNode.next = sixthNode
sixthNode.next = seventhNode
seventhNode.next = eiththNode

//let result = Solution_deleteDuplicates().deleteDuplicates(head)

if let result = Solution_deleteDuplicates().deleteDuplicates(head) {
    var runnerNode:ListNode? = result
    while runnerNode != nil {
        if let val = runnerNode?.val {
            print(val)
        }
        runnerNode = runnerNode?.next
    }
}
*/

/***********************************************************************************/

class Solution_plusOne {
    func plusOne(_ digits: [Int]) -> [Int] {
        var input = digits
        var count = input.count - 1
        
        let sum = input[count] + 1
        var carry = 0
        if sum > 9 {
            carry = 1
            input[count] = 0
        } else {
            input[count] = sum
        }
        
        count = count - 1
        
        while count >= 0 {
            let sum = input[count] + carry
            if sum > 9 {
                input[count] = 0
                carry = 1
            } else {
                input[count] = sum
                carry = 0
                break
            }
            count = count - 1
        }
        
        if carry > 0 {
            input.insert(carry, at: 0)
        }
        
        return input
    }
}

/*
let result = Solution_plusOne().plusOne([9,9,9])
print(result)
*/

/***********************************************************************************/

class Solution_addBinary {
    func addBinary(_ a: String, _ b: String) -> String {
        var result:String = ""
        
        let longerStr = a.count >= b.count ? a : b
        let shortStr = a.count < b.count ? a : b
    
        var counter = longerStr.count - 1
        let diff = abs(a.count - b.count)
        
        var carry = 0
        while counter >= 0 {
            // find last char
            let idx1 = longerStr.index(longerStr.startIndex, offsetBy: counter)
            let intCh1 = Int("\(longerStr[idx1])") ?? 0
            
            var intCh2 = 0
            if counter - diff >= 0 {
                let idx2 = shortStr.index(shortStr.startIndex, offsetBy: counter - diff)
                intCh2 = Int("\(shortStr[idx2])") ?? 0
            }

            let sum = intCh1 + intCh2 + carry
            var intRes:Character = "0"

            carry = sum > 1 ? 1 : 0
            intRes = sum % 2 == 0 ? "0" : "1"

            result.insert(intRes, at: result.startIndex)
            
            counter = counter - 1
        }
        
        if carry > 0 {
            result.insert("1", at: result.startIndex)
        }
        
        return result
    }
}

/*
let result = Solution().addBinary("11", "01")
print(result)
*/

/***********************************************************************************/

class Solution_countedHistory {
    var countedHistory:[Int:Int] = [:]
    func climbStairs(_ n: Int) -> Int {
        if n == 0 {
            return 1
        }
        
        if n < 0 {
            return 0
        }
        
        if let alreadyCounted = self.countedHistory[n] {
            return alreadyCounted
        }
        
        let result1 = climbStairs(n - 1)
        self.countedHistory[n - 1] = result1
        
        let result2 = climbStairs(n - 2)
        self.countedHistory[n - 2] = result2
        
        return result1 + result2
    }
}

/*
print(Solution_countedHistory().climbStairs(10))
*/


/***********************************************************************************/

class Solution_sortedArrayToBST {
    var nums:[Int] = []
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        self.nums = nums
        return self.arrayToBST(l: 0, r: nums.count - 1)
    }
    
    private func arrayToBST(l:Int, r:Int) -> TreeNode? {
        
        if l > r {
            return nil
        }
        
        let m = (l + r + 1)/2
        let node = TreeNode(self.nums[m])
        
        if l == r {
            return node
        }
        
        node.left = self.arrayToBST(l: l, r: m - 1)
        node.right = self.arrayToBST(l: m + 1, r: r)
        
        return node
    }
}

/*
let result = Solution_sortedArrayToBST().sortedArrayToBST([-10,-3,0,5,9])
result?.traversePreOrder()
*/


/***********************************************************************************/

// https://leetcode.com/problems/maximum-depth-of-binary-tree/
class Solution_singleNumber {
    func singleNumber(_ nums: [Int]) -> Int {
        var result = 0
        for item in nums {
            result = result ^ item
        }
        return result
    }
}

/*
let res = Solution_singleNumber().singleNumber([0,0,1,1,2,2,3,3])
print(res)
*/

/***********************************************************************************/

class Solution_maxDepth {
    func maxDepth(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        return max(1 + maxDepth(root?.left),1 + maxDepth(root?.right))
    }
}

/*
let binTreeArr = [3,9,20,nil,nil,15,7]
let binTree = createBinaryTree(with: binTreeArr)
let height = Solution().maxDepth(binTree)
print(height)
*/

/***********************************************************************************/

class Solution1_isPalindrome4 {
    
    private func isAlphaneumaric(_ ch:Character) -> Bool {
        if let asciiVal = ch.asciiValue {
            switch asciiVal {
            case 97...122:
                return true
            case 65...90:
                return true
            case 48...57:
                return true
            default:
                return false
            }
        }
        return false
    }
    
    func isPalindrome(_ s: String) -> Bool {
        
        var input:[Character] = []
        // collecting only alpha neumaric characters
        for ch in s {
            if self.isAlphaneumaric(ch) {
                input.append(ch)
            }
        }
        
        var counter = 0
        while counter < input.count - 1 - counter {
            if input[counter].uppercased() != input[input.count - 1 - counter].uppercased() {
                return false
            }
            counter = counter + 1
        }
        
        return true
    }
}

/*
let result = Solution1_isPalindrome4().isPalindrome("A man, a plan, a canal: Panama")
print(result)
*/


/***********************************************************************************/

class Solution_levelOrderBottom {
    func levelOrderBottom(_ root: TreeNode?) -> [[Int]] {
        var result = [[Int]]()
        
        guard let root = root else {
            return result
        }
        
        var levelNodes:[TreeNode] = []
        levelNodes.append(root)
        
        while !levelNodes.isEmpty {
            var items:[Int] = []
            var nextLevelNodes:[TreeNode] = []
            
            for node in levelNodes {
                // colllecting items in level nodes
                items.append(node.val)
                
                // getting new level nodes for next level
                if let leftNode = node.left {
                    nextLevelNodes.append(leftNode)
                }
                
                if let rightNOde = node.right {
                    nextLevelNodes.append(rightNOde)
                }
            }

            result.insert(items, at: 0)
            
            levelNodes = nextLevelNodes
        }
        
        return result
    }
}

/*
let binTreeArr = [3,9,20,nil,nil,15,7]
let binTree = createBinaryTree(with: binTreeArr)
let result = Solution_levelOrderBottom().levelOrderBottom(binTree)
print(result)
*/


/***********************************************************************************/

class MinStack {

    var storage:[Int] = []
    var minimum:Int = Int.max
    
    init() {
        
    }
    
    func push(_ x: Int) {
        self.storage.append(x)
        if x < minimum {
           minimum = x
        }
    }
    
    func pop() {
        let removedItem = self.storage.removeLast()
        
        // if just removed item was minimum item then find again the smallest item
        if removedItem == self.minimum {
            self.minimum = Int.max
            for item in self.storage {
                if item < self.minimum {
                    self.minimum = item
                }
            }
        }
    }
    
    func top() -> Int {
        return self.storage[self.storage.count - 1]
    }
    
    func getMin() -> Int {
        return self.minimum
    }
}

/***********************************************************************************/

class Solution_twoSum {
    func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
        var i = 0
        var j = numbers.count - 1
        
        while i < j {
            let sum = numbers[i] + numbers[j]
            
            if sum == target {
                return [i + 1, j + 1]
            } else if sum > target {
                j = j - 1
            } else {
                i = i + 1
            }
        }
        
        return [0,0]
    }
}

/***********************************************************************************/
// https://leetcode.com/problems/rotate-array/submissions/
 
class Solution_rotate {
    func rotate(_ nums: inout [Int], _ k: Int) {
        var result:[Int] = [Int](repeating: 0, count: nums.count)
        
        for (i,number) in nums.enumerated() {
            let index = (i + k) % nums.count
            result[index] = number
        }
        nums = result
    }
}

/*
var input = [1,2,3,4,5,6,7]
Solution().Solution_rotate(&input, 3)
print(input)
*/

/***********************************************************************************/

class Solution_majorityElement {
    func majorityElement(_ nums: [Int]) -> Int {
        var dict:[Int:Int] = [:]
        
        for item in nums {
            dict[item] = (dict[item] ?? 0) + 1
        }
        
        var mostRepeatedItem = nums[0]
        var mostRepeatedItemCount = 1
        
        for item in dict.enumerated() {
            if item.element.value > mostRepeatedItemCount {
                mostRepeatedItem = item.element.key
                mostRepeatedItemCount = item.element.value
            }
        }
        
        return mostRepeatedItem
    }
}

/***********************************************************************************/

class Solution_reverseWords {
    func reverseWords(_ s: String) -> String {
        
        let arr = s.split(separator: " ")
        
        var revWords:[String] = []
        
        for item in arr {
            revWords.insert(String(item), at: 0)
        }
        
        // using old style loop
//        var result = ""
//        for (i,item) in revWords.enumerated() {
//            if i == 0 {
//                result = item
//            } else {
//                result = result + " " + item
//            }
//        }
//        using reduce functional approach
//
//        return revWords.reduce("") { (x, y) -> String in
//            x + " " +  y
//        }
//
//      using functional approach with shorter syntax
        return revWords.joined(separator: " ")
    }
}

/*
let input = "the    sky       is blue"
let result = Solution_reverseWords().reverseWords(input)
print(result)
*/


/***********************************************************************************/

class BSTIterator {
    var stack:[Any] = []
    
    var root:TreeNode?
    init(_ root: TreeNode?) {
        self.root = root
        
        if let root = root {
            self.stack.append(root)
        }
    }

    func next() -> Int {
        while self.hasNext() {
            let item = self.stack.removeLast()
            if let val = item as? Int {
                return val
            } else if let item = item as? TreeNode {
                
                if item.right == nil && item.left == nil {
                    return item.val
                }
                
                if let rightNode = item.right {
                    self.stack.append(rightNode)
                }
                
                self.stack.append(item.val)
                
                if let leftNode = item.left {
                    self.stack.append(leftNode)
                }
            }
        }
        return 0
    }
    
    func hasNext() -> Bool {
        return self.stack.count > 0
    }
}

/*
let input = [7,3,15,nil,nil,9,20]
let bst = createBinaryTree(with: input)
let obj = BSTIterator(bst)

print(obj.next())
print(obj.next())
print(obj.hasNext())
print(obj.next())
print(obj.hasNext())
print(obj.next())
print(obj.hasNext())
print(obj.next())
print(obj.hasNext())
print(obj.next())
print(obj.hasNext())
*/

/***********************************************************************************/

class Solution_removeNthFromEnd {
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        
        var currNode = head
        var forwardNode = head
        
        var counter = n
        while counter - 1 > 0 {
            forwardNode = forwardNode?.next
            counter = counter - 1
        }
        
        if forwardNode == nil {
            return head
        }
        
        if forwardNode?.next == nil {
            return head?.next
        }
        
        var previousNode:ListNode?
        while forwardNode?.next != nil {
            forwardNode = forwardNode?.next
            previousNode = currNode
            currNode = currNode?.next
        }
        
        // delete nth node from end
        previousNode?.next = previousNode?.next?.next

        return head
    }
}


/*
let linkedList = createLinkedListFromArray(arr: [1,2,3])

print("Input: ")
printLinkedList(head: linkedList)

if let newLinkedList = Solution_removeNthFromEnd().removeNthFromEnd(linkedList, 3) {
    print("output: ")
    printLinkedList(head: newLinkedList)
}
*/


/***********************************************************************************/

class Solution_mergeTwoLists {
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var firstRunNode = l1
        var secondRunNode = l2
        
        var resultRunNode:ListNode?
        if let fRunNode = firstRunNode,
            let sRunNode = secondRunNode {
            
            if fRunNode.val < sRunNode.val {
                resultRunNode = firstRunNode
                firstRunNode = firstRunNode?.next
            } else {
                resultRunNode = secondRunNode
                secondRunNode = secondRunNode?.next
            }
            
        } else {
            if firstRunNode != nil {
                resultRunNode = firstRunNode
                firstRunNode = firstRunNode?.next
            } else if secondRunNode != nil {
                resultRunNode = secondRunNode
                secondRunNode = secondRunNode?.next
            }
        }
        
        let resultHead = resultRunNode
        
        // merge here
        while firstRunNode != nil || secondRunNode != nil {
            if let fRunNode = firstRunNode,
                let sRunNode = secondRunNode {
                
                if fRunNode.val < sRunNode.val {
                    resultRunNode?.next = firstRunNode
                    firstRunNode = firstRunNode?.next
                } else {
                    resultRunNode?.next = secondRunNode
                    secondRunNode = secondRunNode?.next
                }
                
            } else {
                if firstRunNode != nil {
                    resultRunNode?.next = firstRunNode
                    firstRunNode = firstRunNode?.next
                } else if secondRunNode != nil {
                    resultRunNode?.next = secondRunNode
                    secondRunNode = secondRunNode?.next
                }
            }
            
            resultRunNode = resultRunNode?.next
        }
        
        return resultHead
    }
}

/*
let l1 = createLinkedListFromArray(arr: [1,2,5,7,9,100])
let l2 = createLinkedListFromArray(arr: [0,1001])
if let res = Solution_mergeTwoLists().mergeTwoLists(l1, l2) {
    printLinkedList(head: res)
}
*/

/***********************************************************************************/

/*
let result1 = permutate1(input: "ABC")
print(result1)
*/

class Solution_swapPairs {
    func swapPairs(_ head: ListNode?) -> ListNode? {
        
        if head == nil {
            return nil
        }
        
        if head?.next == nil {
            return head
        }
        
        let tempNext = head?.next
        head?.next = tempNext?.next
        tempNext?.next = head
        let resultHead = tempNext
        
        var currNode = resultHead?.next
        
        while currNode?.next?.next != nil {
            let tempNext = currNode?.next
            currNode?.next = tempNext?.next
            tempNext?.next = currNode?.next?.next
            currNode?.next?.next = tempNext
            
            currNode = tempNext
        }
        
        return resultHead
    }
}

/*
let head = ListNode(1)
let secondNode = ListNode(2)
let thirdNode = ListNode(3)
let fourthNode = ListNode(4)
let fivthNode = ListNode(5)
let sixthNode = ListNode(6)
let seventhNode = ListNode(7)
let eiththNode = ListNode(8)

head.next = secondNode
secondNode.next = thirdNode
thirdNode.next = fourthNode
fourthNode.next = fivthNode
fivthNode.next = sixthNode
sixthNode.next = seventhNode
seventhNode.next = eiththNode

var runnerNode1:ListNode? = head

if let result = Solution_swapPairs().swapPairs(head) {
    var runnerNode:ListNode? = result
    while runnerNode != nil {
        if let val = runnerNode?.val {
            print(val)
        }
        runnerNode = runnerNode?.next
    }
} else {
    print("nothing")
}
*/

/***********************************************************************************/

// adding two numbers without using decimal arithmatic operators
func add(x:Int, y:Int) -> Int {
    var sum = x
    var carry = y
    
    while carry != 0 {
        let tempCarry = sum & carry
        print("tempCarry: \(tempCarry)")
        
        sum = sum ^ carry
        print("Sum: \(sum)")
        
        carry = tempCarry << 1
        print("nextCarry: \(carry)")
        
        print(" ")
    }
    return sum
}

/*
var x = 12
var y = 4
print(add(x: x, y: y))
 */


//let x = 10
//let y = 3
//let res = x ^ y
//print(res)
//
//var carry = 2
//print(carry << 1)


/***********************************************************************************/

//class Solution {
//    func search(_ nums: [Int], _ target: Int) -> Int {
//
//        // first finding pivot
//
//        // do binary search in both arrays to find target
//
//    }
//}


class Solution_spiralOrder {
    
    enum IterateDirection {
        case RIGHT, DOWN, LEFT, UP
    }
    
    func getNextDirection(currDir:IterateDirection) -> IterateDirection {
        switch currDir {
        case .RIGHT:
            return .DOWN
        case .DOWN:
            return .LEFT
        case .LEFT:
            return .UP
        case .UP:
            return .RIGHT
        }
    }
    
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        
        guard matrix.count > 0 else {
            return []
        }
        
        guard matrix[0].count > 0 else {
            return []
        }

        var i = 0
        var j = 0
        
        var h_counter = 0
        var v_counter = 0
        
        var max_v_counter = matrix.count - 1
        var max_h_counter = matrix[0].count
        
        var dir:IterateDirection = .RIGHT
        
        var result:[Int] = []
        let totalCount = matrix.count * matrix[0].count
        while result.count != totalCount {
            
            result.append(matrix[i][j])

            if dir == .LEFT || dir == .RIGHT {
                h_counter = h_counter + 1
                if h_counter == max_h_counter {
                    max_h_counter = max_h_counter - 1
                    h_counter = 0
                    dir = self.getNextDirection(currDir: dir)
                }
                
            } else {
                v_counter = v_counter + 1
                if v_counter == max_v_counter {
                    max_v_counter = max_v_counter - 1
                    v_counter = 0
                    dir = self.getNextDirection(currDir: dir)
                }
            }
            
            switch dir {
            case .RIGHT:
                j = j + 1
            case .DOWN:
                i = i + 1
            case .LEFT:
                j = j - 1
            case .UP:
                i = i - 1
            }
        }
        return result
    }
}

/*
var input:[[Int]] = []
let emptyArr:[Int] = []
input.append(emptyArr)

var res = Solution_spiralOrder().spiralOrder(input)
print(res)
*/

/**********************************************************************************/

// https://leetcode.com/problems/permutation-sequence/

class Solution_getPermutation {
    func getPermutation(_ n: Int, _ k: Int) -> String {
        var input:[String] = []
        for i in 1...n {
            input.append("\(i)")
        }
        var counter = 0
        return self.permutate(input: input, fixedPivotIndex: 0, k: k, counter: &counter)
    }
    
    private func permutate(input:[String], fixedPivotIndex:Int, k:Int, counter:inout Int) -> String {
        
        if fixedPivotIndex == input.count {
            counter = counter + 1
        }
        
        if counter == k {
            return input.joined()
        }

        var lCounter = fixedPivotIndex
        while lCounter != input.count {
            
            var nextInput = input
            nextInput.swapAt(fixedPivotIndex, lCounter)
            
            let result = permutate(input: nextInput, fixedPivotIndex: fixedPivotIndex + 1, k: k, counter: &counter)
            if result != "" { return result }
            
            lCounter = lCounter + 1
        }
        
        return ""
    }
}

// let res = Solution_getPermutation().getPermutation(4, 9)
// print(res)

class Solution_rotateRight {
    func rotateRight(_ head: ListNode?, _ k: Int) -> ListNode? {
        
        if head == nil {
            return head
        }
        
        // find total count of the linked list
        var runnerNode = head
        var listCount = 0
        while runnerNode != nil {
            listCount = listCount + 1
            runnerNode = runnerNode?.next
        }
        
        var realRotationCount = k % listCount
        
        // if there is not rotation needed then return original head
        if realRotationCount == 0 {
            return head
        }
        
        // forward fast runner by realRotationCount
        var fastRunner = head
        while realRotationCount > 0 {
            fastRunner = fastRunner?.next
            realRotationCount = realRotationCount - 1
        }
        
        var slowRunner = head
        while fastRunner?.next != nil {
            fastRunner = fastRunner?.next
            slowRunner = slowRunner?.next
        }
        
        // now we got previous node as slowRunner and last node as fastRunner
        
        // lets do rotation and return the result
        let result = slowRunner?.next
        fastRunner?.next = head
        
        // now slowRunner next becomes last item whose next is set to nil
        slowRunner?.next = nil
        
        return result
    }
}

/*
let llInput = createLinkedListFromArray(arr: [1,2,3,4,5])
let result = Solution_rotateRight().rotateRight(nil, 0)
printLinkedList(head: result)
*/


class Solution1_sortColors {
    func sortColors(_ nums: inout [Int]) {
        var dict:[Int:Int] = [:]
        for item in nums {
            if let count = dict[item] {
                dict[item] = count + 1
            } else {
                dict[item] = 1
            }
        }
        
        var finalResult:[Int] = []
        
        let keys = Array(dict.keys.sorted())
        
        for key in keys {
            let arr = Array<Int>(repeating: key, count: dict[key] ?? 0)
            finalResult.append(contentsOf: arr)
        }
        
        nums = finalResult
    }
}
/*
var input = [2,0,2,1,1,0]
Solution1_sortColors().sortColors(&input)
print(input)
 */


class Solution2_sortColors {
    func sortColors(_ nums: inout [Int]) {
        var left = -1
        var right = nums.count
        
        var i = 0
        while i < nums.count {
            
            if nums[i] == 0 {
                // check if 0 is in wrong place
                if left + 1 < i {
                    // move all the zeros towards ending of array
                    let zero = nums.remove(at: i)
                    nums.insert(zero, at: 0)
                } else {
                    i = i + 1
                }
                left = left + 1
                continue
            }
            
            if nums[i] == 2 {
                // check if two is in wrong place
                if i + 1 < right {
                    // move all the twos towards ending of array
                    let two = nums.remove(at: i)
                    nums.append(two)
                } else {
                    i = i + 1
                }
                right = right - 1
                continue
            }
            
            i = i + 1
        }
    }
}

/*
var input = [2,0,0,1,2,1,2,0,2,2,1,2,1,2,0,2,1,1,0]
//var input = [2,1]
Solution2_sortColors().sortColors(&input)
print(input)
*/

class Solution_powerSet {
    // non recursive solution
    func subsets(_ nums: [Int]) -> [[Int]] {
        var result:[[Int]] = []
        result.append([])

        for item in nums {
            product(item: item, result: &result)
        }

        return result
    }
    
    private func product(item:Int, result: inout [[Int]]) {
        for items in result {
            var newItems = items
            newItems.append(item)
            result.append(newItems)
        }
    }
}

/*
let res = Solution_powerSet().subsets([6,2,3,4,5])
print(res.count)
 */

/***********************************************************************************/

class BSTNode {
    var key:Int
    var right:BSTNode?
    var left:BSTNode?
    
    var parent:BSTNode?
    
    init(key:Int) {
        self.key = key
    }
    
    func search(key:Int) -> BSTNode? {
        return inOrderSearch(node: self)
    }
    
    func inorderTraversal(node:BSTNode) {
        
        print(node.key)
        
        if node.right == nil && node.left == nil {
            //            print(node.key)
        } else {
            if let rightNode = node.left {
                inorderTraversal(node: rightNode)
            }
            
            if let leftNode = node.right {
                inorderTraversal(node: leftNode)
            }
        }
    }
    
    func inOrderSearch(node:BSTNode) -> BSTNode? {
        
        if node.right == nil && node.left == nil {
            return node
        } else {
            if let rightNode = node.right {
                inOrderSearch(node: rightNode)
            }
            
            print(node.key)
            
            if let leftNode = node.left {
                inOrderSearch(node: leftNode)
            }
        }
        return nil
    }
    
    func insert(key:Int){
        self.insert(key: key, into: self)
    }
    
    private func insert(key:Int, into parentNode:BSTNode) {
        if key < parentNode.key {
            if let leftNode = parentNode.left {
                self.insert(key: key, into: leftNode)
            } else {
                parentNode.left = BSTNode(key: key)
                parentNode.left?.parent = parentNode
            }
        } else {
            if let rightNode = parentNode.right {
                self.insert(key: key, into: rightNode)
            } else {
                parentNode.right = BSTNode(key: key)
                parentNode.right?.parent = parentNode
            }
        }
    }
    
    func sorted() -> [Int] {
        var result:[Int] = []
        self.inorderTraverse(node: self, result: &result)
        return result
    }
    
    private func inorderTraverse(node:BSTNode, result:inout [Int]){
        if let leftNode = node.left {
            inorderTraverse(node: leftNode, result: &result)
        }
    
        result.append(node.key)
        
        if let rightNode = node.right {
            inorderTraverse(node: rightNode, result: &result)
        }
    }
    
    func delete(key:Int) {
        self.delete(key: key, parentNode: self)
    }
    
    var isLeftChild:Bool {
        if let parentNode = self.parent, parentNode.left?.key == self.key {
            return true
        } else {
            return false
        }
    }
    
    var isRightChild:Bool {
        if let parentNode = self.parent, parentNode.right?.key == self.key {
            return true
        } else {
            return false
        }
    }
    
    private func delete(key:Int, parentNode:BSTNode) {
        if let node = self.find(key: key) {
            // no child
            if node.right == nil && node.left == nil {
                if node.isRightChild {
                    node.parent?.right = nil
                }
                
                if node.isLeftChild {
                    node.parent?.left = nil
                }
                return
            }
            
            // I have only right child
            if let rightNode = node.right, node.left == nil {
                if node.isRightChild {
                    node.parent?.right = rightNode
                }
                
                if node.isLeftChild {
                    node.parent?.left = rightNode
                }
                
                rightNode.parent = node.parent
                return
            }
            
            // I have only leftChild
            if let leftNode = node.left, node.right == nil {
                if node.isRightChild {
                    node.parent?.right = leftNode
                }
                
                if node.isLeftChild {
                    node.parent?.left = leftNode
                }
                
                leftNode.parent = node.parent
                return
            }
            
            // I have both left and right child
            // I need to fing minimun from my right subtree
            if let rightNode = node.right {
                let nextMaxNode = self.findMininimum(node: rightNode)
                self.delete(key: nextMaxNode.key)
                
                if node.isRightChild {
                    node.parent?.right = nextMaxNode
                }
                
                if node.isLeftChild {
                    node.parent?.left = nextMaxNode
                }
                
                nextMaxNode.right = node.right
                nextMaxNode.left = node.left
                nextMaxNode.parent = node.parent
                
                nextMaxNode.right?.parent = nextMaxNode
                nextMaxNode.left?.parent = nextMaxNode
                return
            }
        }
    }
    
    private func findMininimum(node:BSTNode) -> BSTNode {
        // go all they way to the left which is going to be minimum in this sub tree
        if let leftNode = node.left {
            return findMininimum(node: leftNode)
        }
        return node
    }
    
    func find(key:Int) -> BSTNode? {
        return self.find(key: key, node: self)
    }
    
    private func find(key:Int, node:BSTNode) -> BSTNode? {
        if key == node.key {
            return node
        } else if key < node.key {
            if let leftNode = node.left {
                return find(key: key, node: leftNode)
            }
        } else if key > node.key {
            if let rightNode = node.right {
                return find(key: key, node: rightNode)
            }
        }
        return nil
    }
}

/*
let root = BSTNode(key: 12)
root.insert(key: 5)
root.insert(key: 14)
root.insert(key: 3)
root.insert(key: 7)
root.insert(key: 13)
root.insert(key: 17)
root.insert(key: 20)
root.insert(key: 1)
root.insert(key: 9)
root.insert(key: 8)
root.insert(key: 11)

root.delete(key: 14)
root.delete(key: 5)
root.delete(key: 3)

let sorted = root.sorted()
print(sorted)
*/

/***********************************************************************************/

class Solution_reverseBetween {
    func reverseBetween(_ head: ListNode?, _ m: Int, _ n: Int) -> ListNode? {
        
        // no need to change if m is same as n
        if m == n {
            return head
        }
        
        var counter = 1
        var runnerNode = head
        
        while counter + 1 < m {
            runnerNode = runnerNode?.next
            counter = counter + 1
        }

        var prevMNode:ListNode?
        var prevNode:ListNode?
        if m == 1 {
            prevMNode = head
            prevNode = head
            runnerNode = head?.next
        } else {
            prevMNode = runnerNode
            prevNode = runnerNode?.next
            runnerNode = prevNode?.next
        }
        
        counter = m
        while counter < n {
            let temp = runnerNode
            
            runnerNode = runnerNode?.next
            
            temp?.next = prevNode
            
            prevNode = temp
            counter = counter + 1
        }
        
        if m == 1 {
            head?.next = runnerNode
            return prevNode
        }
        
        let temp = prevMNode?.next
        prevMNode?.next = prevNode
        temp?.next = runnerNode
        
        return head
    }
}

/*
let listInput = createLinkedListFromArray(arr: [1,2,3,4,5])
let res = Solution_reverseBetween().reverseBetween(listInput, 1, 3)
printLinkedList(head: res)
 */

/***********************************************************************************/

class Solution_inorderTraversal {
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        var results:[Int] = []
        guard let root = root else { return results }
        self.inorderTraversal(node: root, results: &results)
        return results
    }
    
    private func inorderTraversal(node:TreeNode, results:inout [Int]){
        if let leftNode = node.left {
            inorderTraversal(node: leftNode, results: &results)
        }
        
        results.append(node.val)
        
        if let rightNode = node.right {
            inorderTraversal(node: rightNode, results: &results)
        }
    }
}

/*
let tree = createBinaryTree(with: [1,2,3,4,5,6,7,8])
let result = Solution_inorderTraversal().inorderTraversal(tree)
print(result)
*/

/***********************************************************************************/

class Solution_merge {
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        
        if nums2.isEmpty {
            return
        }
        
        var i = 0
        var j = 0
        
        var didEndRealItemsInNums1 = false
        
        if m == 0 {
            didEndRealItemsInNums1 = true
        }
        
        while j < nums2.count {
            if didEndRealItemsInNums1 {
                // append all the remianing elements from nums2 into nums1
                nums1.insert(nums2[j], at: i)
                nums1.removeLast()
                i = i + 1
                j = j + 1
                continue
            }
            
            if i >= m + j {
                didEndRealItemsInNums1 = true
                continue
            }
            
            if nums1[i] >= nums2[j] {
                nums1.insert(nums2[j], at: i)
                nums1.removeLast()
                j = j + 1
            }
            i = i + 1
        }
    }
}


/*
//[2,0]
//1
//[1]
//10ta

//[4,0,0,0,0,0]
//1
//[1,2,3,5,6]
//5

//var nums1 = [1,2,3,0,0,0]
//var nums2:[Int] = [2,5,6]

var nums1 = [-12,0,0,0,0,0]
var nums2 = [-49,-45,-42,1,2,3]

Solution_merge().merge(&nums1, 1, nums2, nums2.count)
print(nums1)

*/

/***********************************************************************************/

class Solution_wordSearch {
    var visited:[[Bool]] = []
    func exist(_ board: [[Character]], _ word: String) -> Bool {
        
        guard let firstCh = word.first else {
            return true
        }
        
        guard board.count > 0 && board[0].count > 0 else {
            return false
        }
        
        self.initializeVisited(board: board)
        
        // iterate over to find first matching character and explore its all adjacent
        for i in 0..<board.count {
            for j in 0..<board[0].count {
                if board[i][j] == firstCh {
                    self.visited[i][j] = true
                    if exploreAdjacent(chPosition: 1, word: word, board: board, i: i, j: j) {
                        return true
                    }
                    self.initializeVisited(board: board)
                }
            }
        }
        
        return false
    }

    func initializeVisited(board:[[Character]]){
        self.visited = [[Bool]](repeating: Array<Bool>(repeating: false, count: board[0].count), count: board.count)
    }

    // explore all the adjacent of board[i][j] if not visited
    func exploreAdjacent(chPosition:Int, word:String, board:[[Character]], i:Int, j:Int) -> Bool {
        
        if chPosition == word.count {
            return true
        } else {
            let chIndex = word.index(word.startIndex, offsetBy: chPosition)
            let ch = word[chIndex]
            
            // explore top
            let topI = i - 1
            if topI >= 0 && self.visited[topI][j] == false && board[topI][j] == ch {
                self.visited[topI][j] = true
                if exploreAdjacent(chPosition: chPosition + 1, word: word, board: board, i: topI, j: j) {
                    return true
                }
            }
            
            // explore left
            let leftJ = j - 1
            if leftJ >= 0 && self.visited[i][leftJ] == false && board[i][leftJ] == ch {
                self.visited[i][leftJ] = true
                if exploreAdjacent(chPosition: chPosition + 1, word: word, board: board, i: i, j: leftJ) {
                    return true
                }
            }
            
            // esplore bottom
            let bottomI = i + 1
            if bottomI < board.count && self.visited[bottomI][j] == false && board[bottomI][j] == ch {
                self.visited[bottomI][j] = true
                if exploreAdjacent(chPosition: chPosition + 1, word: word, board: board, i: bottomI, j: j) {
                    return true
                }
            }
            
            // explore right
            let rightJ = j + 1
            if rightJ < board[0].count && self.visited[i][rightJ] == false && board[i][rightJ] == ch {
                self.visited[i][rightJ] = true
                if exploreAdjacent(chPosition: chPosition + 1, word: word, board: board, i: i, j: rightJ) {
                    return true
                }
            }
        }
        
        self.visited[i][j] = false
        
        return false
    }
}

/*
let board:[[Character]] =
[
    ["C","A","A"],
    ["A","A","A"],
    ["B","C","D"]
]
var word = "AAB"

let board1:[[Character]] = [["A","B","C","E"],["S","F","E","S"],["A","D","E","E"]]
let word1 = "ABCESEEEFS"

print(Solution_wordSearch().exist(board1, word1))
*/

/***********************************************************************************/

// folowing solution exceed time on Leetcode. So, there should be better way to solve this problem
class Solution_groupAnagrams {
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        
        var resultDict:[String:Set<String>] = [:]
        
        for str in strs {
            // check if the str already belongs to some group
            var hasGroup = false
            for item in resultDict {
                if areAnagrams(sortedKey: item.key, str: str) {
                    hasGroup = true
                    resultDict[item.key]?.insert(str)
                    break
                }
            }
            
            // if does not have group then create group and reference by sorted str as key
            if hasGroup == false {
                var newSet = Set<String>()
                newSet.insert(str)
                
                let newKey = String(str.sorted())
                resultDict[newKey] = newSet
            }
        }
        
        var result:[[String]] = []
        for item in resultDict.values {
            result.append(Array(item))
        }
        return result
    }
    
    private func areAnagrams(sortedKey:String, str:String) -> Bool {
        return sortedKey == String(str.sorted())
    }
}

/*
let input = ["eat", "tea", "tan", "ate", "nat", "bat"]
let res = Solution_groupAnagrams().groupAnagrams(input)
print(res)
*/

/***********************************************************************************/

// this below solution is breaking target into its candidates

class Solution_breakTarget {
    var cache:[Int:[[Int]]] = [:]
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        let res = self.combinationSum(candidates: candidates, target: target, tempResult: [])
        
        // removing duplicate solutions
        var newResult:[[Int]] = []
        for arr in res {
            var exist = false
            for newArr in newResult {
                if newArr.sorted() == arr.sorted() {
                    exist = true
                }
            }
            if exist == false {
                newResult.append(arr)
            }
        }
        return newResult
    }
    
    private func combinationSum(candidates:[Int], target:Int, tempResult:[Int]) -> [[Int]] {
        var result:[[Int]] = []

        if target == 0 {
            result.append(tempResult)
        } else {
            for num in candidates {
                if num <= target {
                    let newTarget = target - num
                    var newTempRes = tempResult
                    newTempRes.append(num)
                    let res = self.combinationSum(candidates: candidates, target: newTarget, tempResult: newTempRes)
                    self.cache[newTarget] = res
                    result.append(contentsOf: res)
                }
            }
        }
        
        return result
    }
}

//let input = [2,3,5]
//let target

//let result = Solution_breakTarget().combinationSum([2,3,5], 8)
//print(result)


// below solution is building up using candidates to make target
// caching works better in this solution
// LeetCode Accepted solution

class Solution_buildTarget {
    var cache:[Int:[[Int]]] = [:]
    
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        // removing duplicate solutions
        
        let result = self.getCombinationSum(candidates, target)
        
        var newResult:[[Int]] = []
        for arr in result {
            var exist = false
            for newArr in newResult {
                if newArr.sorted() == arr.sorted() {
                    exist = true
                }
            }
            if exist == false {
                newResult.append(arr)
            }
        }

        return newResult
    }
    
    private func getCombinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        var result:[[Int]] = []
        
        if let cacheResult = self.cache[target] {
            return cacheResult
        }

        if target == 0 {
            let emptyArr:[Int] = []
            result.append(emptyArr)
        } else {
            for num in candidates {
                if num <= target {
                    let newTarget = target - num
                    let tempResult = self.combinationSum(candidates, newTarget)
                    for soln in tempResult {
                        var newSoln = soln
                        newSoln.append(num)
                        result.append(newSoln)
                    }
                }
            }
        }

        self.cache[target] = result
        
        return result
    }
}

/*
let result = Solution_buildTarget().combinationSum([2,3,5], 8)
print(result)
*/

/***********************************************************************************/

class Solution_isSameTree {
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        
        if p == nil && q == nil {
            return true
        }
        
        if p == nil && q != nil {
            return false
        }
        
        if q == nil && p != nil {
            return false
        }
        
        if let pTree = p, let qTree = q, pTree.val != qTree.val {
            return false
        }
        
        return isSameTree(p?.left, q?.left) && isSameTree(p?.right, q?.right)
    }
}

/*
let pTree = createBinaryTree(with: [1,2,3])
let qTree = createBinaryTree(with: [1,2,3])

let result = Solution_isSameTree().isSameTree(pTree, qTree)
print(result)
*/

// wrong solution
class Solution1_isSameTree {
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        
        // Quque
        var queueP:[TreeNode?] = []
        queueP.append(p)
        
        // Queue
        var queueQ:[TreeNode?] = []
        queueQ.append(q)
        
        while queueP.count > 0 && queueQ.count > 0 {
            
            let node_p = queueP.removeFirst()
            let node_q = queueQ.removeFirst()
            
            if node_p?.val != node_q?.val {
                return false
            } else {
                // append from p
                queueP.append(node_p?.left)
                queueP.append(node_p?.right)
                queueQ.append(node_q?.left)
                queueQ.append(node_q?.right)
            }
        }
        
        if queueP.count == queueQ.count && queueP.count == 0 {
            return true
        } else {
            return false
        }
    }
}

// 121. Best Time to Buy and Sell Stock

class Solution_maxProfit {
    func maxProfit(_ prices: [Int]) -> Int {
        
        guard prices.count > 1 else {
            return 0
        }
        
        var minPrice = Int.max
        
        var maxProfit = 0
        
        for price in prices {
            if price < minPrice {
                minPrice = price
            } else {
                let profit = price - minPrice
                if profit > maxProfit {
                    maxProfit = profit
                }
            }
        }
        
        return maxProfit
    }
}

/*
print(Solution_maxProfit().maxProfit([1,2]))
*/

/***********************************************************************************/

// 98. Validate Binary Search Tree

/* wrong solution */

/*
class Solution {
    
    enum BSTNodeChildType {
        case LEFT, RIGHT, NONE
    }
    
    func isValidBST(_ root: TreeNode?) -> Bool {
        return isValidBST(root, childType: .NONE,  parent: nil)
    }
    
    func isValidBST(_ root: TreeNode?, childType:BSTNodeChildType, parent:TreeNode?) -> Bool {
        
        guard let root = root else {
            return true
        }
        
        if let leftChild = root.left {
            if leftChild.val >= root.val {
                return false
            }
            
            if childType == .RIGHT {
                if let parent = parent, leftChild.val < parent.val {
                    return false
                }
            }
        }
        
        if let rightChild = root.right {
            if rightChild.val <= root.val {
                return false
            }
            
            if childType == .LEFT {
                if let parent = parent, rightChild.val > parent.val {
                    return false
                }
            }
        }
        
        return isValidBST(root.left, childType: .LEFT, parent: root) && isValidBST(root.right, childType: .RIGHT, parent: root)
    }
}
*/

class Solution_isValidBST {
    func isValidBST(_ root: TreeNode?) -> Bool {
        return isValidBST(root, l: Int.min,  u: Int.max)
    }
    
    func isValidBST(_ root: TreeNode?, l:Int, u:Int) -> Bool {
        guard let root = root else { return true }
        
        if root.val <= l || root.val >= u {
            return false
        }
        
        return isValidBST(root.left, l: l, u: root.val) && isValidBST(root.right, l: root.val, u: u)
    }
}

/*
let bst1 = createBinaryTree(with: [2,1,3])
let bst2 = createBinaryTree(with: [5,1,4,nil,nil,3,6])
let bst3 =  createBinaryTree(with: [1,nil,1])
let bst4 = createBinaryTree(with: [10,5,15,nil,nil,6,20])

// true
let bst5 = createBinaryTree(with: [3,1,5,0,2,4,6])

// false
let bst6 = createBinaryTree(with: [3,1,5,0,2,4,6,nil,nil,nil,3])

print(Solution_isValidBST().isValidBST(bst4))
*/

// not efficient solution O(n2)
class Solution1_countPrimes {
    var primes:[Int] = []
    func countPrimes(_ n: Int) -> Int {
        
        var counter = 2
        
        while counter < n {
            if self.checkIfPrimes(number: counter) {
                self.primes.append(counter)
            }
            
            counter = counter + 1
        }
        
        return self.primes.count
    }
    
    private func checkIfPrimes(number:Int) -> Bool {
        for prime in self.primes {
            if number % prime == 0 {
                return false
            }
        }
        return true
    }
}

class Solution_countPrimes {
    func countPrimes(_ n: Int) -> Int {
        
        var primes:[Bool] = [Bool](repeating: true, count: n)

        var index = 2
        
        while index <= primes.count/2 {
            if primes[index] {
                self.markMultiplesAsNonPrime(for: index, primes: &primes)
            }
            
            index = index + 1
        }
        
        // now calculate all the true primes
        index = 2
        var primeCounter = 0
        while index < primes.count {
            if primes[index] {
                primeCounter = primeCounter + 1
            }
            index = index + 1
        }
        return primeCounter
    }
    
    private func markMultiplesAsNonPrime(for prime:Int, primes:inout [Bool]) {
        var index = 2
        while prime*index < primes.count {
            primes[prime*index] = false
            index = index + 1
        }
    }
}

/*
print(Solution_countPrimes().countPrimes(5))
 */

/***********************************************************************************/

class Solution_reverseList {
    func reverseList(_ head: ListNode?) -> ListNode? {
        if head == nil || head?.next == nil {
            return head
        }
        
        var prevNode = head
        var currNode = head?.next
        
        // remember this is very important, otherwise it will go to infinite loop
        head?.next = nil
        
        while currNode != nil {
            let temp = currNode?.next
            currNode?.next = prevNode
            prevNode = currNode
            currNode = temp
        }
        
        return prevNode
    }
}

//1->2->3->4->5->NULL
/*
let inputLinkedList = createLinkedListFromArray(arr: [1,2,3,4,5,6])
let ll = Solution_reverseList().reverseList(inputLinkedList)
printLinkedList(head: ll)
*/


// Below solution is O(n) time and O(1) space
// this could also be done storing all the items into array and performing palindrome check
class Solution_isPalindrome1 {
    func isPalindrome(_ head: ListNode?) -> Bool {
        
        if head == nil || head?.next == nil {
            return true
        }
        
        var runnerNode = head
        var count = 0
        
        while runnerNode != nil {
            runnerNode = runnerNode?.next
            count = count + 1
        }
        
        runnerNode = head
        var previousNode:ListNode? = nil
        
        var index = 1
        
        while index <= count/2 {
            let temp = runnerNode?.next
            runnerNode?.next = previousNode
            
            previousNode = runnerNode
            runnerNode = temp
            index = index + 1
        }
        
        var revList = previousNode
        var forwardList = count % 2 == 0 ? runnerNode : runnerNode?.next
        
        while revList != nil || forwardList != nil {
            
            if revList?.val != forwardList?.val {
                return false
            }
            
            revList = revList?.next
            forwardList = forwardList?.next
        }
        
        return revList == nil && forwardList == nil
    }
}

// print(Solution_isPalindrome1().isPalindrome(createLinkedListFromArray(arr: [1,1])))


