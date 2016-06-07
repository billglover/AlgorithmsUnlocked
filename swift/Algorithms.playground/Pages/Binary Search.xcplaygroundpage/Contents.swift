/*:
 # Binary Search

 The following description of the binary search algorithm is taken from
 [Algorithms Unlocked](http://amzn.to/1TTRwcs) by Thomas H. Cormen. The
 description has been modified slightly to align closer to the swift 
 implementation style.

 
 * callout(The Algorithm):
 Procudure Binary-Search(A, n, x)
 
    **Inputs:**
    - a: a sorted array of values
    - n: the number of elements in a to search through
    - x: the value to search for

    **Outputs:**
    - q: the index of the value we were searching for

    **Implementation:**
    1. Set p to 0, and set r to n.
    2. While p ≤ r, do the following:
       1. Set q to ⎣(p + r) / 2⎦
       2. If A[q] = x, then return q.
       3. Otherwise (A[q] ≠ x), if A[q] > x, then set r to q - 1.


 The implementation below is in Swift and, for the purposes of simplicity,
 assumes we are searching an array of integers `a: [Int]` for an integer
 value `x`.
 
 */
import Foundation

func binarySearch(array a: [Int], length n: Int, value x: Int) -> Int? {

    var p = 0           // the lower bound of our search range
    var r = n           // the upper bound of our search range

    while p <= r {
        let q = Int(floor(Double((p+r))/2.0))
        if a[q] == x {
            return q    // we have found our value so return index q
        } else {
            if a[q] > x {
                r = q-1
            } else {
                p = q+1
            }
        }
    }
    return nil          // we haven't found our value so return nil
}

/*:
---
 ## Simple Example
 
 We can test this by looking for the value 7 in an ordered array of the 
 numbers from 1 to 10.

 Remembering that arrays in Swift use indexes starting at 0, we would 
 expect to find the value 7 at location 6. i.e. `a[6] = 7`
 
 */

var valueToFind   = 7
var arrayToSearch = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
var n             = arrayToSearch.count - 1

var locationOfValue = binarySearch(array: arrayToSearch, length: n, value: valueToFind)


arrayToSearch[locationOfValue!]

/*:
 > The use of `locationOfValue!` here is potentially dangerous as it assumes we 
 > will always find the value we are looking for. If we don't find what we are 
 > looking for our algorithm will return `nil` and our program would crash.
 > 
 > Try modifying the code above to set `valueToFind` to number that doesn't appear 
 > in the array e.g. 15. What happens?
 > 
 > A better, but slightly more complex way of handling this is shown below.
 */

valueToFind   = 15
arrayToSearch = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
n             = arrayToSearch.count - 1

locationOfValue = binarySearch(array: arrayToSearch, length: n, value: valueToFind)

if let index = locationOfValue {
    arrayToSearch[index]
} else {
    "value not found"
}

/*:
 ---
 ## Extended Example
 
 One of the things we are interested in with algorithms is how they perform 
 as the size of their inputs varies. In our first example we saw how we 
 could find a value within an array of 10 values. But how would our algorithm
 perform if that array were 100, 1000 or even 10,000 values?
 
 Fortunately for us we can test this quite easily by wrapping our binary search
 algorithm in a loop that increases the size of our array.
 */
/*:
 > To help demonstrate this better, we are going to modify our binary search 
 > algorithm to return the number of iterations it takes rather than the
 > index of the value we are looking for.
 */

func binarySearchProfile(array a: [Int], length n: Int, value x: Int) -> Int {
    
    var p = 0           // the lower bound of our search range
    var r = n           // the upper bound of our search range
    var i = 0           // the number of iterations of our loop
    
    while p <= r {
        i = i+1
        let q = Int(floor(Double((p+r))/2.0))
        if a[q] == x {
            return i    // we have found our value
        } else {
            if a[q] > x {
                r = q-1
            } else {
                p = q+1
            }
        }
    }
    return i          // we haven't found our value
}

/*:
 A quick sense check shows that we return 1 for the number of iterations
 taken to find the value 5. This makes sense as it is the middle value 
 and therefore the first item our algorithm tests.
 */

valueToFind    = 5
arrayToSearch  = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
n              = arrayToSearch.count - 1
var iterations = binarySearchProfile(array: arrayToSearch, length: n, value: valueToFind)

/*:
 Next we need a loop that calls our binary search algorithm on ever 
 increasing data sets. The loop below shows how the size of our array 
 increases exponentially with each itteration.

 We search each array 100 times looking for a random value and keep track 
 of the average number of iterations it takes to find that value in our 
 array. This gives us a sense of how many iterations it takes to find 
 a value as the size of our input array increases.
 */

var executionCounts = [Int: Int]()

for test in 1...5 {
    let arraySize = Int(pow(10.0, Double(test))) // exponentially increasing array sizes
    let array = [Int](1...arraySize)
    let n = array.count - 1
    
    var iterations = 0
    for i in 1...100 {
        let v = Int(arc4random_uniform(UInt32(arraySize)))  // pick a random number to search for
        iterations = iterations + binarySearchProfile(array: array, length: n, value: v)
    }
    iterations = iterations / 100                           // keep track of the number of iterations
    executionCounts[arraySize] = iterations
}

/*:
 What we see is that as the size of our array increases exponentially, 
 we only see a linear increase in the time taken to search for a value 
 using the binary sort algorithm.
 */
let array = executionCounts.sort({$0.0 < $1.0})
array

//: Next: [Recursive Binary Search](Recursive%20Binary%20Search)

