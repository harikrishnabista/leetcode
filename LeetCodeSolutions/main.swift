//
//  main.swift
//  LeetCodeSolutions
//
//  Created by Hari Bista on 10/5/19.
//  Copyright © 2019 Bista. All rights reserved.
//

import Foundation

class Solution_toRoman_old {
    func toRoman(number: Int) -> String {
        
        let conversions = ArabicRomanConversion.conversions
        
        var romanValue = ""
        var remaining = number
        
        for conversion in conversions {
            
            let quotient = remaining / conversion.arabic
            
            if quotient > 0 {
                for _ in 0..<quotient {
                    romanValue += conversion.roman
                }
                remaining -= conversion.arabic * quotient
            }
        }
        
        return romanValue
    }
}

/*
 print(Solution_toRoman_old().toRoman(number: 950) == "CML")
 print(Solution_toRoman_old().toRoman(number: 857) == "DCCCLVII")
 */

public func maximumGain(_ A : inout [Int]) -> Int {
    
    var sum = 0
    
    if A[0] < A[1] {
        // buy
        sum = sum - A[0]
    }
    
    if A[0] > A[1] {
        // sell
        sum = sum + A[0]
    }
    
    for (i,price) in A.enumerated() {
        
        // don't worry about 1st and last item
        if i == 0 || i == A.count - 1 {
            continue
        }
        
        if A[i-1] > A[i] && A[i] < A[i+1] {
            // low point
            sum = sum - A[i]
        }
        
        if A[i-1] < A[i] && A[i] > A[i+1] {
            // high point
            sum = sum + A[i]
        }
    }
    
    let lastIndex = A.count - 1
    
    if A[lastIndex] > A[lastIndex-1] {
        sum = sum + A[lastIndex]
    }
    
    return sum
    
}

// ["flower","flow","flight"]
class Solution_longestCommonPrefix {
    func longestCommonPrefix(_ strs: [String]) -> String {
        
        guard strs.count > 0 else { return "" }
        
        var commonPrefix = strs[0]
        
        for str in strs {
            
            if str == "" {
                commonPrefix = ""
                break
            }
            
            commonPrefix = getCommonPrefix(str1: commonPrefix, str2: str)
            
            if commonPrefix == "" {
                break
            }
            
        }
        
        return commonPrefix
    }
    
    func getCommonPrefix(str1: String, str2: String) -> String {
        
        let charArrStr1 = Array(str1)
        let charArrStr2 = Array(str2)
        
        let minCount = min(charArrStr1.count, charArrStr2.count)
        
        var charArrResult: [Character] = []
        
        for i in 0...(minCount - 1) {
            if charArrStr1[i] == charArrStr2[i] {
                charArrResult.append(charArrStr1[i])
            } else {
                break
            }
        }
        
        return String(charArrResult)
    }
}

class Solution_searchInsert {
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        
        if target > nums[nums.count - 1] {
            return nums.count
        }
        
        if target < nums[0] {
            return 0
        }
        
        var l = 0
        var u = nums.count - 1
        
        var m = 0
        
        while l <= u {
            
            m = (l+u)/2
            
            if nums[m] == target {
                return m
            }
            
            if nums[m] < target {
                l = m + 1
            }
            
            if target < nums[m] {
                u = m - 1
            }
            
        }
        
        return u+1
    }
}

class Solution_lengthOfLastWord {
    func lengthOfLastWord(_ s: String) -> Int {
        
        let trimmedS = s.trimmingCharacters(in: .whitespaces)
        
        let charArr = Array(trimmedS)
        
        var i = charArr.count - 1
        
        var count = 0
        while i >= 0 {
            if charArr[i] != " " {
                count = count + 1
            } else {
                break
            }
            
            i = i - 1
        }
        
        return count
    }
}

//print(Solution_lengthOfLastWord().lengthOfLastWord("luffy is still joyboy"))
//print(Solution_lengthOfLastWord().lengthOfLastWord("   fly me   to   the moon  "))
//print(Solution_lengthOfLastWord().lengthOfLastWord("Hello World"))

class Solution_FirstOccurance {
    func strStr(_ haystack: String, _ needle: String) -> Int {
        
        guard haystack.count >= needle.count else { return -1 }
        
        let charArrHaystack = Array(haystack)
        let charArrNeedle = Array(needle)
        
        for (i, _) in charArrHaystack.enumerated() {
            
            if i > charArrHaystack.count - charArrNeedle.count {
                return -1
            }
            
            if isNeedleMatch(
                charArrHaystack: charArrHaystack,
                currentIndex: i,
                charArrNeedle: charArrNeedle
            ) {
                return i
            }
            
        }
        
        return -1
    }
    
    func isNeedleMatch(
        charArrHaystack: [Character],
        currentIndex: Int,
        charArrNeedle: [Character]
    ) -> Bool {
        var i = currentIndex
        for ch in charArrNeedle {
            if ch != charArrHaystack[i] {
                return false
            }
            i = i + 1
        }
        
        return true
    }
}

// print(Solution_FirstOccurance().strStr("a", "a"))

/***********************************************************************************/

class Solution_moveZeros {
    // with using swap
    func moveZeroes(_ arr: inout [Int]) {
        
        var lastZeroIndex = -1
        
        for (i,item) in arr.enumerated() {
            if item != 0 {
                if lastZeroIndex > -1 {
                    arr.swapAt(i, lastZeroIndex)
                    lastZeroIndex = lastZeroIndex + 1
                }
            } else {
                if lastZeroIndex == -1 {
                    lastZeroIndex = i
                }
            }
        }
    }
    
    /*
     // test code
     
     var input1:[Any] = [ 4, 1, 3, 2, "X", "Y", "Z", 0, 1, 3, 4 ]
     let result = moveNonZeroToFront_2(inputArr: &input1)
     print(result)
     
     */
    
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
    
    func moveZerosToEnd(nums:inout [Int]) {
        
        var i = 0
        for (index,num) in nums.enumerated() {
            if num != 0 {
                nums[i] = num
                
                if index != i {
                    nums[index] = 0
                }
                
                i = i + 1
            }
        }
    }
    
    /*
     var input = [1, 10, 2, 8, 3, 6, 0, 0, 0, 4, 0, 5, 7, 0]
     moveZerosToEnd(nums:&input)
     */
    
    /*
     var input2 = [1, 10, 0, 0, 0, 2, 8, 3, 0, 0, 6, 4, 0, 5, 7, 0]
     Solution_moveZeros().moveZeroes(&input2)
     print(input2)
     */
}

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

class Solution_longestCommonPrefix2 {
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
//print(Solution_longestCommonPrefix2().longestCommonPrefix(input))

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

// 43. Multiply Strings

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

class Permutation {
    func permutate(str:String) -> [String] {
        return permuteMe(str: str, startIndex: 0)
    }
    
    func permuteMe(str: String,startIndex:Int) -> [String] {
        var result:[String] = []
        
        if startIndex == str.count {
            result.append(str)
        } else {
            for i in startIndex..<str.count {
                var tempStrChars = Array(str)
                tempStrChars.swapAt(i, startIndex)
                result.append(contentsOf: permuteMe(str: String(tempStrChars), startIndex: startIndex + 1))
            }
        }
        return result
    }
}

// print(Permutation().permutate(str: "ABCDE"))

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

class Solution_lengthOfLastWord1 {
    func lengthOfLastWord(_ s: String) -> Int {
        let arr = s.split(separator: " ")
        
        if arr.count > 0 {
            return arr[arr.count-1].count
        }
        
        return 0
    }
}

/*
 let res = Solution_lengthOfLastWord1().lengthOfLastWord("")
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


//func permutate(input:String) -> [String] {
//
//    func swapCharacters(input: String, index1: Int, index2: Int) -> String {
//        var characters = Array(input)
//        characters.swapAt(index1, index2)
//        return String(characters)
//    }
//
//    func permuteMe(input: String, pivotIndex:Int) -> [String] {
//        var result:[String] = []
//
//        if pivotIndex == (input.count - 1) {
//            result.append(input)
//        } else {
//            for i in pivotIndex...(input.count - 1) {
//                let nextInput = swapCharacters(input: input, index1: pivotIndex, index2: i)
//                result.append(contentsOf: permuteMe(input: nextInput, pivotIndex: pivotIndex + 1))
//            }
//        }
//        return result
//    }
//
//    let result = permuteMe(input: input, pivotIndex: 0)
//    return result
//}

class Solution1_isAnagram {
    
    private func swapCharacters(input: String, index1: Int, index2: Int) -> String {
        var characters = Array(input)
        characters.swapAt(index1, index2)
        return String(characters)
    }
    
    private func isAnagram(s: String, pivotIndex:Int, t:String) -> Bool {
        if pivotIndex == (s.count - 1) {
            return true
        } else {
            for i in pivotIndex...(s.count - 1) {
                let nextInput = swapCharacters(input: s, index1: pivotIndex, index2: i)
                return isAnagram(s: nextInput, pivotIndex: pivotIndex + 1, t: t)
            }
        }
        return false
    }
    
    func isAnagram(_ s: String, _ t: String) -> Bool {
        return self.isAnagram(s: s, pivotIndex: 0, t: t)
    }
}

//print(Solution1_isAnagram().isAnagram("hari", "abcd"))


//let sIndex = input.index(input.startIndex, offsetBy: start)
//let newStr = String(input[..<sIndex])


// amazon interview
/*
 func topNCompetitors(numCompetitors:Int,topNCompetitors:Int,
 competitors:[String], numReviews:Int,
 reviews:[String])->[String]{
 var dict:[String:Int] = [:]
 
 for competitor in competitors {
 dict[competitor] = getCount(competitor: competitor, reviews: reviews)
 }
 
 // now sort the dictionary and get top n competitors
 let topCompetitors = dict.sorted { $0.1 > $1.1 }
 
 var result:[String] = []
 
 var count = 0
 for competitor in topCompetitors {
 if count < topNCompetitors {
 result.append(competitor.key)
 count = count + 1
 }
 }
 
 return result
 }
 
 func getCount(competitor:String, reviews:[String]) -> Int {
 var count = 0
 for review in reviews {
 if review.contains(competitor) {
 count = count + 1
 }
 }
 
 return count
 }
 */

/***********************************************************************************/

/* post matest interview */

func missingNumber(arr: [Int]) -> Int {
    var referenceArr:[Bool] = [Bool](repeating:false, count:arr.count + 1)
    
    for label in arr {
        referenceArr[label] = true
    }
    
    for (i,isExists) in referenceArr.enumerated() {
        if isExists == false {
            return i
        }
    }
    
    return 0
}

//let input = [3, 1, 0]
//print(missingNumber(arr: input))

func fizzBuzz(n: Int) -> [String] {
    
    var result:[String] = []
    for i in 1...n {
        if i % 3 == 0 && i % 5 == 0 {
            result.append("FizzBuzz")
        } else if i % 3 == 0 {
            result.append("Fizz")
        } else if i % 5 == 0 {
            result.append("Buzz")
        } else {
            result.append("\(i)")
        }
    }
    
    return result
}

/***********************************************************************************/

// pair programming interview at Square

/*
 
 let blocks = ["red": 2, "blue": 4]
 
 let pattern = ["red", "blue", "red", "blue"]
 
 let pattern2 = ["red", "red"]
 
 let invalid_pattern = ["red", "blue", "red", "red"]
 
 let invalid_pattern2 = ["green"]
 
 patternDict = ["red": 2, "blue": 2]
 
 */

func isValidPattern(pattern:[String], blocks:[String:Int]) -> Bool {
    
    var blocksModified = blocks
    
    // 1. convert the pattern into dictionary
    var patternDict:[String:Int] = [:]
    
    for color in pattern {
        
        if let val = patternDict[color] {
            patternDict[color] = val + 1
        } else {
            patternDict[color] = 1
        }
    }
    
    // 2. compare the blocks can hold pattern
    for item in patternDict {
        
        // if patternDict contains a key which is not present in blocks then return false
        if blocksModified[item.key] == nil {
            
            // for the wild card, check it has wild card it sufficient wild card then decrease it and continue
            
            if let wildVal = blocksModified["wild"], wildVal > 0 {
                blocksModified["wild"] = wildVal - 1
                continue
            }
            
            return false
        }
        
        // if patten dict needs more color count than actually present inside the blocks then return false
        if let val = blocksModified[item.key], item.value > val {
            // let requiredWilds = item.value - val
            // print("Short \(item.value - val) blocks of color \(item.key)")
            // if let val = blocksModified["wild"], val >= requiredWilds {
            //   blocksModified["wild"] = val - requiredWilds
            //   continue
            // }
            
            let requiredWilds = item.value - val
            
            if let wildVal = blocksModified["wild"], val > 0 {
                blocksModified["wild"] = wildVal - 1
                patternDict[item.key] = item.value - 1
                continue
            }
            
            return false
        }
        
    }
    
    return true
}

/*
 let blocks = ["red": 1, "wild": 2]
 
 let pattern:[String] = ["red", "red", "red", "red"] // true -> ["red", "wild", "wild"]
 
 // patternDict = ["red":4]
 
 print(isValidPattern(pattern: pattern, blocks: blocks))
 */


/***********************************************************************************/

// folowing solution exceed time on Leetcode. So, there should be better way to solve this problem
class Solution1_groupAnagrams {
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



// accepted solution
class Solution_groupAnagrams {
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var resultDict:[String:[String]] = [:]
        
        for str in strs {
            let key = String(str.sorted())
            if resultDict[key] != nil {
                resultDict[key]?.append(str)
            } else {
                var arr:[String] = []
                arr.append(str)
                resultDict[key] = arr
            }
        }
        return Array(resultDict.values)
    }
}

/*
 let input = ["eat", "tea", "tan", "ate", "nat", "bat"]
 let res = Solution_groupAnagrams().groupAnagrams(input)
 print(res)
 */


/***********************************************************************************/

// 1051. Height Checker

class Solution_heightChecker {
    func heightChecker(_ heights: [Int]) -> Int {
        
        // prepare sortedHeights using counting sort as there will be only 100 different heights
        var heightFreqs: [Int] = [Int](repeating: 0, count: 101)
        
        // calculate frequencies of height
        for height in heights {
            heightFreqs[height] = heightFreqs[height] + 1
        }
        
        var counter = 0
        var countResult = 0
        
        // this is used to check if sorted values are same or not in same index
        var index = 0
        
        while counter <= 100 {
            if heightFreqs[counter] > 0 {
                heightFreqs[counter] = heightFreqs[counter] - 1
                
                if index < heights.count, counter != heights[index] {
                    countResult = countResult + 1
                }
                
                index = index + 1
                
            } else {
                counter = counter + 1
            }
        }
        
        return countResult
    }
}

/*
 let heights1 = [1,1,4,2,1,3]
 let heights2 = [2,1,2,1,1,2,2,1]
 let res = Solution_heightChecker().heightChecker(heights2)
 print(res)
 */

/***********************************************************************************/

class Solution_numUniqueEmails {
    func numUniqueEmails(_ emails: [String]) -> Int {
        
        var uniqueEmails = Set<String>()
        
        for email in emails {
            // having @ is guarenteed
            let arr = email.split(separator: "@")
            var local  = arr[0]
            let rest = arr[arr.count - 1]
            
            let arrLocal = local.split(separator: "+")
            
            if arrLocal.count > 0 {
                local = arrLocal[0]
            }
            
            let localStr = local.replacingOccurrences(of: ".", with: "")
            
            let resEmail = localStr + "@" + rest
            uniqueEmails.insert(resEmail)
            print(resEmail)
        }
        
        return uniqueEmails.count
    }
}


/*
 let input = ["test.email+alex@leetcode.com","test.e.mail+bob.cathy@leetcode.com","testemail+david@lee.tcode.com"]
 let res = Solution_numUniqueEmails().numUniqueEmails(input)
 print(res)
 */

/***********************************************************************************/

class Polynomial {
    class Term {
        var coefficient:Double
        var degree:Int
        
