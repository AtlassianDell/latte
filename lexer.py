import sys

filename = sys.argv[1]
filecont = open(filename).split("\n")

class token:
  class symb:
    define = "::"
    associate = ":"
    add = "+"
    sub = "-"
    mul = "*"
    div = "/"
  
