import json
import sys
  
filename = sys.argv[1]
filecont = open(filename, "r").split().replace(" ","")
json.dump(filecont, "/json/filecont.json")