        init(coefficient:Double, degree:Int) {
            self.coefficient = coefficient
            self.degree = degree
        }
    }
    
    var terms:[Term]
    
    init(terms:[Term]) {
        self.terms = terms
    }
    
    func derivative(){
        var newTerms:[Term] = []
        
        for term in self.terms {
            let coeff = term.coefficient * Double(term.degree)
            let degree = term.degree - 1
            
            let term = Term(coefficient: coeff, degree: degree)
            newTerms.append(term)
        }
        self.terms = newTerms
    }
}

/***********************************************************************************/

class Solution_sortArrayByParityII {
    func sortArrayByParityII(_ A: [Int]) -> [Int] {
        
        var oddArray:[Int] = []
        var evenArray:[Int] = []
        
        for item in A {
            if item % 2 == 0 {
                evenArray.append(item)
            } else {
                oddArray.append(item)
            }
        }
        
        var result:[Int] = []
        for i in 0...A.count-1 {
            if i % 2 == 0 {
                result.append(evenArray.removeLast())
            } else {
                result.append(oddArray.removeLast())
            }
        }
        return result
    }
}

// print(Solution_sortArrayByParityII().sortArrayByParityII([4,2,5,7]))

/***********************************************************************************/


class Solution_fib {
    func fib(_ N: Int) -> Int {
        
        guard N > 1 else {
            return N
        }
        
        var first = 0
        var second = 1
        
        var counter = 2
        
        while counter <= N {
            let temp = second
            second = first + second
            first = temp
            
            counter = counter + 1
        }
        
        return second
    }
}

// print(Solution_fib().fib(6))

/***********************************************************************************/

/* Postmates question */

// other technical questions
// 1. what is retain cycle and can you explain one example when retain cycle can happen ?
// 2. what are difference between NSOperation vs GCD ? when do you choose one vs another
// 3. what is StringProtocol ?
// 4. what is difference between UIView and CALayer ?
// 5. When do you use KVO, NSNotification and Delegate
// 6. What is clossure ? What is difference between delegate pattern and clossure ?

class Solution_removeInvalidParentheses {
    
    struct StackItemTuple {
        let char:Character
        let index:Int
    }
    
    func removeInvalidParentheses(_ s: String) -> String {
        var result = ""
        
        var stack:[StackItemTuple] = []
        
        for (i,ch) in s.enumerated() {
            if ch == "(" {
                let tuple = StackItemTuple(char: ch, index: i)
                stack.append(tuple)
            } else if ch == ")" {
                
                var hasOpenParenthesis = false
                if stack.count > 0 {
                    let lastTuple = stack.removeLast()
                    hasOpenParenthesis = lastTuple.char == "("
                }
                
                if !hasOpenParenthesis {
                    continue
                }
            }
            
            result.append(ch)
        }
        
        if stack.count > 0 {
            // now result does not include unbalanced close parenthesis but it can have some unbalanced open parenthesis
            while stack.isEmpty == false {
                let tuple = stack.removeLast()
                let toRemoveIndex = result.index(result.startIndex, offsetBy: tuple.index)
                result.remove(at: toRemoveIndex)
            }
        }
        
        return result
    }
}

/*
 let input = "(abcd)()hari(ha()))))))"
 let res = Solution_removeInvalidParentheses().removeInvalidParentheses(input)
 print(res)
 */


/***********************************************************************************/

// 542. 01 Matrix

class Solution_updateMatrix {
    
    var result:[[Int]] = []
    
    func updateMatrix(_ matrix: [[Int]]) -> [[Int]] {
        for i in 0..<matrix.count {
            for j in 0..<matrix[0].count {
                
            }
        }
        
        return result
    }
    
    struct Cell {
        var i:Int
        var j:Int
    }
    
    func updateDistanceToNearestZero(cell:Cell, matrix: [[Int]]) {
        
        var queue:[Cell] = []
        
        queue.append(cell)
        
        var distance = 1
        while queue.isEmpty == false {
            
            let cCell = queue.removeFirst()
            
            if matrix[cCell.i][cCell.j] == 0 {
                return
            }
            
            // explore top
            var found = false
            if cCell.i - 1 > 0, matrix[cCell.i - 1][cCell.j] == 0 {
                found = true
                
            } else {
                //                // update result matrix
                //                self.result[][]
                //
                //                let topCell = Cell(i: cell.i, j: cell.j)
            }
            
            // left
            if cCell.j - 1 > 0, matrix[cCell.i][cCell.j - 1] == 0 {
                found = true
            } else {
                
            }
            
            // right
            if cCell.j + 1 < matrix[0].count, matrix[cCell.i][cCell.j + 1] == 0 {
                found = true
            } else {
                
            }
            
            // bottom
            if cCell.i + 1 < matrix.count, matrix[cCell.i + 1][cCell.j] == 0 {
                found = true
            }
            
            //            if found == false
            
        }
        
    }
}

/***********************************************************************************/

// 1108. Defanging an IP Address
class Solution_defangIPaddr {
    func defangIPaddr(_ address: String) -> String {
        var result = ""
        
        for ch in address {
            if ch == "." {
                result.append("[.]")
            } else {
                result.append(ch)
            }
        }
        return result
    }
}

/*
 let res = Solution_defangIPaddr().defangIPaddr("1.1.1.1")
 print(res)
 */

/***********************************************************************************/

// 771. Jewels and Stones

class Solution_numJewelsInStones {
    func numJewelsInStones(_ J: String, _ S: String) -> Int {
        var resultCount = 0
        for stone in S {
            if J.contains(stone) {
                resultCount = resultCount + 1
            }
        }
        
        return resultCount
    }
}


//let J = "z", S = "ZZ"
//let J = "aA", S = "aAAbbbb"
//print(Solution_numJewelsInStones().numJewelsInStones(J, S))


/***********************************************************************************/

class Solution_rangeSumBST {
    func rangeSumBST(_ root: TreeNode?, _ L: Int, _ R: Int) -> Int {
        return self.rangeSum(node: root, min: Int.min, max: Int.max, L: L, R: R)
    }
    
    func rangeSum(node:TreeNode?, min:Int, max:Int, L:Int, R:Int) -> Int {
        
        guard let node = node else { return 0 }
        
        if max < L || min > R {
            return 0
        }
        
        var currVal = node.val
        if (currVal >= L && currVal <= R) == false {
            currVal = 0
        }
        
        return currVal + rangeSum(node: node.left, min: min, max: node.val - 1, L: L, R: R) + rangeSum(node: node.right, min: node.val - 1, max: max, L: L, R: R)
    }
}

/*
 let bst = createBinaryTree(with: [10,5,15,3,7,nil,18])
 print(Solution_rangeSumBST().rangeSumBST(bst, 7, 15))
 */


/* Apple coding interview
 
 // This is a calculation function that accepts an NSNumber as input, and
 // returns number * 2 as output. To simulate a lengthy calculation, the
 // function blocks for a random time interval from 1 - 5 seconds.
 
 func PerformSlowCalculation(_ i : Int, val:Int, result:inout [Int]) {
 let timesTwo = val * 2
 let pause = arc4random_uniform(4) + 1
 sleep(pause)
 result[i] = timesTwo
 }
 
 // Perform a calculation on each element of the input array of numbers,
 // returning an array of the results in the same order as the
 // corresponding input array number.
 
 
 
 func ArrayCalculation(_ a : [Int]) -> [Int]
 {
 // Task: replace this function body with code that performs the
 // calculation method over the input array a concurrently using
 // Cocoa concurrency API's: Grand Central Dispatch, NSOperationQueue,
 // POSIX pthread, whatever.
 
 // Replace this single-threaded implementation
 
 let queue = DispatchQueue(label: "com.example.queue", attributes: .concurrent)
 
 var result:[Int] = [Int](repeating:0, count:a.count)
 
 var workItems:[DispatchWorkItem] = []
 
 for (i,val) in a.enumerated() {
 let workItem = DispatchWorkItem(block: {
 PerformSlowCalculation(i, val:val, result: &result)
 })
 
 workItems.append(workItem)
 queue.async(execute: workItem)
 }
 
 for workitem in workItems {
 workitem.wait()
 }
 
 return result
 }
 
 let inputArray = [ 2, 4, 6, 8 ]
 print("inputArray = \(inputArray)")
 
 let start = NSDate()
 let outputArray = ArrayCalculation(inputArray)
 let duration = -start.timeIntervalSinceNow
 print("outputArray = \(outputArray)")
 if outputArray == [ 4, 8, 12, 16] {
 print("outputArray is correct")
 } else {
 print("outputArray is incorrect")
 }
 
 print("duration = \(duration)")
 
 
 */


/***********************************************************************************/

// Verily life science coding challenge

/*
 // Coins: [25, 10, 5, 1]
 //
 // I need 31. What is the minimum number of coins required to get to 31?
 
 func minimumNumberOfCoins(_ coins: [Int], _ cents: Int) -> Int {
 
 var resultCount = 0
 let sortedCoins = coins.sorted(by: >)
 
 var sum = cents
 for coin in sortedCoins {
 while sum >= coin {
 sum = sum - coin
 resultCount = resultCount + 1
 }
 }
 
 if sum == 0 {
 return resultCount
 } else {
 return 0
 }
 }
 
 // 31-25 = 6, 6-5 = 1
 
 func main() {
 let coins:[Int] = [25, 10, 1]
 let cents = 31
 let min = minimumNumberOfCoins(coins, cents)
 print("Number of coins: \(min)")
 }
 
 main()
 
 */


// 1221. Split a String in Balanced Strings

class Solution_balancedStringSplit {
    func balancedStringSplit(_ s: String) -> Int {
        var lCounter = 0
        var rCounter = 0
        
        var resCount = 0
        
        for ch in s {
            if ch == "R" {
                rCounter += 1
            }
            
            if ch == "L" {
                lCounter += 1
            }
            
            if lCounter == rCounter {
                resCount += 1
                rCounter = 0
                lCounter = 0
            }
        }
        return resCount
    }
}

/*
 let input = "RLRRRLLRLL"
 print(Solution_balancedStringSplit().balancedStringSplit(input))
 */

/***********************************************************************************/

class Solution_toLowerCase {
    func toLowerCase(_ str: String) -> String {
        return str.lowercased()
    }
}

/***********************************************************************************/

// 1021. Remove Outermost Parenthese
class Solution_removeOuterParentheses {
    func removeOuterParentheses(_ S: String) -> String {
        
        var balanceCounter = 0
        
        var result = ""
        var tempResult = ""
        for ch in S {
            
            tempResult.append(ch)
            
            if ch == "(" {
                balanceCounter += 1
            }
            
            if ch == ")" {
                balanceCounter -= 1
            }
            
            if balanceCounter == 0 {
                tempResult.removeFirst()
                tempResult.removeLast()
                result.append(tempResult)
                tempResult = ""
            }
        }
        
        return result
    }
}

/*
 let input = "(()())(())"
 print(Solution().removeOuterParentheses(input))
 */

/***********************************************************************************/

// 561. Array Partition I

class Solution_arrayPairSum {
    func arrayPairSum(_ nums: [Int]) -> Int {
        let sorted = nums.sorted()
        var i = 0
        var sum = 0
        while i <= sorted.count - 1 {
            sum = sum + min(sorted[i], sorted[i+1])
            i = i + 2
        }
        return sum
    }
}

/*
 let input = [1,4,3,2]
 print(Solution().arrayPairSum(input))
 */

/***********************************************************************************/

// 965. Univalued Binary Tree

class Solution_isUnivalTree {
    func isUnivalTree(_ root: TreeNode?) -> Bool {
        
        guard let value = root?.val else {
            return true
        }
        
        if let leftChild = root?.left, value != leftChild.val {
            return false
        }
        
        if let rightCHild = root?.right, value != rightCHild.val {
            return false
        }
        
        return isUnivalTree(root?.left) && isUnivalTree(root?.right)
    }
}

/*
 //let input = [1,1,1,1,1,nil,1]
 let input = [2,2,2,5,2]
 let binaryTree = createBinaryTree(with: input)
 print(Solution_isUnivalTree().isUnivalTree(binaryTree))
 */


/***********************************************************************************/

class Solution_countCharacters {
    func countCharacters(_ words: [String], _ chars: String) -> Int {
        var count = 0
        
        // store chars into charsDict dictionary
        var charsDict:[Character:Int] = [:]
        for ch in chars {
            if let val = charsDict[ch] {
                charsDict[ch] = val + 1
            } else {
                charsDict[ch] = 1
            }
        }
        
        // cound valid words
        for word in words {
            if self.isValid(word: word, charDict: charsDict) {
                count += word.count
            }
        }
        
        return count
    }
    
    private func isValid(word:String, charDict:[Character:Int]) -> Bool {
        
        // store word into dictionary
        var wordDict:[Character:Int] = [:]
        for ch in word {
            if let val = wordDict[ch] {
                wordDict[ch] = val + 1
            } else {
                wordDict[ch] = 1
            }
        }
        
        // compare if word dictioinary is same as charsDict
        let allKeys = wordDict.keys
        
        for key in allKeys {
            if let charCount = wordDict[key] {
                if let availableCharCount = charDict[key], charCount <= availableCharCount {
                    // good
                } else {
                    return false
                }
            }
        }
        
        return true
    }
}

/*
 let words = ["cat","bt","hat","tree"]
 let chars = "atach"
 print(Solution_countCharacters().countCharacters(words, chars))
 */

/***********************************************************************************/

// 617. Merge Two Binary Trees

class Solution_mergeTrees {
    func mergeTrees(_ t1: TreeNode?, _ t2: TreeNode?) -> TreeNode? {
        if t1 == nil {
            return t2
        }
        
        if t2 == nil {
            return t1
        }
        
        if let t1 = t1, let t2 = t2 {
            let newNode = TreeNode(t1.val + t2.val)
            newNode.left = mergeTrees(t1.left, t2.left)
            newNode.right = mergeTrees(t1.right, t2.right)
            
            return newNode
        }
        
        return nil
    }
}

/***********************************************************************************/

class Solution_longestPalindrome {
    
    func longestPalindrome(_ s: String) -> String {
        
        var longestPalindrome = ""
        let input = [Character](s)
        
        for (i,_) in input.enumerated() {
            let palindrome = self.getPalindromeFor(i: i, input: input)
            if palindrome.count > longestPalindrome.count {
                longestPalindrome = palindrome
            }
        }
        
        // if no palindrome then at least return a first character
        // because single character is itself a palindrome
        if longestPalindrome.isEmpty, let firstChar = s.first {
            longestPalindrome.append(firstChar)
        }
        return longestPalindrome
    }
    
    private func getPalindromeFor(i:Int, input:[Character]) -> String {
        
        var evenPalindrome = ""
        if i+1 < input.count && input[i] == input[i+1] {
            evenPalindrome = self.growPalindrome(i: i, j: i + 1, input: input, currChar: nil)
        }
        
        var oddPalindrome = ""
        if i+1 < input.count && i-1 >= 0 && input[i-1] == input[i+1] {
            oddPalindrome = self.growPalindrome(i: i - 1, j: i + 1, input: input, currChar: input[i])
        }
        
        return max(evenPalindrome, oddPalindrome)
    }
    
