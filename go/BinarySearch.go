package main

import (
	"errors"
	"fmt"
)

func binarySearch(A []int, n int, x int) (int, error) {
	p := 0
	r := n - 1

	for p <= r {
		q := (p + r) / 2
		if A[q] == x {
			return q, nil
		} else {
			if A[q] > x {
				r = q - 1
			} else {
				p = q + 1
			}
		}
	}

	return 0, errors.New("not found")
}

func main() {
	A := []int{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
	n := len(A)

	for x := 0; x < n; x++ {
		index, err := binarySearch(A, n, x)
		if err == nil {
			fmt.Printf("Value %d found at index %d\n", x, index)
		} else {
			fmt.Printf("Value %d %s\n", x, err)
		}
	}
}
