import sys

import py_star_fc

controller = py_star_fc.Controller()

controller.parseCommandLineOptions(sys.argv) 

controller.run()

print("DONE!")
