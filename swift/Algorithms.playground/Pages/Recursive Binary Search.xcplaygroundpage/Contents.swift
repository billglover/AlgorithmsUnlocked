/*:
 # Recursive Binary Search
 
 The following description of the recursive binary search algorithm is taken from [Algorithms Unlocked](http://amzn.to/1TTRwcs) by Thomas H. Cormen. The description has been modified slightly to align closer to the swift implementation style.

 * callout(The Algorithm):
 Procudure Binary-Search(A, p, r, x)
 
    **Inputs:**
    - a: a sorted array of values
    - p: the lower bound of the sub-array to search through
    - r: the upper bound of the sub-array to search through
    - x: the value to search for
 
    **Outputs:**
    - q: the index of the value we were searching for
 
    **Implementation:**
    1. If p > r, then return 'not-found'
    2. Otherwise (p ≤ r), do the following:
        1. Set q to ⎣(p + r) / 2⎦
        2. If A[q] = x, then return q.
        3. Otherwise (A[q] ≠ x), if A[q] > x, then return binarySearch(a, p, q - 1, x).
        4. Otherwise (A[q] < x), then return binarySearch(a, q + 1, r, x).
 
 */
import Foundation

func binarySearch(a: [Int], p: Int, r: Int, x: Int) -> Int? {
    
    if p <= r {
        let q = Int(floor(Double((p+r))/2.0))
        if a[q] == x { return q }
        if a[q] > x { return binarySearch(a, p: p, r: q-1, x: x) }
        if a[q] < x { return binarySearch(a, p: q+1, r: r, x: x) }
    }
    return nil  // p > r, i.e. we haven't found what we are looking for
}

/*:
 ---
 ## Example
 
 We can test this by looking for the value 2 in an ordered array of the
 numbers from 1 to 10.
 
 Remembering that arrays in Swift use indexes starting at 0, we would
 expect to find the value 2 at location 1. i.e. `a[1] = 2`
 
 */

var valueToFind   = 2
var arrayToSearch = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
var n             = arrayToSearch.count - 1

var locationOfValue = binarySearch(arrayToSearch, p: 0, r: n, x: valueToFind)

if let index = locationOfValue {
    "Found '\(arrayToSearch[index])' at location '\(index)'."
} else {
    "Value \(valueToFind) not found"
}
