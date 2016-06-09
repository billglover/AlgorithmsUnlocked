package main

import (
	"testing"
	"fmt"
	"time"
	"math/rand"
	"os"
)

func TestMain(m *testing.M) {
	// seed the random number gnerator and log the seed
	seed := time.Now().UTC().UnixNano()
	rand.Seed(seed)
	fmt.Printf("Random seed: %d\n", seed)

	os.Exit(m.Run())
}

func TestValueFound(t *testing.T) {
	
	A := make([]int, 100)
	n := len(A)
	x := rand.Intn(n)

	// create an array to search
	for i := 0; i < n; i++ {
		A[i] = i
	}

	// find our value	
	_, err := binarySearch(A, n, x)
	if err != nil {
		t.Fail()
	}
}

func TestValueNotFound(t *testing.T) {
	
	A := make([]int, 100)
	n := len(A)
	x := -1

	// create an array to search
	for i := 0; i < n; i++ {
		A[i] = i
	}

	// find our value	
	_, err := binarySearch(A, n, x)
	if err == nil {
		t.Fail()
	}
}

func BenchmarkBinarySort(b *testing.B) {
	A := make([]int, 1000000)
	n := len(A)

	// create an array to search
	for i := 0; i < n; i++ {
		A[i] = i
	}

	b.ResetTimer()

	for i := 0; i < b.N; i++ {
		x := rand.Intn(n)
		binarySearch(A, n, x)
	}
}