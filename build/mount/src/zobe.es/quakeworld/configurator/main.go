package main

import (
  "bufio"
  "flag"
  "fmt"
  "log"
  "os"
  "path"
  "strings"
  "text/template"
)

type Context struct {
}

func (c *Context) Env() map[string]string {
	env := make(map[string]string)
	for _, i := range os.Environ() {
		sep := strings.Index(i, "=")
		env[i[0:sep]] = i[sep+1:]
	}
	return env
}

func main() {
  flag.Parse()
  
  if (len(flag.Args()) < 2) {
    fmt.Printf("Usage: configurator <infile> <outfile>\n")
    os.Exit(1)
  }
  
  infile := flag.Arg(0)
  outfile := flag.Arg(1)
  
  log.Println(infile, "->", outfile)
  
  dir := path.Dir(outfile)
  err := os.MkdirAll(dir, 0755)
  if err != nil {
    log.Println("Error creating output directory", err)
    os.Exit(1)
  }
  
  t, err := template.ParseFiles(infile)
  if err != nil {
    log.Println("Error parsing template:", err)
    os.Exit(1)
  }
  
  fh, err := os.Create(outfile)
  if err != nil {
    log.Println("Error creating output file", err)
    os.Exit(1)
  }
  
  w := bufio.NewWriter(fh)
  
  err = t.Execute(w, &Context{})
  if err != nil {
    log.Println("Error executing template:", err)
    os.Exit(1)
  }
  
  w.Flush()
}