    private func growPalindrome(i:Int, j:Int, input:[Character], currChar:Character?) -> String {
        
        var palindrome:[Character] = []
        if let currChar = currChar {
            palindrome.append(currChar)
        }
        
        var left = i
        var right = j
        
        while left >= 0 && right < input.count && input[left] == input[right] {
            
            palindrome.insert(input[left], at: 0)
            palindrome.append(input[right])
            
            left = left - 1
            right = right + 1
        }
        
        return String(palindrome)
    }
}

/*
 let input = "babad"
 print(Solution_longestPalindrome().longestPalindrome(input))
 */

/***********************************************************************************/

// 28. Implement strStr()

// I was not able to solve this on leetcode as this solution exceeds time need to think better solution
// Wonderring what could be better solution than

class Solution_strStr {
    func strStr(_ haystack: String, _ needle: String) -> Int {
        if needle.isEmpty {
            return 0
        }
        if needle.count > haystack.count {
            return -1
        }
        let haystackChars = Array(haystack)
        let needleChars = Array(needle)
        
        var count = 0
        var i = 0
        while i < haystackChars.count {
            if needleChars[count] == haystackChars[i] {
                count += 1
                
                if count == needle.count {
                    return i - (needleChars.count - 1)
                }
            } else {
                i = i - count
                count = 0
            }
            
            // if remaining needle items > remaining haystack items then return - 1
            let remNeedleItems = needleChars.count - count
            let remHaystackItems = haystackChars.count - i
            
            if remHaystackItems < remNeedleItems {
                return -1
            }
            i += 1
        }
        return -1
    }
}

/*
 let haystack = "mississippi"
 let needle = "issip"
 print(Solution().strStr(haystack, needle))
 */

/***********************************************************************************/

// this solution assumes all the intervals are inside positive value range

class Solution1_merge {
    func merge(_ intervals: [[Int]]) -> [[Int]] {
        
        // 1. get highest value in the intervals
        var higestVal = 0
        for arr in intervals {
            if arr[0] > higestVal {
                higestVal = arr[0]
            }
            if arr[1] > higestVal {
                higestVal = arr[1]
            }
        }
        
        var storage:[Int] = [Int](repeating: 0, count: higestVal + 2)
        
        // store the intervals inside storage
        var valueToInsert = 1
        for arr in intervals {
            
            var tempValueToInsert = 1
            if storage[arr[0]] != 0 {
                tempValueToInsert = storage[arr[0]]
            } else if storage[arr[1]] != 0 {
                tempValueToInsert = storage[arr[1]]
            } else {
                tempValueToInsert = valueToInsert
                valueToInsert += 1
            }
            
            for i in arr[0]...arr[1] {
                storage[i] = tempValueToInsert
            }
        }
        
        // collecting results
        var result:[[Int]] = []
        
        // starting value
        var sIndex = -2
        // end value
        var eIndex = -2
        
        var i = 0
        while i < storage.count {
            if i-1 >= 0 && storage[i-1] == storage[i] {
                eIndex = i
            } else {
                if sIndex != -2 {
                    var newArr:[Int] = []
                    newArr.append(sIndex)
                    newArr.append(eIndex)
                    result.append(newArr)
                }
                
                if storage[i] != 0 {
                    sIndex = i
                    eIndex = i
                } else {
                    sIndex = -2
                    eIndex = -2
                }
            }
            i += 1
        }
        return result
    }
}

//let input = [[1,3],[2,6],[8,10],[15,18]]
//let input = [[1,4],[5,6]]
//let input = [[1,4],[0,0]]
//let input = [[1,4],[0,1]]
//print(Solution1_merge().merge(input))


/***********************************************************************************/

/// Apple coding interview

/* englishNum should be written to take a single integer (for simplicity's sake, we will limit it to the range [0, 10_000_000]) and return the English words representing that number */
func englishNum(_ num: Int) -> String {
    
    // preparing unique mappings for unique numbers
    
    var numberMappings:[Int:String] = [
        0:"zero",
        1:"one",
        2:"two",
        3:"three",
        4:"four",
        5:"five",
        6:"six",
        7:"seven",
        8:"eight",
        9:"nine",
        10:"ten",
        20:"twenty",
        30:"thirty",
        40:"fourty",
        50:"fivty",
        60:"sixty",
        70:"seventy",
        80:"eighty",
        90:"ninety",
        100:"hundred",
        1000:"thousand"
    ]
    
    
    // I am going to break down the input and store into array such as
    // if it is  198
    // array = [1,9,8]
    
    // 879
    
    // [8,8,7,9]
    
    var inputBreakDowns:[Int] = []
    
    var input = num
    
    while input > 0 {
        let rem = input % 10
        inputBreakDowns.insert(rem, at:0)
        input = input / 10
    }
    
    var result = ""
    for (i,num) in inputBreakDowns.enumerated() {
        
        // this handles between 0 to 99
        if i >= inputBreakDowns.count - 1 {
            
            var result = ""
            if i == inputBreakDowns.count - 2 {
                if let tenthVal = numberMappings[num * 10] {
                    result = result + tenthVal
                }
            }
            
            if let val = numberMappings[num] {
                result = result + " " + val
            }
        } else {
            // this handles above 99
            
            let multiplier = Int(pow(Double(10),Double(inputBreakDowns.count - i - 1)))
            
            if let numberVal = numberMappings[num],
               let multiplerVal = numberMappings[multiplier] {
                result = result + " " + numberVal + " " + multiplerVal
            }
        }
    }
    
    return result
}

func check<T: Equatable>(_ a: T, _ b: T) {
    if a == b {
        print("correct:\t\(a)")
    } else  {
        print("incorrect:\t\(a) should be \(b)")
    }
}

/*
 check(englishNum(0), "zero")
 check(englishNum(1), "one")
 check(englishNum(42), "forty-two")
 check(englishNum(71), "seventy-one")
 check(englishNum(90), "ninety")
 check(englishNum(127), "one hundred and twenty-seven")
 check(englishNum(72_000), "seventy-two thousand")
 check(englishNum(72_456), "seventy-two thousand four hundred and fifty-six")
 check(englishNum(1_000_000), "one million")
 check(englishNum(1_200_000), "one million two hundred thousand")
 check(englishNum(1_472_221), "one million four hundred seventy-two thousand two hundred and twenty-one")
 
 */


/***********************************************************************************/
// My better solution for the interview question with Veriely Life Science
// Coins: [25, 10, 5, 1]
// I need 31. What is the minimum number of coins required to get to 31?

class Solution_minimumNumberOfCoins {
    
    var minCoinCountDict:[Int:Int] = [:]
    func minimumNumberOfCoins(_ coins: [Int], _ sum: Int) -> Int {
        return self.minimumNumberOfCoins(coins: coins, minCount: 0, sum: sum)
    }
    
    private func minimumNumberOfCoins(coins:[Int], minCount:Int, sum:Int) -> Int {
        
        if sum == 0 {
            return minCount
        }
        
        var min = Int.max
        for coinVal in coins {
            if coinVal <= sum {
                
                var localMin = 0
                if let storedMinCount = self.minCoinCountDict[sum] {
                    localMin = storedMinCount
                } else {
                    localMin = self.minimumNumberOfCoins(coins: coins, minCount: minCount + 1, sum: sum-coinVal)
                    
                    // cache in order to use next time for same
                    self.minCoinCountDict[sum-coinVal] = localMin
                }
                
                if localMin < min {
                    min = localMin
                }
            }
        }
        
        return min
    }
}

/*
 let coins = [25, 10, 1]
 let sum = 31
 print(Solution_minimumNumberOfCoins().minimumNumberOfCoins(coins, sum))
 */

/***********************************************************************************/

// practice

/*
 
 var aDict:[String:Int] = [:]
 
 aDict["Krishna"] = 2
 aDict["Hari"] = 1
 
 aDict["Bista"] = 3
 
 //let minuteInterval = 5
 //for tickMark in stride(from: 0, to: 60, by: minuteInterval) {
 //    // render the tick mark every 5 minutes (0, 5, 10, 15 ... 45, 50, 55)
 //
 //    print(tickMark)
 //}
 //
 ////for item in aDict {
 ////
 ////    let a = type(of: item)
 ////
 ////    print(item.key)
 ////}
 //
 //
 //let animals = ["Antelope", "Butterfly", "Camel", "Dolphin"]
 //
 //var animalIterator = animals.makeIterator()
 //while let animal = animalIterator.next() {
 //    print(animal)
 //}
 
 struct Countdown: Sequence {
 let start: Int
 
 func makeIterator() -> CountdownIterator {
 return CountdownIterator(self)
 }
 }
 
 struct CountdownIterator: IteratorProtocol {
 let countdown: Countdown
 var times = 0
 
 init(_ countdown: Countdown) {
 self.countdown = countdown
 }
 
 mutating func next() -> Int? {
 let nextNumber = countdown.start - times
 
 guard nextNumber > 0 else {
 return nil
 }
 
 times += 2
 return nextNumber
 }
 }
 
 //let threeTwoOne = Countdown(start: 20)
 //for (i,count) in threeTwoOne.enumerated() {
 //    print("\(count)...")
 //}
 
 struct iPad: Hashable {
 var serialNumber: String
 var capacity: Int
 }
 
 let ipad1 = iPad(serialNumber: "1234", capacity: 12)
 let ipad2 = iPad(serialNumber: "1234", capacity: 12)
 
 //print(ipad1 == ipad2)
 
 struct Person: Equatable {
 var name: String
 var age: Int
 }
 
 let person1 = Person(name: "hari", age: 12)
 let person2 = Person(name: "hari", age: 12)
 
 print(person1 == person2)
 
 */

/***********************************************************************************/

/* problem with WealthFront
 
 
 /* Here's a helper class that can efficiently return the smallest
  * object it contains. Assume it magically knows how to sort your
  * objects correctly – all of these methods run in O(1) times
  */
 
 public class MinHeap<T> {
 var count = 0
 
 // Adds an object
 func addObject(_ object: T)
 
 // Returns (but does not remove) the smallest object, or nil if empty
 func minObject() -> T?
 
 // Removes and returns the smallest object, or nil if empty
 func popMinObject() -> T?
 
 // Removes all objects
 func removeAllObjects()
 }
 
 /*
  Sample input:
  let input = [[4, 4],
  [1, 5, 10],
  [3, 7, 8, 98, 99],
  [],
  [4, 4]]
  m = # of subarrays
  n = length of the longest subarray
  
  worst case:
  runtime: O(m*n)
  space: O(m*n)
  */
 /*
  Expected output:
  [ 1, 2, 3, 4, 4, 4, 5, 6, 7, 8, 10, 98, 99 ]
  
  */
 
 // my solution
 
 // 1. take only first item of the sub array and put it inside the min heap
 
 // 2. we can use dictionary [Int:[Int]] , first element of array as key and rest as value
 
 // 3. iterate over the min heap, get the minimum item and taking it as a key get the array
 
 // keep appending the araay to the result
 
 
 func mergeArrays(_ arrays: [[Int]]) -> [Int] {
 
 // O(m*n)
 var minHeap = MinHeap<Int>()
 
 // O(m*n)
 for arr in arrays {
 for number in arr {
 minHeap.addObject(number)
 }
 }
 
 // O(m*n)
 let result:[Int] = []
 
 // O(m*n)
 while minHeap.count > 0 {
 result.append(minHeap.popMinObject())
 }
 
 return result
 }
 
 */


/* Question asked in the online coding assesment of Caffaine */
// Need to balance angles to its by adding necessary angles to its ending and beginnings

func solution(angles: String) -> String {
    
    var anglesChars = Array(angles)
    
    
    var stack:[Character] = []
    
    for ch in anglesChars {
        if ch == "<" {
            stack.append(ch)
        } else if ch == ">" && stack.isEmpty == false {
            stack.removeLast()
        }
    }
    
    //  balance all remaining "<"
    let openAngles:[Character] = [Character](repeating: ">", count: stack.count)
    anglesChars.append(contentsOf: openAngles)
    
    // now try to balance beginninng
    stack.removeAll()
    
    var i = anglesChars.count - 1
    while i >= 0 {
        let ch = anglesChars[i]
        
        if ch == ">" {
            stack.append(ch)
        } else if ch == "<" && stack.isEmpty == false {
            stack.removeLast()
        }
        
        i = i - 1
    }
    
    let closeAngles:[Character] = [Character](repeating: "<", count: stack.count)
    anglesChars.insert(contentsOf: closeAngles, at: 0)
    
    return String(anglesChars)
}

/*
 let input = "<"
 print(solution(angles: input))
 */

/***********************************************************************************/

// frequently asked question in facebook interview

class Solution_moveAllNonZeroToBeginning {
    func moveAllNonZeroToBeginning(numbers:[Int]) -> [Int] {
        var resultNumbers = [Int](repeating: 0, count: numbers.count)
        var count = 0
        
        for number in numbers {
            if number != 0 {
                resultNumbers[count] = number
                count += 1
            }
        }
        
        return resultNumbers
    }
    
    func moveAllZeroToBeginning(numbers:[Int]) -> [Int] {
        var resultNumbers = [Int](repeating: 0, count: numbers.count)
        
        var count = numbers.count - 1
        
        for number in numbers {
            if number != 0 {
                resultNumbers[count] = number
                count = count - 1
            }
        }
        
        return resultNumbers
    }
}

//let input = [0,1,2,3,40,4,0,4,5,0,2,0]
//print(Solution_moveAllNonZeroToBeginning().moveAllNonZeroToBeginning(numbers: input))
//print(Solution_moveAllNonZeroToBeginning().moveAllZeroToBeginning(numbers: input))

/***********************************************************************************/

class Solution_romanToInt {
    func romanToInt(_ s: String) -> Int {
        
        let romanToIntDict:[Character:Int] = [
            "I":1,
            "V":5,
            "X":10,
            "L":50,
            "C":100,
            "D":500,
            "M":1000
        ]
        
        let roman = Array(s)
        
        var i = 0
        
        var result = 0
        while i < roman.count {
            
            if let currVal = romanToIntDict[roman[i]] {
                if i + 1 < roman.count, let nextVal = romanToIntDict[roman[i+1]], currVal < nextVal {
                    result = result + nextVal - currVal
                    i = i + 1
                } else {
                    result = result + currVal
                }
            }
            
            i = i + 1
        }
        
        return result
    }
}

/*
 let input = "LXXXIX"
 print(Solution_romanToInt().romanToInt(input))
 */

/***********************************************************************************/

class Solution4_isPalindrome {
    func isPalindrome(_ x: Int) -> Bool {
        
        guard x > -1 else {
            return false
        }
        
        let inputChars  =  Array("\(x)")
        
        var i = 0
        while inputChars.count - 1 - i > i {
            if inputChars[i] != inputChars[inputChars.count - 1 - i] {
                return false
            }
            i = i + 1
        }
        
        return true
    }
}

// print(Solution4_isPalindrome().isPalindrome(100000001))

/***********************************************************************************/

// below solution is time exceeded in Leetcode
class Solution1_mergeKLists {
    
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        
        var resultList:ListNode?
        
        for list in lists {
            resultList = self.mergeTwoLists(list, resultList)
        }
        
        return resultList
    }
    
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
 var lists:[ListNode] = []
 
 if let list1 = createLinkedListFromArray(arr: [1,4,5]) {
 lists.append(list1)
 }
 
 if let list2 = createLinkedListFromArray(arr: [1,3,4]) {
 lists.append(list2)
 }
 
 if let list3 = createLinkedListFromArray(arr: [2,6]) {
 lists.append(list3)
 }
 
 if let result = Solution1_mergeKLists().mergeKLists(lists) {
 printLinkedList(head: result)
 }
 */


// below solution is time exceeded in Leetcode

class Solution2_mergeKLists {
    
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        
        var runnerNodes = lists
        
        var resultNode:ListNode?
        var lastNode:ListNode?
        
        var tempSmallest:ListNode = ListNode(Int.max)
        var tempSmallIndex = -1
        
