package main

import (
	"fmt"
	"log"
	"os"
	"regexp"
)

var Anime = []string{"Enter Group names to sort"}

func createDir() {
	if _, err := os.Stat("Encoders folder"); err == nil {
		fmt.Println("Directory exists.")
	} else if os.IsNotExist(err) {
		err := os.Mkdir("Encoders folder", 0666)

		if err != nil {
			log.Fatal(err)
		}
	}

	for i := range Anime {
		if _, err := os.Stat("Encoders folder/[" + Anime[i] + "]"); err == nil {
			fmt.Println("Group directories exists.")
		} else if os.IsNotExist(err) {
			err := os.Mkdir("Encoders folder/["+Anime[i]+"]", 0666)

			if err != nil {
				log.Fatal(err)
			}
		}
	}
}

func createList() {
	file, err := os.Open(".")
	if err != nil {
		log.Fatal(err)
	}

	names, err := file.Readdirnames(0)
	if err != nil {
		log.Fatal(err)
	}

	createDir()

	for i := range Anime {
		re := regexp.MustCompile(Anime[i])
		for _, name := range names {
			match := re.FindAllString(name, -1)
			if match != nil {
				fmt.Println(name)
				err := os.Rename(name, "Encoders folder/["+Anime[i]+"]"+"/"+name)
				if err != nil {
					log.Fatal(err)
				}
			}
		}
	}
}

func main() {
	createList()
}
