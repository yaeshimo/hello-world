
// from mattn.kaoriya.net
// http://mattn.kaoriya.net/software/vim/20160129114716.htm
// vim ../ vim/fromgo.vim
// :source %

package main

import (
	"encoding/json"
	"log"
	"net"
	"time"
)

func main() {
	l, err := net.Listen("tcp", ":8080")
	if err != nil {
		log.Fatal(err)
	}

	for {
		conn, err := l.Accept()
		if err != nil {
			log.Fatal(err)
		}
		go func(conn net.Conn) {
			defer conn.Close()
			var b[500]byte
			// from vim json
			// [handle, msg]
			n, err := conn.Read(b[:])
			if err != nil {
				log.Println(err)
				return
			}
			var v [2]interface{}
			err = json.Unmarshal(b[:n], &v)
			if err != nil {
				log.Println(err)
				return
			}
			// use v[1] handle
			for {
				// update v[2]
				v[1] = time.Now().String()
				err = json.NewEncoder(conn).Encode(v)
				if err != nil {
					break
				}
				time.Sleep(1 * time.Second)
			}
		}(conn)
	}
}