        var i = 0
        while runnerNodes.count > i {
            
            if let runnerNode = runnerNodes[i], runnerNode.val < tempSmallest.val {
                tempSmallest = runnerNode
                tempSmallIndex = i
            }
            
            i = i + 1
            
            // after getting smallest out of runnerNodes collect the smallest node into result
            if i == runnerNodes.count {
                
                if resultNode == nil {
                    resultNode = tempSmallest
                    lastNode = resultNode
                } else {
                    lastNode?.next = tempSmallest
                    lastNode = tempSmallest
                }
                
                if tempSmallIndex > -1 {
                    if let nextNode = runnerNodes[tempSmallIndex]?.next {
                        runnerNodes[tempSmallIndex] = nextNode
                    } else {
                        // removing the runner nodes if it comes to end
                        runnerNodes.remove(at: tempSmallIndex)
                    }
                }
                
                lastNode?.next = nil
                
                // reset temp smallest
                tempSmallest = ListNode(Int.max)
                i = 0
            }
        }
        
        return resultNode
    }
}


// [[1,4,5],[1,3,4],[2,6]]

/*
 var lists:[ListNode] = []
 
 if let list1 = createLinkedListFromArray(arr: [1,4,5]) {
 lists.append(list1)
 }
 
 if let list2 = createLinkedListFromArray(arr: [1,3,4]) {
 lists.append(list2)
 }
 
 if let list3 = createLinkedListFromArray(arr: [2,6]) {
 lists.append(list3)
 }
 
 if let result = Solution2_mergeKLists().mergeKLists(lists) {
 printLinkedList(head: result)
 }
 
 */

/***********************************************************************************/

// Practce with Friend: Sujan Shrestha
class Solution_countLongestConsequtiveIncrement {
    
    var longest = 0
    
    func countLongestConsequtiveIncrement(root:TreeNode) -> Int {
        self.countLongest(node: root, count:0)
        return self.longest
    }
    
    private func countLongest(node:TreeNode, count:Int) {
        
        if self.longest < count {
            self.longest = count
        }
        
        if node.right == nil && node.left == nil {
            return
        }
        
        if let leftNode = node.left {
            if leftNode.val >= node.val {
                self.countLongest(node: leftNode, count:count+1)
            } else {
                self.countLongest(node: leftNode, count:0)
            }
        }
        
        if let rightNode = node.right {
            if rightNode.val >= node.val {
                self.countLongest(node: rightNode, count:count+1)
            } else {
                self.countLongest(node: rightNode, count:0)
            }
        }
    }
}

/***********************************************************************************/

// on facebook technical coding interview

// find all possible substraction and addition combinations when given an array of Integer

//class Solution {
//    func collectArithmaticCombinationResult(arr:[Int]) -> [Int] {
//
//        var result:[Int] = []
//
//        if arr.count == 0 {
//            return [Int]()
//        } else {
//
//            var newArr = arr
//
//            let firstItem = newArr.removeFirst()
//            let res1 = firstItem + self.collectArithmaticCombinationResult(arr: newArr)
//
//
//        }
//
//        return result
//    }
//
//    func possibleSum(arr:[Int]) -> Int {
//
//    }
//
//}


/*
 Your code is stored in a revision control system (e.g. svn). You see a bug
 in your code, and you know it wasn't there before. Given the start revision (Int) and the end revision (Int) write a function to find the revision that introduced the bug.
 
 For example:
 revision 100
 revision 101
 ...
 revision ??? <-- a bug was introduced!
 ...
 revision 150
 revision 151
 revision 152
 
 rev 1
 rev 2 False
 rev 3 True <- bug introduced
 rev 4 True
 rev 5
 
 // Assume you have this function, implemented for you to use
 func isBad(revNum: Int) -> Bool
 */

// n = endRev - startRev

// O(n)

// [f,f,f,t,t,t,t,t,t]
//  5,6,7,8,9,10,11,12,13

// mid = 9

// 0,0

// check negative inputs

// within the range of big int

// 1,2

// [f,t]
// [1,2]

// mid = (1 + 2)/2 => 1
// start = 1
// end = 2

//

func isBad(revNum: Int) -> Bool {
    return true
}

//  my solution there is one problem while conditioning to return right rev

//func findBug(startRev:Int, endRev:Int) -> Int {
//
//  if startRev >= endRev {
//    return -1
//  }
//
//  // get mid revision value
//  let midRev = (startRev + endRev)/2
//
//  if (isBad(revNum: midRev) == true && isBad(revNum: midRev + 1) == false) ||
//    (isBad(revNum: midRev) == true && isBad(revNum: midRev - 1) == false) {
//    return midRev
//  } else {
//    if isBad(revNum: midRev) {
//      // search in first half
//      return findBug(startRev:startRev, endRev:midRev)
//
//    } else {
//      // search in second half
//      return findBug(startRev:midRev, endRev:endRev)
//    }
//  }
//}

func findBug(startRev:Int, endRev:Int) -> Int {
    
    if startRev >= endRev {
        return -1
    }
    
    // get mid revision value
    let midRev = (startRev + endRev)/2
    
    if (isBad(revNum: midRev) == false && isBad(revNum: midRev + 1) == true) ||
        (isBad(revNum: midRev) == true && isBad(revNum: midRev - 1) == false) {
        return midRev
    } else {
        if isBad(revNum: midRev) {
            // search in first half
            return findBug(startRev:startRev, endRev:midRev)
            
        } else {
            // search in second half
            return findBug(startRev:midRev, endRev:endRev)
        }
    }
}


/***********************************************************************************/

// 33. Search in Rotated Sorted Array

// medium

class Solution_search {
    func search(_ nums: [Int], _ target: Int) -> Int {
        
        guard nums.count > 0 else {
            return -1
        }
        
        let pivot = self.findPivot(nums: nums, l: 0, r: nums.count-1)
        
        // search in right half
        let leftHalfIndex = self.binSearch(l: 0, u: pivot, nums: nums, target: target)
        if leftHalfIndex > -1 {
            return leftHalfIndex
        }
        
        // search in left half
        let rightHalfIndex = self.binSearch(l: pivot+1, u: nums.count-1, nums: nums, target: target)
        if rightHalfIndex > -1 {
            return rightHalfIndex
        }
        
        return -1
    }
    
    private func findPivot(nums:[Int], l:Int, r:Int) -> Int {
        
        if l > r { return 0 }
        
        let m = (l + r)/2
        
        if m-1 >= 0 && nums[m-1] > nums[m] {
            return m-1
        } else if m+1 < nums.count && nums[m] > nums[m+1] {
            return m
        } else {
            if nums[m] > nums[r] {
                // search in right half
                return self.findPivot(nums: nums, l: m + 1, r: r)
            } else {
                // search in left half
                return self.findPivot(nums: nums, l: l, r: m-1)
            }
        }
    }
    
    private func binSearch(l:Int, u:Int, nums:[Int], target:Int) -> Int {
        
        if l > u {
            return -1
        }
        
        let m = (l + u)/2
        
        if target == nums[m] {
            return m
        }
        
        if target > nums[m] {
            return self.binSearch(l: m + 1, u: u, nums: nums, target: target)
        } else {
            return self.binSearch(l: l, u: m - 1, nums: nums, target: target)
        }
    }
}

/*
 //let input = [4,5,6,7,0,1,2]
 //let input:[Int] = []
 
 //let input = [4,5,6,7,8,1,2,3]
 let input = [1,2,3,4,5]
 
 print(Solution_search().search(input, 5))
 */

/***********************************************************************************/

// 392. Is Subsequence

class Solution_isSubsequence {
    func isSubsequence(_ s: String, _ t: String) -> Bool {
        
        if s.isEmpty {
            return true
        }
        
        if s.count > t.count {
            return false
        }
        
        var sChars = Array(s)
        var i = 0
        for ch in t {
            if ch == sChars[i] {
                i = i + 1
            }
            
            if i > s.count - 1 {
                return true
            }
        }
        
        return i >= s.count - 1
    }
}

/*
 let s = "ace"
 let t = "abcde"
 print(Solution_isSubsequence().isSubsequence(s, t))
 */


// 287. Find the Duplicate Number

class Solution_findDuplicate {
    func findDuplicate(_ nums: [Int]) -> Int {
        
        var prevNum = -1
        for n in nums.sorted() {
            if n == prevNum {
                return n
            }
            prevNum = n
        }
        return -1
    }
}

/*
 let input = [1,3,4,2,2]
 print(Solution_findDuplicate().findDuplicate(input))
 */

/***********************************************************************************/

public func solution(_ T : inout [Int]) -> Int {
    // write your code in Swift 4.2.1 (Linux)
    
    var dictOfCandyTypes:[Int:Int] = [:]
    
    for item in T {
        if let val = dictOfCandyTypes[item] {
            dictOfCandyTypes[item] = val + 1
        } else {
            dictOfCandyTypes[item] = 1
        }
    }
    
    var taken = false
    var resultCount = 0
    for (_,count) in dictOfCandyTypes {
        
        if count % 2 == 0 {
            resultCount = resultCount + 1
        } else {
            if taken {
                taken = false
            } else {
                resultCount = resultCount + 1
                taken = true
            }
        }
    }
    
    return resultCount
}

//var input = [3, 4, 7, 7, 6, 6]
// var input = [80, 80, 1000000000, 80, 80, 80, 80, 80, 80, 123456789]
//print(solution(&input))


/***********************************************************************************/

// pramp practice

class Solution_Sqrt {
    
    /*...................*/
    
    func floorSqrt(x:Int) -> Int {
        if x == 0 || x == 1 {
            return x
        }
        
        var i = 1
        while i * i <= x {
            i = i + 1
        }
        return i-1
    }
    
    /*...................*/
    
    func myBinSearchSqrt(n:Int) -> Int {
        if n == 0 || n == 1 {
            return n
        }
        return self.binSearchSqrt(n: n, low: 0, high: n/2)
    }
    
    private func binSearchSqrt(n:Int, low:Int, high:Int) -> Int {
        let m = (low + high)/2
        
        if m*m <= n && (m+1)*(m+1) > n {
            return m
        } else if m*m > n {
            return self.binSearchSqrt(n: n, low: low, high: m-1)
        } else {
            return self.binSearchSqrt(n: n, low: m+1, high: high)
        }
    }
    
    /*...................*/
    
    func myDoubleSqrt(n:Double) -> Double {
        return myDoubleSqrt(n: n, low: 0.0, high: n/2)
    }
    
    private func myDoubleSqrt(n:Double, low:Double, high:Double) -> Double {
        
        let m = (low + high)/2
        
        if abs(m*m - n) < 0.001 {
            return m
        } else {
            if m*m > n {
                return self.myDoubleSqrt(n: n, low: low, high: m)
            } else {
                return self.myDoubleSqrt(n: n, low: m, high: high)
            }
        }
    }
    
    /*...................*/
    
    // precision = 0.001
    func findSqrtNonRecusion(n:Double) -> Double {
        var low = 0.0
        var high = n
        
        while (high - low) > 0.001 {
            
            let mid = (high + low)/2
            let newSqrt = mid*mid
            
            if newSqrt == n {
                return mid
            } else if newSqrt < n {
                low = mid
            } else {
                high = mid
            }
        }
        
        return (high + low)/2
    }
    
    // non recursion
    func findNthRoot(x:Double, n:Int) -> Double {
        var low = 0.0
        
        var high = x
        
        while (high - low) > 0.001 {
            
            let mid = (high + low)/2
            let newSqrt = pow(mid,Double(n))
            
            if newSqrt == x {
                return mid
            } else if newSqrt < x {
                low = mid
            } else {
                high = mid
            }
        }
        
        return (high + low)/2
    }
}

//print(Solution_Sqrt().floorSqrt(x: 8))
//print(Solution_Sqrt().floorSqrt(x: 9))
//print(Solution_Sqrt().floorSqrt(x: 10))

//print(Solution_Sqrt().myBinSearchSqrt(n: 8))
//print(Solution_Sqrt().myBinSearchSqrt(n: 9))
//print(Solution_Sqrt().myBinSearchSqrt(n: 16))

//print(Solution_Sqrt().findSqrtNonRecusion(n: 9))
// print(Solution_Sqrt().findNthRoot(x: 7, n: 3))


/***********************************************************************************/


/* Interview questios with Life360
 
 
 struct Circle : Hashable {
 let id: UUID
 let members: Set<Member>
 
 static func == (lhs: Self, rhs: Self) -> Bool {
 return lhs.members == lhs.members
 }
 }
 
 struct Member: Hashable {
 let id: UUID
 let name: String
 }
 
 let members = ["John", "Jane", "Jake", "Jack", "Jenny", "Jessy",
 "Mike", "Marry", "Michelle", "Mandy", "Michael", "Morty"].map{ Member(id: UUID(), name: $0) }
 
 let circles = [3,2,6,3,1,2].map{ max -> Circle in
 let membersCount = UInt32(members.count)
 let people = Set((0...max).map{ _ -> Member in
 let i: Int = Int(arc4random_uniform(membersCount))
 return members[i]
 })
 return Circle(id: UUID(), members: people)
 }
 
 
 //for c in circles { print(c) }
 
 //let input : [Circle] = circles
 
 // 2 members are the same iff ids are the same
 // 2 circles are the same iff their members are the same, using "same" from member's definition.
 
 // Write a function to detect circles with identical members
 
 func question(circles: [Circle]) -> [Circle] {
 var uniqueCircles = Set<Circle>()
 for circle in circles {
 uniqueCircles.insert(circle)
 }
 return Array(uniqueCircles)
 }
 
 // Write a function that sorts by circle size
 func question2(circles: [Circle]) -> [Circle] {
 return circles.sorted { (circle1:Circle, circle2:Circle) in
 return circle1.members.count > circle2.members.count
 }
 }
 
 */

/***********************************************************************************/

/* Practice Hasable */

struct Employee : Hashable {
    var id:String
    var name:String
}

struct Company : Hashable {
    var address:String
    var name:String
    var companyId:String
    
    var employees:Set<Employee>
}


/*
 let emp1 = Employee(id: "1", name: "Hari")
 let emp2 = Employee(id: "2", name: "Hari")
 let emp3 = Employee(id: "3", name: "Hari")
 let emp4 = Employee(id: "4", name: "Hari")
 let emp5 = Employee(id: "5", name: "Hari")
 
 print("begin here")
 
 var set1 = Set<Employee>()
 set1.insert(emp1)
 set1.insert(emp2)
 set1.insert(emp3)
 
 var set2 = Set<Employee>()
 set2.insert(emp1)
 set2.insert(emp2)
 set2.insert(emp3)
 
 print(set1 == set2)
 */

/***********************************************************************************/

// 18. 4Sum
class Solution_fourSum {
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        
        var result:Set<[Int]> = []
        
        guard nums.count >= 4 else {
            return []
        }
        
        let sortedArr = nums.sorted()
        
        for i in 0..<sortedArr.count {
            for j in i+1..<sortedArr.count {
                
                let partialSum = sortedArr[i] + sortedArr[j]
                
                if let twoSumRes = twoSum(arr:sortedArr, target:target - partialSum, start:j + 1) {
                    for res in twoSumRes {
                        
                        var tmpRes:[Int] = []
                        tmpRes.append(sortedArr[i])
                        tmpRes.append(sortedArr[j])
                        tmpRes.append(contentsOf: res)
                        
                        result.insert(tmpRes)
                    }
                }
            }
        }
        
        return Array(result)
    }
    
    func twoSum(arr: [Int], target: Int, start:Int) -> [[Int]]? {
        
        var i = start
        var j = arr.count - 1
        
        var results:[[Int]] = []
        while i < j {
            let sum = arr[i] + arr[j]
            
            if sum == target {
                results.append([arr[i], arr[j]])
                i = i + 1
                j = j - 1
            } else if sum > target {
                j = j - 1
            } else {
                i = i + 1
            }
        }
        
        return results.count > 0 ? results : nil
    }
}

