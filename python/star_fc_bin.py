import sys

import star_fc

controller = star_fc.Controller()

controller.parseCommandLineOptions(sys.argv) 

controller.run()

print("DONE!")
