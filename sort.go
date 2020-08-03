package main

import (
	"fmt"
	"os"
)

func main() {
	file, err := os.Open(".")
	if err != nil {
		fmt.Println(err)
	}
	names, err := file.Readdirnames(0)
	if err != nil {
		fmt.Println(err)
	}

	for _, name := range names {
		fmt.Println(name)
	}

}