//let input = [-3,-2,-1,0,0,1,2,3]
//print(Solution_fourSum().fourSum(input, 0))

/***********************************************************************************/

/*
 An image is represented by a 2-D array of integers, each integer representing the pixel value of the image (from 0 to 65535).
 
 Given a coordinate (sr, sc) representing the starting pixel (row and column) of the flood fill, and a pixel value newColor, "flood fill" the image.
 
 To perform a "flood fill", consider the starting pixel, plus any pixels connected 4-directionally to the starting pixel of the same color as the starting pixel, plus any pixels connected 4-directionally to those pixels (also with the same color as the starting pixel), and so on. Replace the color of all of the aforementioned pixels with the newColor.
 
 At the end, return the modified image.
 
 input
 [[1,1,1],[1,1,0],[1,0,1]]
 sr = 1, sc = 1, newColor = 2
 
 output
 [[2,2,2],[2,2,0],[2,0,1]]
 
 
 [2, 2, 2]
 [2, 2, 2]
 [2, 2, 2]
 
 for (1,1) newColor = 5
 
 [5, 3, 2]
 [5, 3, 0]
 [5, 0, 1]
 
 
 */

class Solution_floodFill {
    
    func floodFill(image:inout [[Int]], color: Int, i:Int, j:Int) {
        // depth first traversel starting from row, col
        
        // get all neibours
        var currColor = image[i][j]
        image[i][j] = color
        
        // explore top
        let topI = i - 1
        
        if topI >= 0, currColor == image[topI][j] {
            self.floodFill(image:&image, color:color, i:topI, j:j)
        }
        
        // explore left
        let leftJ = j - 1
        if leftJ >= 0, currColor == image[i][leftJ] {
            self.floodFill(image:&image, color:color, i:i, j:leftJ)
        }
        
        // explore bottom
        let bottomI = i + 1
        if bottomI < image.count, currColor == image[bottomI][j] {
            self.floodFill(image:&image, color:color, i:bottomI, j:j)
        }
        
        // explore right
        let rightJ = j + 1
        if rightJ < image[0].count, currColor == image[i][rightJ] {
            self.floodFill(image:&image, color:color, i:i, j:rightJ)
        }
    }
}

/***********************************************************************************/


class Solution_pancakeSort {
    
    // 1. find largest elememt
    // 2. flip from 0th index to largest index to bring that to the 0 index
    // 3. flip whole unsorted array so that largest item in 0th index would go to sorted section
    
    func flip(arr:[Int], k:Int) -> [Int] {
        
        if k > arr.count {
            return arr
        }
        
        var i = k - 1
        
        var result:[Int] = []
        
        while i >= 0 {
            result.append(arr[i])
            i = i - 1
        }
        
        i = k
        
        while i < arr.count {
            result.append(arr[i])
            i = i + 1
        }
        
        return result
    }
    
    func pancakeSort(arr: [Int]) -> [Int] {
        
        var arrCopy = arr
        
        var lastSortedIndex = arr.count
        
        for i in 0..<arrCopy.count {
            
            let largestIndex = largestUnsortedIndex(arr:arrCopy, lastSortedIndex:lastSortedIndex)
            
            let flippedArr = flip(arr:arrCopy, k: largestIndex+1)
            
            arrCopy = flip(arr:flippedArr, k:arr.count-i)
            
            lastSortedIndex = arrCopy.count - 1 - i
            
        }
        
        return arrCopy
    }
    
    func largestUnsortedIndex(arr:[Int], lastSortedIndex:Int) -> Int {
        
        // serarch within the unsorted range only
        var largestIndex = 0
        for i in 0..<lastSortedIndex {
            if arr[i] > arr[largestIndex] {
                largestIndex = i
            }
        }
        
        return largestIndex
    }
}

/*
 let input1 = [1, 5, 4, 3, 2]
 let result = Solution_pancakeSort().pancakeSort(arr: input1)
 print(result)
 */

/***********************************************************************************/

/*
 
 Paypal Interview questions
 
 Your previous Plain Text content is preserved below:
 
 Given an array of strings S and two words w1 and w2 that are present in S. The task is to find the minimum distance between w1 and w2. Here distance is the number of steps or words between the first and the second word. S can have duplicate strings
 
 example input:
 S = ["paypal", "ios", "hiring", "swift", "paypal"]
 w1 = "paypal"
 w2 = "swift"
 
 example output:
 minDistance(w1, w2) = 1  // As "swift" & "paypal" are adjacent to each other
 
 */

class Solution_minDistance {
    func minDistance(_ S:[String], w1:String, w2:String) -> Int {
        
        var w1_i = -1
        var w2_i = -1
        
        var minDist = S.count
        
        for (i,str) in S.enumerated() {
            
            if w1 == str {
                w1_i = i
            }
            
            if w2 == str {
                w2_i = i
            }
            
            if (w1 == str || w2 == str) && w1_i > -1 && w2_i > -1 {
                let dist = abs(w2_i - w1_i)
                
                if dist < minDist {
                    minDist = dist
                }
            }
        }
        
        return minDist
    }
}

/*
 let S = ["paypal","swift", "ios", "hiring", "swift", "abcd", "paypal"]
 let w1 = "paypal"
 let w2 = "swift"
 
 print(Solution_minDistance().minDistance(S,w1:w1,w2:w2))
 */

/***********************************************************************************/

/*
 [ 'p', 'e', 'r', 'f', 'e', 'c', 't', '  ', 'm', 'a', 'k', 'e', 's', '  ',
 'p', 'r', 'a', 'c', 't', 'i', 'c', 'e' ]
 
 
 ['p', 'r', 'a', 'c', 't', 'i', 'c', 'e', '  ',
 'm', 'a', 'k', 'e', 's', '  ',
 'p', 'e', 'r', 'f', 'e', 'c', 't' ]
 
 */

/*
 o(n)  + o(n)  + .... => O(n)
 
 arrr of string => ["practice", "makes", "perfect"]
 
 revere the array => ["perfect", "makes", "practice"]
 
 ['p', 'r', 'a', 'c', 't', 'i', 'c', 'e', ' '
 'm', 'a', 'k', 'e', 's', ' ' ,
 'p', 'e', 'r', 'f', 'e', 'c', 't' ]
 
 */

class Solution1_reverseWords {
    func reverseWords(arr: [Character]) -> [Character] {
        
        var word:[Character] = []
        
        var words:[String] = []
        
        for ch in arr {
            if ch == " " {
                words.insert(String(word), at:0)
                word.removeAll()
            } else {
                word.append(ch)
            }
        }
        
        words.append(String(word))
        word.removeAll()
        
        var result:[Character] = []
        
        for (i,word) in words.enumerated() {
            
            var wordChars = Array(word)
            wordChars.append(" ")
            
            if i == words.count - 1 {
                wordChars.removeLast()
            }
            
            result.append(contentsOf: wordChars)
        }
        
        return result
        
    }
}

// print(Solution1_reverseWords().reverseWords(arr:Array("practice makes perfect")))

/***********************************************************************************/

class Solution_sumNumbers {
    func sumNumbers(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }
        return self.sumNumbers(root,0)
    }
    
    func sumNumbers(_ node:TreeNode,_ sum:Int) -> Int {
        
        let nextSum = sum * 10 + node.val
        
        var leftSum = 0
        if let leftNode = node.left {
            leftSum = self.sumNumbers(leftNode, nextSum)
        }
        
        var rightSum = 0
        if let rightNode = node.right {
            rightSum = self.sumNumbers(rightNode, nextSum)
        }
        
        return max(leftSum + rightSum, nextSum)
    }
}

//let input = createBinaryTree(with: [])
//print(Solution_sumNumbers().sumNumbers(input))

class PrampSolution {
    func arrayOfArrayProducts(arr: [Int]) -> [Int] {
        
        guard arr.count > 1 else {
            return []
        }
        
        // forward
        var fMulti:[Int] = []
        var product = 1
        for val in arr {
            product = product * val
            fMulti.append(product)
        }
        
        // backward
        var bMulti:[Int] = [Int](repeating: 1, count: arr.count)
        product = 1
        for (i,val) in arr.enumerated().reversed() {
            product = product * val
            bMulti[i] = product
        }
        
        // collect result
        var result:[Int] = []
        for (i,_) in arr.enumerated() {
            
            if i == 0 {
                result.append(bMulti[i+1])
                continue
            }
            
            if i == arr.count - 1 {
                result.append(fMulti[i-1])
                continue
            }
            
            result.append(fMulti[i-1] * bMulti[i+1])
        }
        
        return result
    }
}

//let input = [8, 10, 2]
//print(PrampSolution().arrayOfArrayProducts(arr:input))

/***********************************************************************************/

// 74. Search a 2D Matrix

class Solution_searchMatrix {
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        if matrix.count > 0 && matrix[0].count > 0 {
            let count = matrix[0].count * matrix.count - 1
            return self.binSearch(in: matrix, target: target, start: 0, end: count)
        } else {
            return false
        }
    }
    
    private func binSearch(in matrix:[[Int]], target:Int, start:Int, end:Int) -> Bool {
        
        if start > end { // start = 0 , end = 12
            return false
        }
        
        let count = matrix[0].count // 5
        let midIndex = (start+end)/2 // 6
        let midI = midIndex / count // 1
        let midJ = midIndex % count // 1
        
        let midValue = matrix[midI][midJ] // matrix[1][1] = 5
        
        if midValue == target {
            print("\(midI),\(midJ)")
            return true
        } else if target > midValue { // 5 > 9 , false
            // search in upper half
            return self.binSearch(in: matrix, target: target, start: midIndex+1, end: end)
        } else {
            // search in lower half
            return self.binSearch(in: matrix, target: target, start: start, end: midIndex-1) // start = 0, end = 12
        }
    }
}

/*
 let matrix:[[Int]] = [
 [1,   4,  7, 11, 15],
 [2,   5,  8, 12, 19],
 [3,   6,  9, 16, 22],
 [10, 13, 14, 17, 24],
 [18, 21, 23, 26, 30]
 ]
 let target = 5
 print(Solution_searchMatrix().searchMatrix(matrix, target))
 */


/***********************************************************************************/

class PrampSolution_isMatchPattern {
    func isMatch(text: String, pattern: String) -> Bool {
        
        let patternChars = Array(pattern)
        
        // j is pattern index runner
        var j = 0
        for ch in text {
            if j + 1 > pattern.count && patternChars[j+1] == "*" {
                if ch != patternChars[j] {
                    j = j + 2
                }
            } else if ch == patternChars[j] || patternChars[j] == "." {
                j = j + 1
            } else {
                return false
            }
        }
        
        return true
    }
}

// "aa", "aa" -> true
// "a.", "ab" -> true
// "abc" "ab*c" -> true
// "abbb" "ab*"  -> true

class LongRunningTask {
    
    func performBackgroundTask(id: Int, completion: @escaping (String) -> Void) {
        DispatchQueue.global().async {
            let range = 1...5
            let randomInt = Int.random(in: range)
            
            sleep(UInt32(randomInt))
            
            let result = " id: \(id) ran for \(randomInt) seconds"
            completion(result)
        }
    }
}

class BucketSort {
    func sortSequential(inputArr: [Int]) -> [Int] {
        sortBucketsSequential(buckets: collectIntsIntoBucket(arr: inputArr))
    }
    
    func sortParallell(inputArr: [Int]) -> [Int] {
        sortBucketsInParallel(buckets: collectIntsIntoBucket(arr: inputArr))
    }
    
    private func collectIntsIntoBucket(arr: [Int]) -> [Int: [Int]] {
        var buckets: [Int: [Int]] = [:]
        
        for item in arr {
            
            let bucketIndex = item / 10
            
            if var existingArr = buckets[bucketIndex] {
                existingArr.append(item)
                buckets[bucketIndex] = existingArr
            } else {
                buckets[bucketIndex] = [item]
            }
            
        }
        
        return buckets
    }
    
    private func getTwoDArray(size: Int) -> [[Int]] {
        var arr:[[Int]] = [[Int]]()
        
        for _ in 0...size-1 {
            arr.append([Int]())
        }
        
        return arr
    }
    
    private func sortBucketsInParallel(buckets: [Int: [Int]]) -> [Int] {
        
        let concurrentQueue = DispatchQueue.global()
        let dg = DispatchGroup()
        
        var twoDArray = getTwoDArray(size: 10)
        
        for i in 0...9 {
            if let items = buckets[i] {
                
                dg.enter()
                
                concurrentQueue.async {
                    twoDArray[i] = items.sorted()
                    dg.leave()
                }
            }
        }
        
        
        var result: [Int] = []
        
        dg.notify(queue: .main) {
            for arr in twoDArray {
                result.append(contentsOf: arr)
            }
        }
        
        return result
    }
    
    private func sortBucketsSequential(buckets: [Int: [Int]]) -> [Int] {
        var result: [Int] = []
        
        for i in 0...9 {
            if let sorted = buckets[i]?.sorted() {
                result.append(contentsOf: sorted)
            }
        }
        
        return result
    }
}

/*
 let imppp = RandomIntFactory().getRandomInts(size: 1000000, min: 0, max: 99)
 
 let (ress, timeTakenSequential) = measureTime {
 BucketSort().sortSequential(inputArr: imppp)
 }
 
 print("timeTakenSequential : \(timeTakenSequential)")
 
 let (resParallel, timeTakenParallel) = measureTime {
 radixSort(imppp)
 }
 
 print("timeTakenParallel : \(timeTakenParallel)")
 
 */

/*
 let queue = DispatchQueue(label: "com.example.queue")
 
 queue.async {
 for i in 1...5 {
 print("A - \(i)")
 }
 }
 
 queue.async {
 for i in 6...10 {
 print("B - \(i)")
 }
 }
 
 print("end of it")
 
 */

/*
 let startDate = Date.now
 aBusyFunc()
 let endData = Date.now
 
 DateDiffLogger.secondsDifferenceBetweenDates(startDate: startDate, endDate: endData)
 */

//struct First {
//    let second: Second
//
//    init(second: Second) {
//        self.second = second
//    }
//}
//
//struct Second {
//    let first: First
//
//    init(first: First) {
//        self.first = first
//    }
//}


//let first = First(second: Second(first: <#T##First#>))

/*
 
 let hashedPassword = hashPassword("Fisker01!")
 
 print("Hashed password: \(hashedPassword)")
 
 if authenticateUser(
 username: "exampleUser",
 password: "Fisker01!",
 hashedPassword: hashedPassword
 ) {
 print("Authentication successful")
 } else {
 print("Authentication failed")
 }
 
 print("")
 
 print(hashPassword("1"))
 print(hashPassword("1"))
 */

/*
 class DataImporter {
 var filename = "data.txt"
 }
 
 struct Point: Hashable {
 var x: Int
 var y: Int
 
 lazy var importer = DataImporter()
 }
 
 let aPoint = Point(x: 1, y: 2)
 print(aPoint.hashValue)
 */


/*
 let result = await fetchData()
 print("Fetched data: \(result)")
 */

// 1 3 0 1 0 1 0 12 0 0 0 1

// glider test 1. move zero items to end without modifying the order of non-zero items, also
// do all this in place array(without using extra storage)

func moveZeroes(_ arr: inout [Int]) {
    
    var lastZeroIndex = -1
    
    for (i,item) in arr.enumerated() {
        if item != 0 {
            if lastZeroIndex > -1 {
                arr.swapAt(i, lastZeroIndex)
                lastZeroIndex = lastZeroIndex + 1
            }
        } else {
            if lastZeroIndex == -1 {
                lastZeroIndex = i
            }
        }
    }
}

