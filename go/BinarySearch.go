package main

import (
	"errors"
	"fmt"
)

func binarySearch(A []int, n int, x int) (int, error) {
	p := 0
	r := n - 1
	iterations := 0

	for p <= r {
		iterations++
		q := (p + r) / 2
		if A[q] == x {
			return iterations, nil
		} else {
			if A[q] > x {
				r = q - 1
			} else {
				p = q + 1
			}
		}
	}

	return iterations, errors.New("not found")
}

func main() {
	fmt.Println("To demonstrate Binary Search, please execute the tests.\n")
	fmt.Println("\tgo test -v ./....\n")
	fmt.Println("Or use the -bench flag to include benchmarks.\n")
	fmt.Println("\tgo test -bench . -v ./....\n")
}
