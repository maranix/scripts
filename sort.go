package main

import (
	"crypto/md5"
	"fmt"
	"os"
	"path/filepath"
)

func main() {
	err := filepath.Walk(".", func(path string, _ os.FileInfo, _ error) error {
		data := []byte(path)
		fmt.Printf(path+" %x\n", md5.Sum(data))
		return nil
	})

	if err != nil {
		fmt.Printf("error walking the path: %v\n", err)
		return
	}
}