func moveNonZeroToLastInPlace(items: inout [Int]) {
    
    var zeroPosToSwap = -1
    
    for (i,item) in items.enumerated() {
        
        if item == 0 && zeroPosToSwap == -1 {
            zeroPosToSwap = i
            continue
        }
        
        if item != 0 && zeroPosToSwap > -1  {
            
            items[zeroPosToSwap] = item
            items[i] = 0
            zeroPosToSwap += 1
            
        }
    }
    
}


// glider test 2 find total number of prime number under some number

/*
 var input = [1, 3, 0, 5, 0, 7, 0, 12, 0, 0, 0, 14]
 moveNonZeroToLastInPlace(items: &input)
 */

struct Player: Equatable {
    let playerName: String
    let rank: Int
    let score: Double
    let rating: Int
}

// priority rank, score, rating
func sortPlayersLong(_ players: [Player]) -> [Player] {
    
    let sortedRank = players.sorted { $0.rank < $1.rank }
    
    let sortedScore = sortedRank.sorted {
        if $0.rank == $1.rank {
            return $0.score > $1.score
        } else {
            return false
        }
    }
    
    return sortedScore.sorted {
        if $0.rank == $1.rank && $0.score == $0.score {
            return $0.rating > $1.rating
        } else {
            return false
        }
    }
}

func sortPlayers(_ players: [Player]) -> [Player] {
    players.sorted {
        if $0.rank != $1.rank {
            return $0.rank < $1.rank
        } else if $0.score != $1.score {
            return $0.score > $1.score
        } else {
            return $0.rating > $1.rating
        }
    }
}

/*
 let a = Player(playerName: "Hari", rank: 1, score: 10.5, rating: 1)
 let b = Player(playerName: "Krishna", rank: 2, score: 10.5, rating: 2)
 let c = Player(playerName: "Bista", rank: 1, score: 11, rating: 3)
 let d = Player(playerName: "H", rank: 2, score: 10.5, rating: 6)
 
 let res1 = sortPlayers([a,b,c,d])
 let res2 = sortPlayersLong([a,b,c,d])
 
 print(res1 == res2)
 */

/*
 fibonaci series
 0 1
 0 1 1 2 3 5 8
 */

func fibonaci(limit: Int) -> [Int] {
    
    var fibSeries: [Int] = []
    
    var first = 0
    var second = 1
    
    var tempSum = first + second
    
    fibSeries.append(first)
    fibSeries.append(second)
    
    while first + second < limit {
        tempSum = first + second
        
        fibSeries.append(tempSum)
        
        first = second
        second = tempSum
    }
    
    return fibSeries
}

/*
 let fibSeries = fibonaci(limit: 30)
 for item in fibSeries {
 print(item)
 }
 */

// abcdef -> fedcba

// Hari -> irah
// exchange 0 and (count-1)
// exchange 1 and (count-2)

// ...
// ...
// exchange i'th and (count-i)'th item

// loop runs 0 to (count/2-1)

// Harik
//

func stringResersal1(str: String) -> String {
    
    var charArr = Array(str)
    
    var result = charArr
    result.removeAll()
    
    while charArr.isEmpty == false {
        result.append(charArr.removeLast())
    }
    
    return String(result)
}

func stringResersal2(str: String) -> String {
    
    var charArr = Array(str)
    
    var i = 0
    
    while i < charArr.count/2 {
        
        let temp = charArr[i]
        charArr[i] = charArr[charArr.count-1-i]
        charArr[charArr.count-1-i] = temp
        
        i = i + 1
    }
    
    return String(charArr)
}


/*
 print(stringResersal1(str: "abcdef"))
 print(stringResersal2(str: "abcdef"))
 */


// Integer to Roman on leetcode question

/*
 Symbol    Value
 I         1
 V         5
 X         10
 L         50
 C         100
 D         500
 M         1000
 */

/*
 
 3 = iii
 4 = iv
 5 = v
 6 = vi
 7 = viii
 
 8 = viii
 9 = ix
 
 */

/*
 Input: nums = [8,7,11,15,1], target = 9
 Output: [0,1]
 Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].
 */

/*
 
 dict
 [
 1:0,
 2:1,
 -2:2,
 -6:3
 ]
 
 
 */

class Solution_twoSum1 {
    
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        
        var dict: [Int : Int] = [:]
        
        for (i,num) in nums.enumerated() {
            
            let diff = target - num
            
            if let index = dict[num] {
                return [index, i]
            }
            
            dict[diff] = i
        }
        
        return []
    }
    
}

/*
 print(Solution_twoSum().twoSum([8,1,1,15,1,7], 9))
 
 https://leetcode.com/problems/rotate-array/description/
 
 Given an integer array nums, rotate the array to the right by k steps, where k is non-negative.
 
 */

/*
 
 Input: nums = [1,2,3,4,5,6,7], k = 3
 Output: [5,6,7,1,2,3,4]
 Explanation:
 rotate 1 steps to the right: [7,1,2,3,4,5,6]
 rotate 2 steps to the right: [6,7,1,2,3,4,5]
 rotate 3 steps to the right: [5,6,7,1,2,3,4]
 
 */

/*
 
 temp = 6
 [7,1,2,3,4,5,6]
 
 [7,7,1,2,3,4,5]
 [7,7,1,2,3,4,5]
 
 */

class Solution_rotate1 {
    
    func rotate(_ nums: inout [Int], _ k: Int) {
        for _ in 0...(k-1) {
            shift(arr: &nums)
        }
    }
    
    private func shift(arr: inout [Int]) {
        
        guard arr.count > 0 else { return }
        
        let temp = arr[arr.count-1]
        
        var index = arr.count-1
        
        while index > 0 {
            arr[index] = arr[index-1]
            index = index - 1
        }
        
        arr[0] = temp
    }
}

/*
 [1,2,3,4,5,6,7]
 0 1 2 ..
 
 "Hari", "Krishna", "Bista"
 */

class Solution_rotate2 {
    func rotate(_ nums: inout [Int], _ k: Int) {
        
        var newArr = [Int](repeating: 0, count: nums.count)
        
        for (i, num) in nums.enumerated() {
            
            var newIndex = i + k
            if newIndex > (nums.count-1) {
                newIndex = newIndex - nums.count
            }
            
            newArr[newIndex] = num
        }
        
        nums = newArr
    }
}

/*
 var input_nums1 = [1,2,3,4,5,6,7]
 Solution_rotate1().rotate(&input_nums, 3)
 print(input_nums)
 */

// [1,2,3,4,5,6,7], 3
// [_,_,_,1,2,3,4], 5,6,7

/*
 var input_nums1 = [1,2,3,4,5,6,7]
 Solution_rotate2().rotate(&input_nums1, 3)
 print(input_nums1)
 */

class Solution_powerSet1 {
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
        
        print(item, result)
        
        for items in result {
            var newItems = items
            newItems.append(item)
            result.append(newItems)
        }
    }
}

// let res = Solution_powerSet1().subsets([1,2,3])


/*
 Write a program that prints the numbers from 1 to n. But for multiples of three, print "Fizz" instead of the number,
 and for the multiples of five, print "Buzz". For numbers that are multiples of both three and five, print "FizzBuzz".
 */

func fizzBuzz(n: Int) {
    
    for number in 1...n {
        
        if number % (3*5) == 0 {
            print("FizzBuzz")
        } else if number % 3 == 0 {
            print("Fizz")
        } else if number % 5 == 0 {
            print("Buzz")
        }
    }
    
}

//fizzBuzz(n: 100)

// "listen" and "silent" are anagrams
func areAnagrams(_ str1: String, _ str2: String) -> Bool {
    str1.sorted() == str2.sorted()
}


class Solution_findAnagrams {
    func findAnagrams(_ s: String, _ p: String) -> [Int] {
        
        guard s.count >= p.count else { return [] }
        
        let strings = getAllSubStrings(str: s, subStringSize: p.count)
        
        let key = p.sorted()
        
        var result: [Int] = []
        
        for (i,str) in strings.enumerated() {
            if str.sorted() == key {
                result.append(i)
            }
        }
        
        return result
    }
    
    private func getAllSubStrings(str: String, subStringSize: Int) -> [String] {
        var result: [String] = []
        
        for i in 0...(str.count - subStringSize) {
            let subStr = getSubString(fromStr: str, startIndex: i, length: subStringSize)
            result.append(subStr)
        }
        
        return result
    }
    
    private func getSubString(fromStr: String, startIndex: Int, length: Int) -> String {
        
        var result: [Character] = []
        
        let charArr = Array(fromStr)
        
        for i in startIndex...(startIndex + length - 1) {
            result.append(charArr[i])
        }
        
        return String(result)
    }
}

//print(Solution_findAnagrams().findAnagrams("cbaebabacd", "abc"))
//print(Solution_findAnagrams().findAnagrams("abab", "ab"))

//print(getSubString(fromStr: "Harik", startIndex: 0, length: 3) == "Har")
//print(getSubString(fromStr: "Harik", startIndex: 1, length: 4) == "arik")

func solution(
    _ start: [Int],
    _ dest: [Int],
    _ limit: [Int]
) -> Int {
    var maxStation = 0
    var totalFee = 0
    
    for i in 0..<start.count {
        let startStation = min(start[i], dest[i])
        let endStation = max(start[i], dest[i])
        
        totalFee = totalFee + (endStation - startStation) * 2
        
        maxStation = max(maxStation, endStation)
    }
    
    totalFee = totalFee + start.count * 1
    
    return min(totalFee, limit[maxStation])
}

/*
 let start = [1, 0, 2, 4]
 let dest = [2, 2, 0, 5]
 
 let limit = [3, 17, 7, 4, 5, 17]
 
 print(solution(start, dest, limit))
 */


/*
 
 
 let T = [3,1,2]
 
 doneCounter = 3
 
 var workRecord = [2,0,1,1,0,0]
 
 while doneCounter > 3 {
 T = process(T)
 }
 
 func process(T) -> T {
 
 }
 
 let result = scan(workRecord)
 
 h  h  h
 T = [3, 1, 2]
 2  0  1 -> [2,1]
 1     0 -> [1]
 0       -> []
 
 2 0 1 1 0 0
 
 */


class SolutionT {
    
    func calculateTotalWaitHours(hours: [Int]) -> Int {
        
        var remHours: [Int] = hours
        
        var completedRecords: [Int] = []
        
        while !remHours.isEmpty {
            
            var nextHours: [Int] = []
            
            for hr in remHours {
                let remHour = hr - 1
                
                if remHour > 0 {
                    nextHours.append(remHour)
                }
                
                completedRecords.append(remHour)
            }
            
            remHours = nextHours
        }
        
        return getTotalHours(record: completedRecords)
    }
    
    // [2,0,1,1,0,0]
    func getTotalHours(record: [Int]) -> Int {
        var totalHours = 0
        for (i,number) in record.enumerated() {
            if number == 0 {
                totalHours += (i + 1)
            }
        }
        return totalHours
    }
}

/*
 let res = SolutionT().calculateTotalWaitHours(hours: [3,1,2])
 print(res)
 */

class Solution_isValidSudoku {
    
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        isRowsValid(board: board) && isColumnsValid(board: board)
    }
    
    func isRowsValid(board: [[Character]]) -> Bool {
        for row in board {
            if isItemsUnique(items: row) == false {
                return false
            }
        }
        return true
    }
    
    func isColumnsValid(board: [[Character]]) -> Bool {
        var col = 0
        let size = board.count
        
        while col < size {
            
            var tempItems: [Character] = []
            
            for row in 0..<size {
                let item = board[row][col]
                tempItems.append(item)
            }
            
            if isItemsUnique(items: tempItems) == false {
                return false
            }
            
            col = col + 1
            
        }
        
        return true
    }
    
    
    
    func isItemsUnique (items: [Character]) -> Bool {
        
        var seen = Set<Character>()
        
        for item in items {
            if seen.contains(item) {
                return false
            }
            
            if item != "." {
                seen.insert(item)
            }
        }
        
        return true
    }
}


//print(Solution_isValidSudoku().isValidSudoku(sodukuGrid))

import Darwin

func isValidSudoku(_ board: [[Character]]) -> Bool {
    
    let boardSize = board.count
    
    var rows = Array(repeating: Set<Character>(), count: boardSize)
    var columns = Array(repeating: Set<Character>(), count: boardSize)
    
    var boxes = Array(repeating: Set<Character>(), count: boardSize)
    var boxCounter = 0
    
    let miniBoardSize = Int(sqrt(Double(boardSize)))
    
    for i in 0..<boardSize {
        for j in 0..<boardSize {
            let char = board[i][j]
            
            if char != "." {
                if rows[i].contains(char) || columns[j].contains(char) || boxes[j / miniBoardSize].contains(char) {
                    return false
                }
                
                rows[i].insert(char)
                columns[j].insert(char)
                
                boxes[j / miniBoardSize].insert(char)
            }
            
            boxCounter = boxCounter + 1
            
            if boxCounter == boardSize * miniBoardSize {
                boxCounter = 0
                boxes = Array(repeating: Set<Character>(), count: 3)
            }
        }
    }
    
    return true
}

let sodukuGrid:[[Character]] =
[
    ["5","3",".",".","7",".",".",".","."],
    ["6",".",".","1","9","5",".",".","."],
    [".","9","8",".",".",".",".","6","."],
    ["8",".",".",".","6",".",".",".","3"],
    ["4",".",".","8",".","3",".",".","1"],
    ["7",".",".",".","2",".",".",".","6"],
    [".","6",".",".",".",".","2","8","."],
    [".",".",".","4","1","9",".",".","5"],
    [".",".",".",".","8",".",".","7","9"]
]

func characterMatrix(_ matrix: [[Character]]) {
    
    for i in 0..<matrix.count {
        
        for j in 0..<matrix[i].count {
            if i % 3 == 0 && j % 3 == 0 {
                print("🟢 [\(i),\(j)] - \(matrix[i][j])", terminator: "  ")
            } else {
                print("💜 (\(i),\(j)) - \(matrix[i][j])", terminator: "  ")
            }
        }
        print("")
        print("")
    }
    
}

/*
 characterMatrix(sodukuGrid)
 print(isValidSudoku(sodukuGrid))
 */


// 1 -> 2 -> 3 -> 4 -> 5 -> 6
// tempNext
// 1 <- 2     3 -> 4 -> 5 -> 6

// c    n
// 1 -> 2 -> 3 -> 4 -> 5 -> 6
//      c  n    nn
// 1 <- 2  3 -> 4 -> 5 -> 6
//      c    n  nn
// 1 <- 2 <- 3  4 -> 5 -> 6
//           c  n
// 1 <- 2 <- 3  4

func revLinkedList(linkedList: ListNode?) -> ListNode? {
    
    if linkedList == nil || linkedList?.next == nil {
        return linkedList
    }
    
    var c = linkedList
    var n = c?.next
    
    linkedList?.next = nil
    
    while n?.next != nil {
        
        let futureN = n?.next
        n?.next = c
        
        c = n
        c?.next = n?.next
        
        n = futureN
        
    }
    
    n?.next = c
    
    return n
}

/*
 let inputLinkedList = LinkedListFactory.convertArrayToLinkedList(arr: [1,2,3,4,5,6,7,8])
 
 if let revLinkedList = revLinkedList(linkedList: inputLinkedList) {
 let arr = LinkedListFactory.convertLinkedListToArray(list: revLinkedList)
 print(arr)
 }
 */

class Solution_FindHighCountZerosInBinString {
    func findHighCount1(_ N: Int) -> Int {
        let binStr = convertIntoBinary(N)
        
        var highCount = 0
        var tempCount = 0
        
        for char in binStr {
            
            if char == "0" {
                tempCount = tempCount + 1
            } else if char == "1" {
                if tempCount > highCount {
                    highCount = tempCount
                }
                tempCount = 0
            }
            
        }
        
        return highCount
    }
    
