package main

import (
	"errors"
	"fmt"
	"math/rand"
	"time"
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

func findRandomValueInArray(A []int, n int) int {
	randomValue := rand.Intn(n)
	iterations, _ := binarySearch(A, n, randomValue)
	return iterations
}

func main() {
	// seed the random number gnerator and log the seed
	seed := time.Now().UTC().UnixNano()
	rand.Seed(seed)
	fmt.Printf("Random seed: %d\n", seed)

	// generate array to search
	fmt.Printf("Generating array to search...")
	A := make([]int, 1000000000)
	for i := 0; i < len(A); i++ {
		A[i] = i
	}
	fmt.Printf("DONE\n")

	fmt.Printf("\nArray Size | Iterations\n")

	for n := 10; n <= len(A); n = n * 10 {
		sumOfIterations := 0
		for i := 0; i < 1000; i++ {
			sumOfIterations += findRandomValueInArray(A, n)
		}
		avgIterations := sumOfIterations / 1000
		fmt.Printf("%10d | %9d\n", n, avgIterations)
	}
}
