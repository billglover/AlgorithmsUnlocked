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

func BenchmarkBinarySort1K(b *testing.B) {BinarySortBenchmark(b, 1000)}
func BenchmarkBinarySort10K(b *testing.B) {BinarySortBenchmark(b, 10000)}
func BenchmarkBinarySort100K(b *testing.B) {BinarySortBenchmark(b, 100000)}
func BenchmarkBinarySort1M(b *testing.B) {BinarySortBenchmark(b, 1000000)}
func BenchmarkBinarySort10M(b *testing.B) {BinarySortBenchmark(b, 10000000)}

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

func BinarySortBenchmark(b *testing.B, n int) {
	A := make([]int, n)

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