    private func convertIntoBinary(_ N: Int) -> String {
        
        guard N > 0 else { return "0" }
        
        var result = ""
        
        var val = N
        
        while val > 0 {
            
            result = "\(val % 2)" + result
            
            val = val / 2
            
        }
        
        return result
        
    }
    
    private func findHighCount2(_ N: Int) -> Int {
        var highCount = 0
        
        guard N > 0 else { return highCount }
        
        var val = N
        
        var tempCount = 0
        
        var initial1Found = false
        
        while val > 0 {
            
            let rem = val % 2
            
            val = val / 2
            
            if initial1Found == false {
                if rem == 1 {
                    initial1Found = true
                }
                continue
            }
            
            if rem == 0 {
                tempCount = tempCount + 1
            } else {
                
                if highCount < tempCount {
                    highCount = tempCount
                }
                tempCount = 0
            }
        }
        
        return highCount
    }
}


/*
 
 print(Solution_FindHighCountZerosInBinString().findHighCount1(32))
 print(solutionMe(32))
 
 */

class Solution_toRoman {
    func toRoman(number: Int) -> String {
        
        let conversions = ArabicRomanConversion.conversions
        
        var romanValue = ""
        var remaining = number
        
        for conversion in conversions {
            
            let quotient = remaining / conversion.arabic
            
            if quotient > 0 {
                for _ in 0..<quotient {
                    romanValue += conversion.roman
                }
                remaining -= conversion.arabic * quotient
            }
        }
        
        return romanValue
    }
}


/*
 print(Solution_toRoman(number: 950) == "CML")
 print(Solution_toRoman(number: 857) == "DCCCLVII")
 */

/*
 let romanValues = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
 let arabicValues = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
 
 for (i,item) in arabicValues.enumerated() {
 print("Conversion(arabic: \(item), roman: \"\(romanValues[i])\"),")
 }
 */




import Foundation

// 1 product
// sell on high , buy on each low
// max([ 1, 2, 3, 3, 2, 1, 5, 6, 5 ])
//          i, i, i, d, d,

// [1, 2, 3, 4, 2]

class Solution_maximumGain {
    public func maximumGain(_ A : inout [Int]) -> Int {
        
        var sum = 0
        
        if A[0] < A[1] {
            // buy
            sum = sum - A[0]
        }
        
        if A[0] > A[1] {
            // sell
            sum = sum + A[0]
        }
        
        for (i,price) in A.enumerated() {
            
            // don't worry about 1st and last item
            if i == 0 || i == A.count - 1 {
                continue
            }
            
            if A[i-1] > A[i] && A[i] < A[i+1] {
                // low point
                sum = sum - A[i]
            }
            
            if A[i-1] < A[i] && A[i] > A[i+1] {
                // high point
                sum = sum + A[i]
            }
        }
        
        let lastIndex = A.count - 1
        
        if A[lastIndex] > A[lastIndex-1] {
            sum = sum + A[lastIndex]
        }
        
        return sum
        
    }
}



/*
 var prices = [5,3,3,2,1]
 print(Solution_maximumGain().maximumGain(&prices))
 */

// ["flower","flow","flight"]
class Solution_longestCommonPrefix3 {
    func longestCommonPrefix(_ strs: [String]) -> String {
        
        guard strs.count > 0 else { return "" }
        
        var commonPrefix = strs[0]
        
        for str in strs {
            
            if str == "" {
                commonPrefix = ""
                break
            }
            
            commonPrefix = getCommonPrefix(str1: commonPrefix, str2: str)
            
            if commonPrefix == "" {
                break
            }
            
        }
        
        return commonPrefix
    }
    
    func getCommonPrefix(str1: String, str2: String) -> String {
        
        let charArrStr1 = Array(str1)
        let charArrStr2 = Array(str2)
        
        let minCount = min(charArrStr1.count, charArrStr2.count)
        
        var charArrResult: [Character] = []
        
        for i in 0...(minCount - 1) {
            if charArrStr1[i] == charArrStr2[i] {
                charArrResult.append(charArrStr1[i])
            } else {
                break
            }
        }
        
        return String(charArrResult)
    }
}

//print(Solution_longestCommonPrefix3().longestCommonPrefix([""]))

class Solution_searchInsert1 {
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        
        if target > nums[nums.count - 1] {
            return nums.count
        }
        
        if target < nums[0] {
            return 0
        }
        
        var l = 0
        var u = nums.count - 1
        
        var m = 0
        
        while l <= u {
            
            m = (l+u)/2
            
            if nums[m] == target {
                return m
            }
            
            if nums[m] < target {
                l = m + 1
            }
            
            if target < nums[m] {
                u = m - 1
            }
            
        }
        
        return u+1
    }
}

/*
 print(Solution_searchInsert1().searchInsert([1,3,5,6], 5))
 print(Solution_searchInsert1().searchInsert([1,3,5,6], 2))
 print(Solution_searchInsert1().searchInsert([1,3], 2))
 */

protocol Queue {
    
    associatedtype T
    
    func add(item: T)
    var maxSize: Int { get }
    
}

extension Queue {
    var maxSize: Int {
        return 0
    }
}

struct MyQueue: Queue {
    typealias T = Int
    
    func add(item: T) {
        
    }
}

//let mQueue = MyQueue()

func swap(_ first: inout Any,_ second: inout Any) {
    let temp = first
    first = second
    second = temp
}

//var a = "1"
//var b = "2"
//
//swap(&a, &b)

// "luffy is still joyboy"

class Solution_lengthOfLastWord2 {
    func lengthOfLastWord(_ s: String) -> Int {
        
        let trimmedS = s.trimmingCharacters(in: .whitespaces)
        
        let charArr = Array(trimmedS)
        
        var i = charArr.count - 1
        
        var count = 0
        while i >= 0 {
            if charArr[i] != " " {
                count = count + 1
            } else {
                break
            }
            
            i = i - 1
        }
        
        return count
    }
}

//print(Solution_lengthOfLastWord2().lengthOfLastWord("luffy is still joyboy"))
//print(Solution_lengthOfLastWord2().lengthOfLastWord("   fly me   to   the moon  "))
//print(Solution_lengthOfLastWord2().lengthOfLastWord("Hello World"))

// https://leetcode.com/problems/find-the-index-of-the-first-occurrence-in-a-string/

class Solution_FirstOccurance1 {
    func strStr(_ haystack: String, _ needle: String) -> Int {
        
        guard haystack.count >= needle.count else { return -1 }
        
        let charArrHaystack = Array(haystack)
        let charArrNeedle = Array(needle)
        
        for (i, _) in charArrHaystack.enumerated() {
            
            if i > charArrHaystack.count - charArrNeedle.count {
                return -1
            }
            
            if isNeedleMatch(
                charArrHaystack: charArrHaystack,
                currentIndex: i,
                charArrNeedle: charArrNeedle
            ) {
                return i
            }
            
        }
        
        return -1
    }
    
    func isNeedleMatch(
        charArrHaystack: [Character],
        currentIndex: Int,
        charArrNeedle: [Character]
    ) -> Bool {
        var i = currentIndex
        for ch in charArrNeedle {
            if ch != charArrHaystack[i] {
                return false
            }
            i = i + 1
        }
        
        return true
    }
}

// print(Solution_FirstOccurance1().strStr("a", "a"))



/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init() { self.val = 0; self.next = nil; }
 *     public init(_ val: Int) { self.val = val; self.next = nil; }
 *     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 * }
 */

//
// list1 = [1,2,4, 5, 6, 7, 8, 9, 10, 11], list2 = [1,3,4, 20, 24]
//          0 1 2 ...        0 1 2 ...
//  1 1 2 3 4 4 5 6

// list1 = [1->2->4],
// list2 = 1->3->4
// result = 1->1->2
//
//

class Solution_lengthOfLongestSubstring {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        
        var highCount = 0
        
        let charArr = Array(s)
        
        for (i,_) in charArr.enumerated() {
            let newCount = getNonRepeatedCount(from: i, ofCharArr: charArr)
            
            if newCount > highCount {
                highCount = newCount
            }
        }
        
        return highCount
    }
    
    private func getNonRepeatedCount(from: Int, ofCharArr: [Character]) -> Int {
        
        var aSet: Set<Character> = Set<Character>()
        
        for i in from...(ofCharArr.count-1) {
            
            let ch = ofCharArr[i]
            
            if aSet.contains(ch) {
                return aSet.count
            }
            
            aSet.insert(ch)
        }
        
        return aSet.count
    }
}

/*
 print(Solution_lengthOfLongestSubstring().lengthOfLongestSubstring("abcabcbb"))
 print(Solution_lengthOfLongestSubstring().lengthOfLongestSubstring("bbbbb"))
 print(Solution_lengthOfLongestSubstring().lengthOfLongestSubstring("pwwkew"))
 */

// 121
/*
 
 121 / 100 -> 1
 121 % 10 -> 1
 
 12321 / 10000 -> 1
 12321 % 10 -> 1
 
 3443 / 1000 -> 3
 
 3443 - 1000*3 = 443
 
 443 / 10 = 44
 
 3445 / 10 -> 5
 
 
 nope
 
 */

// 1221
// 12321
//

func evaluateExpression(_ s: String) -> Int {
    func operate(_ a: Int, _ b: Int, _ op: Character) -> Int {
        switch op {
        case "+":
            return a + b
        case "-":
            return a - b
        case "*":
            return a * b
        case "/":
            return a / b
        default:
            return 0
        }
    }
    
    var stack = [Int]()
    var currentNum = 0
    var currentOp: Character = "+"
    let expression = s + "+"
    
    for char in expression {
        if let digit = char.wholeNumberValue {
            currentNum = currentNum * 10 + digit
        } else if char == "+" || char == "-" || char == "*" || char == "/" {
            switch currentOp {
            case "+":
                stack.append(currentNum)
            case "-":
                stack.append(-currentNum)
            case "*", "/":
                let lastNum = stack.removeLast()
                stack.append(operate(lastNum, currentNum, currentOp))
            default:
                break
            }
            currentNum = 0
            currentOp = char
        }
    }
    
    return stack.reduce(0, +)
}

//let expression = "5+3-1*6/2+1-4"
//let result = evaluateExpression(expression)
//print("\(expression) -> \(result)")


// 1 + 1*2*3*4/4 - 4

func evalUnit(a:Int, op: String, b:Int) -> Int {
    
    var result = 0
    
    switch op {
    case "-":
        result = a - b
    case "+":
        result = a + b
    case "*":
        result = a * b
    case "/":
        result = a / b
    default:
        result = 0
    }
    
    return result
}

func calculate(_ s: String) -> Int {
    
    var stack: [Int] = []
    var lastRes = 0
    var lastOp = "+"
    for ch in s {
        
        if ch == "+" || ch == "-" || ch == "*" || ch == "/" {
            if ch == "+" || ch == "-" {
                if lastRes > 0 {
                    stack.append(lastRes)
                }
                
                lastRes = 0
            }
            
            lastOp = String(ch)
            
        } else if let chInt = Int(String(ch)) {
            
            if lastOp == "/" || lastOp == "*" {
                if lastRes == 0 {
                    lastRes = stack.removeLast()
                }
                lastRes = evalUnit(a: lastRes, op: lastOp, b: chInt)
            }
            
            if lastOp == "-" {
                stack.append(-chInt)
            } else if lastOp == "+" {
                stack.append(chInt)
            }
        }
        
    }
    
    if lastRes > 0 {
        stack.append(lastRes)
    }
    
    return stack.reduce(0, +)
}

//print(evalExpression(s: "5+1-2*2/2-2"))
//print(evalExpression(s: "5+1"))
//print(calculate("32"))


/*
 """
 Absolute Value Sort
 
 Given an array of integers arr, write a function absSort(arr), that sorts the array according to the absolute values of the numbers in arr.
 If two numbers have the same absolute value, sort them according to sign, where the negative numbers come before the positive numbers.
 
 Examples:
 
 input:  arr = [2, -7, -2, -2, 0]
 
 i = 0, [2, -7, -2, -2, 0]
 smallest = 0, swapPos(0, i) -> [0, -7, -2, -2, 2]
 
 i = 1, [0, -2, -7, -2, 2]
 smallest = -2,
 
 i = 2, [0, -2, -2, -7, 2]
 smallest = -2,
 
 i = 3, [0, -2, -2, 2, -7]
 smallest = -2,
 
 output: [0, -2, -2, 2, -7]
 """
 */

class Solution_sortAbs {
    func sortAbs(_ input: [Int]) -> [Int] {
        var inputEquivalent = input
        
        for (i,_) in inputEquivalent.enumerated() {
            let smallestPos = getPositionForAbsSmallest(fromIndex: i, arr: inputEquivalent)
            swapPos(&inputEquivalent, i: i, j: smallestPos)
        }
        
        return inputEquivalent
    }
    
    func swapPos(_ input: inout [Int], i: Int, j: Int) {
        let temp = input[i]
        input[i] = input[j]
        input[j] = temp
    }
    
    func getPositionForAbsSmallest(fromIndex: Int, arr: [Int]) -> Int {
        
        var smallest = arr[fromIndex]
        var smallestPos = fromIndex
        
        for i in fromIndex...(arr.count - 1) {
            
            if smallest.absVal > arr[i].absVal {
                smallest = arr[i]
                smallestPos = i
            }
        }
        
        return smallestPos
    }
}

// print(Solution_sortAbs().sortAbs([2, -7, -2, -2, 0, 29, -66]))

/*
 
 https://leetcode.com/problems/valid-parentheses/description/
 
 Example 1:
 
 Input: s = "()"
 Output: true
 Example 2:
 
 Input: s = "()[]{}"
 Output: true
 Example 3:
 
 Input: s = "(]"
 Output: false
 
 */

// ()[({})]{}
class Solution_isValidParenthesis {
    
    func isValid(_ s: String) -> Bool {
        
        var stack: [Character] = []
        
        for ch in s {
            if ch == "(" || ch == "{" || ch == "[" {
                stack.append(ch)
            } else {
                // ch is ")" or "}" or "]"
                if stack.count > 0 {
                    if checkBalance(open: stack.removeLast(), close: ch) {
                        
                    } else {
                        return false
                    }
                } else {
                    return false
                }
            }
        }
        
        return stack.count == 0
    }
    
    func checkBalance(open: Character, close: Character) -> Bool {
        
        var result = false
        
        if open == "(" && close == ")" {
            result = true
        }
        
        if open == "{" && close == "}" {
            result = true
        }
        
        if open == "[" && close == "]" {
            result = true
        }
        
        return result
    }
}

/*
 print(Solution_isValidParenthesis().isValid("{{((()))}}({})"))
 print(Solution_isValidParenthesis().isValid("()"))
 print(Solution_isValidParenthesis().isValid("([])"))
 */

/*
 ""
 Find The Duplicates
 
 Given two sorted arrays arr1 and arr2 of passport numbers, implement a function findDuplicates that returns an array of all passport numbers
 that are both in arr1 and arr2. Note that the output array should be sorted in an ascending order.
 
 Let N and M be the lengths of arr1 and arr2, respectively. Solve for two cases and analyze the time & space complexities of your solutions:
 M ≈ N - the array lengths are approximately the same
 M ≫ N - arr2 is much bigger than arr1.
 
 input:  arr1 = [1, 2, 3, 5, 6, 7], arr2 = [3, 6, 7, 8, 20]
 output: [3, 6, 7]
 
 ""
 */

/*
 result [3, 6, 7]
 
 [1, 2, 3, 5, 6, 7]
 i
 
 [3, 6, 7, 8, 20]
 j
 
 */

func findDups(_ arr1: [Int],_ arr2: [Int]) -> [Int] {
    
    var i = 0
    var j = 0
    var result: [Int] = []
    
    while i < arr1.count && j < arr2.count {
        
        let first = arr1[i]
        let second = arr2[j]
        
        if first > second {
            i = i + 1
        } else if second > first {
            j = j + 1
        } else {
            i = i + 1
            j = j + 1
            result.append(first)
        }
    }
    
    return result
}

class Solution_pruneTree {
    
    func pruneTree(_ root: TreeNode?) -> TreeNode? {
        
        guard let root = root else { return nil }
        
        if root.val == 0 && root.left == nil && root.right == nil {
            return nil
        }
        
        if root.left == nil && root.right == nil && root.val == 1 {
            return root
        }
        
        root.left = pruneTree(root.left)
        root.right = pruneTree(root.right)
        
        if root.left == nil && root.right == nil && root.val == 0 {
            return nil
        } else {
            return root
        }
        
    }
    
}

func singleBinSearch(arr: [Int], target: Int) -> Int? {
    
    var l = 0
    var u = arr.count - 1
    
    while l != u {
        
        let m = (l + u)/2
        let mItem = arr[m]
        
        if mItem == target {
            return m
        } else {
            // find out if target is in sorted half or not
            
            // upper fully sorted
            if mItem < arr[u] {
                
                if mItem < target && target < arr[u] {
                    l = m + 1
                } else {
                    u = m - 1
                }
                
            } else {
                // lower fully sorted
                if arr[l] < target && target < mItem {
                    u = m - 1
                } else {
                    l = m + 1
                }
            }
            
        }
        
    }
    
    return nil
}

func binSearch(arr: [Int], target: Int) -> Int? {
    
    var l: Int = 0
    var u: Int = 0
    
    if let pivotIndex = searchPivot(arr: arr) {
        
        if target > arr[u] {
            // 1st sorted arr
            l = 0
            u = pivotIndex - 1
        } else {
            l = pivotIndex
            u = arr.count-1
            // second sorted arr
        }
        
    } else {
        l = 0
        u = arr.count-1
    }
    
    // write binary logic to search
    while l != u {
        let m = (l + u)/2
        
        if arr[m] == target {
            return m
        } else if target < arr[m] {
            u = m - 1
        } else {
            l = m + 1
        }
    }
    
    return nil
}

func searchPivot(arr: [Int]) -> Int? {
    
    var l = 0
    var u = arr.count-1
    
    while l != u {
        
        let m = (l + u)/2
        
        if arr[m-1] > arr[m] || arr[m] < arr[m+1] {
            
            if arr[m-1] > arr[m] {
                return m
            } else {
                return m+1
            }
            
        } else if arr[m] > arr[u] {
            // pivot is in upper half
            l = m
        } else {
            // pivot is in lower half
            u = m
        }
    }
    
    return nil
}


/*
 let concurrentQ = DispatchQueue(label: "dq-concurrent", attributes: .concurrent)
 
 concurrentQ.sync {
 for i in 0...100 {
 print("A")
 }
 }
 
 concurrentQ.sync {
 for i in 0...100 {
 print("A")
 }
 }
 
 try? await Task.sleep(nanoseconds: UInt64(1_000_000_000 * 3))
 
 print("done")
 
 */

class Solution_binSearch {
    func binSearch(arr: [Int], target: Int) -> Int {
        binSearchRec(arr: arr, target: target, l: 0, u: arr.count - 1)
    }
    
    func binSearchRec(arr: [Int], target: Int, l: Int, u: Int) -> Int {
        
        let m = (l + u)/2
        
        if l > u {
            return -1
        } else if target == arr[m] {
            return m
        } else if  arr[m] < target {
            return binSearchRec(arr: arr, target: target, l: m+1, u: u)
        } else {
            return binSearchRec(arr: arr, target: target, l: l, u: m-1)
        }
    }
}

/*
 https://leetcode.com/problems/maximum-subarray/description/
 
 Given an integer array nums, find the subarray with the largest sum, and return its sum.
 nums = [-2,1,-3,4,-1,2,1,-5,4]
 
 
 The subarray [4,-1,2,1] has the largest sum 6.
 
 */

/*
 
 nums =
 
 
 3, m = 3, mh = 3
 1, mh = mh + item = 4, m = 4
 -1, mh = 3, m = 4
 2, mh = 5, m = 5
 3, mh = 8, m = 8
 
 ..................
 
 -1, mh = -1, m = -1
 -7, mh = -8, m = -1
 -1, mh = -9, m = -1
 2, mh = -7, m = -1
 3, mh = -4, m = -1
 
 max = Int.min
 maxHere = Int.min
 
 i = 0, max = 3, maxTillHere =
 i = 1, sum = max(-1,1) = 1
 i = 2,
 
 */

class Solution_maxSubArray1 {
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
            
            print("\(num), mh = \(max_end_here), m = \(max)")
            
            //            -1, mh = -1, m = -1
            //            -7, mh = -8, m = -1
            //            -1, mh = -9, m = -1
            //             2, mh = -7, m = -1
            //             3, mh = -4, m = -1
        }
        return max
    }
}

// print(Solution_maxSubArray1().maxSubArray([-8,-7,-1,-2,-3]))

// eg: 5-3-(1-10) -> 2 + 9 -> 11

// eg: 5+3+(1-10)

// 5 + 3 + 1 - 10

// eg: 5+3-(1-10)
// 5 + 3 - 1 + 10

// if inside bracket and lastOp before bracket is - then

// 5-3-(1-1+2) ......

class Solution_calcExp {
    func calcExpRec(exp: [Character], i: inout Int) -> Int {
        
        var result: [Int] = []
        
        var lastOp = "+"
        var lastChar = ""
        
        while i < exp.count {
            let chStr = String(exp[i])
            
            if lastChar == "(" {
                
                let val = getVal(lastOp: lastOp,val: calcExpRec(exp: exp, i: &i))
                result.append(val)
                
            } else if chStr == ")" {
                break
            } else if let chInt = Int(chStr) {
                
                let item = getVal(lastOp: lastOp, val: chInt)
                result.append(item)
                
            }
            
            if chStr == "+" || chStr == "-" {
                lastOp = chStr
            }
            
            lastChar = chStr
            
            i = i + 1
        }
        
        return result.reduce(0,+)
    }
    
    func calcExp(exp: String) -> Int {
        let charArr = Array(exp)
        var i = 0
        return calcExpRec(exp: charArr, i: &i)
    }
    
    func getVal(lastOp: String, val: Int) -> Int {
        if lastOp == "-" {
            return -val
        } else if lastOp == "+" {
            return val
        }
        return 0
    }
}

// print(Solution_calcExp().calcExp(exp: "1+2-(3-4+(4-2)+4)"))

/*
 let a: Int = Int.max
 let b: Int = 1
 let resultAPlusB = a &+ b
 let aLargeNum = Int.max
 let sum = aLargeNum.addingReportingOverflow(45)
 print(sum)
 */


func calculate(exp: String) -> Int {
    
    var result:[Int] = []
    
    let charArr = Array(exp)
    
    var lastOp = "+"
    
    var isInsideBracket = false
    var lastOpBeforeOpenBracket = ""
    
    var wholeNumber = ""
    
    for ch in charArr {
        
        if ch == "(" {
            
            isInsideBracket = true
            lastOpBeforeOpenBracket = lastOp
            
        } else if ch == ")" {
            isInsideBracket = false
            lastOpBeforeOpenBracket = ""
        }
        
        if ch == "+" || ch == "-" {
            
            var val = Int(wholeNumber) ?? 0
            if lastOp == "-"  {
                val = -val
            }
            
            if isInsideBracket && lastOpBeforeOpenBracket == "-" {
                val = -val
            }
            
            result.append(val)
            
            wholeNumber = ""
            
            lastOp = String(ch)
        }
        
        if Int(String(ch)) != nil {
            wholeNumber.append(ch)
        }
        
    }
    
    return result.reduce(0, +)
}

//print(calculate(exp: "5-5-(1-1+10)+10"))

class Solution_longestSubstring {
    func getLastOccuranceOf(
        ch: Character,
        currI: Int,
        charArr: [Character]
    ) -> Int {
        
        var i = currI-1
        
        while i >= 0 {
            
            if charArr[i] == ch {
                return i
            }
            
            i = i - 1
        }
        
        return 0
    }
    
    func longestSubstring(input: String) -> Int {
        
        let charArr = Array(input)
        
        var highestCount = 0
        var tempCount = 0
        
        var i = 0
        
        var aSet: Set<Character> = Set()
        
        while i < charArr.count {
            
            let ch = charArr[i]
            
            if aSet.contains(ch) {
                
                highestCount = max(highestCount, tempCount)
                
                tempCount = 0
                
                // reset the i back to previous occurance of of charArr[i]
                i = getLastOccuranceOf(ch: charArr[i], currI: i, charArr: charArr)
                
            } else {
                aSet.insert(ch)
            }
            
            i = i + 1
        }
        
        return highestCount
    }
    
    func longestSubstringUsingDict(input: String) -> Int {
        
        let charArr = Array(input)
        
        var lastOccuranceDict: [Character: Int] = [:]
        
        var tempResultSet = Set<Character>()
        
        var highestCount = 0
        
        var i = 0
        
        while i < charArr.count {
            
            let ch = charArr[i]
            
            if tempResultSet.contains(ch) {
                
                highestCount = max(highestCount, tempResultSet.count)
                
                tempResultSet = Set<Character>()
                
                i = lastOccuranceDict[ch] ?? 0
                
            } else {
                tempResultSet.insert(ch)
            }
            
            lastOccuranceDict[ch] = i
            
            i = i + 1
        }
        
        return max(highestCount, tempResultSet.count)
    }
}

/*
 print(Solution_longestSubstring().longestSubstringUsingDict(input: "") == 0)
 print(Solution_longestSubstring().longestSubstringUsingDict(input: "abcabcbc") == 3)
 print(Solution_longestSubstring().longestSubstringUsingDict(input: "abcbdfe") == 5)
 print(Solution_longestSubstring().longestSubstringUsingDict(input: "bbbbbbbbbb") == 1)
 print(Solution_longestSubstring().longestSubstringUsingDict(input: "abcbdfe"))
 */


/*
 
 https://leetcode.com/problems/longest-mountain-in-array/
 
 845. Longest Mountain in Array
 
 [2,1,4,7,3,2,5] -> [1,4,7,3,2]
 x
 
 
 */


/*
 
 [2,1,4,7,3,2,5]
 
 
 */

class Solution_longestMountain {
    func longestMountain(_ arr: [Int]) -> Int {
        var highCount = 0
        
        guard arr.count >= 3 else { return  highCount }
        
        for i in 1..<(arr.count-1) {
            highCount = max(highCount, getMountainCount(for: i, arr: arr))
        }
        
        return highCount
    }
    
    func getMountainCount(for c: Int, arr: [Int]) -> Int {
        
        var l = c

        while l - 1 >= 0 {
            if arr[l - 1] < arr[l] {
                l = l - 1
            } else {
                break
            }
        }

        var r = c
        
        while r + 1 <= (arr.count - 1) {
            
            if arr[r] > arr[r + 1] {
                r = r + 1
            } else {
                break
            }
        }
        
        let leftCount = c - l
        let rightCount = r - c
        
        guard leftCount > 0, rightCount > 0 else { return 0 }
        
        return leftCount + 1 + rightCount
    }
}

/*
 
let longInput = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,450,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,479,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,497,498,499,500,498,497,496,495,494,493,492,491,490,489,488,487,486,485,484,483,482,481,480,479,478,477,476,475,474,473,472,471,470,469,468,467,466,465,464,463,462,461,460,459,458,457,456,455,454,453,452,451,450,449,448,447,446,445,444,443,442,441,440,439,438,437,436,435,434,433,432,431,430,429,428,427,426,425,424,423,422,421,420,419,418,417,416,415,414,413,412,411,410,409,408,407,406,405,404,403,402,401,400,399,398,397,396,395,394,393,392,391,390,389,388,387,386,385,384,383,382,381,380,379,378,377,376,375,374,373,372,371,370,369,368,367,366,365,364,363,362,361,360,359,358,357,356,355,354,353,352,351,350,349,348,347,346,345,344,343,342,341,340,339,338,337,336,335,334,333,332,331,330,329,328,327,326,325,324,323,322,321,320,319,318,317,316,315,314,313,312,311,310,309,308,307,306,305,304,303,302,301,300,299,298,297,296,295,294,293,292,291,290,289,288,287,286,285,284,283,282,281,280,279,278,277,276,275,274,273,272,271,270,269,268,267,266,265,264,263,262,261,260,259,258,257,256,255,254,253,252,251,250,249,248,247,246,245,244,243,242,241,240,239,238,237,236,235,234,233,232,231,230,229,228,227,226,225,224,223,222,221,220,219,218,217,216,215,214,213,212,211,210,209,208,207,206,205,204,203,202,201,200,199,198,197,196,195,194,193,192,191,190,189,188,187,186,185,184,183,182,181,180,179,178,177,176,175,174,173,172,171,170,169,168,167,166,165,164,163,162,161,160,159,158,157,156,155,154,153,152,151,150,149,148,147,146,145,144,143,142,141,140,139,138,137,136,135,134,133,132,131,130,129,128,127,126,125,124,123,122,121,120,119,118,117,116,115,114,113,112,111,110,109,108,107,106,105,104,103,102,101,100,99,98,97,96,95,94,93,92,91,90,89,88,87,86,85,84,83,82,81,80,79,78,77,76,75,74,73,72,71,70,69,68,67,66,65,64,63,62,61,60,59,58,57,56,55,54,53,52,51,50,49,48,47,46,45,44,43,42,41,40,39,38,37,36,35,34,33,32,31,30,29,28,27,26,25,24,23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0]


print(Solution_longestSubstring().longestMountain([0,1,2,3,4,5,4,3,2,1,0]))
print(Solution_longestSubstring().longestMountain([0,2,4,3,2,-1]))
print(Solution_longestSubstring().longestMountain(longInput))
 
*/

/*
 
 https://leetcode.com/problems/long-pressed-name/description/
 
 925. Long Pressed Name
 
 Your friend is typing his name into a keyboard. Sometimes, when typing a character c, the key might get long pressed, and the character will be typed 1 or more times.

 You examine the typed characters of the keyboard. Return True if it is possible that it was your friends name, with some characters (possibly none) being long pressed.
 
 Example 1:

 Input: name = "alex", typed = "aaleex"
 Output: true
 Explanation: 'a' and 'e' in 'alex' were long pressed.
 Example 2:

 Input: name = "saeed", typed = "ssaaedd"
 Output: false
 Explanation: 'e' must have been pressed twice, but it was not in the typed output.
 
 */


// "alex", typed = "aaeex"

/*
 
 alex, aaleex
 
 a
 
 
 */

// "a", "aaab"
//

class Solution {

    func isLongPressedName(_ name: String, _ typed: String) -> Bool {
        
        var j = 0
        for ch in name {

            let extraTypedCount = checkExtraTyped(ch: ch, typed: typed, sIndex: j) // 2
            
            if extraTypedCount > j {
                j = extraTypedCount
            } else {
                return false
            }
        }
        
        if typed.count > j {
            return false
        }

        return true
    }
    
    private func checkExtraTyped(ch: Character, typed: String, sIndex: Int) -> Int {
        
        var typedCharArr = Array(typed)
        
        var j = sIndex
        
        while j < typedCharArr.count && ch == typedCharArr[j] {
            j = j + 1
        }
        
        return j
    }
}

print(Solution().isLongPressedName("a", "aab"))


// Wallmart 1, 2, 3
// ebay final
// epic games
// earnin
// recruiter
