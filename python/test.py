import os
import sys

import numpy as np

import py_star_fc

controller = py_star_fc.Controller()
controller.parseCommandLineOptions(sys.argv) 

filename = '/opt/input_dir/Action_015.jpg'

controller.init(filename)

print("init done")


print("exists", os.path.exists(filename))

print("update done")

expected = np.array(
    [[ 960., 1094., 1091., 1121., 1119.,  995.,  993.,  888.,  825.,
       821.,  761.,  757.,  698.,  695.,  587.,  585.,  506.,  656.,
       647.,  599.],
     [ 540.,  467.,  463.,  626.,  627.,  658.,  657.,  687.,  700.,
       699.,  708.,  709.,  731.,  732.,  745.,  745.,  762.,  952.,
       953.,  996.]]
)

#image size (1080, 1920
#fixation_history = np.vstack((np.array([[960, 540]], dtype=np.int), expected.T))[:2]
#fixation_history = np.array([[960, 540]])

for conditioning_length in range(1, len(expected.T)):
    controller.update(filename)
    print("Conditioning on", conditioning_length, "fixations")
    fixation_history = expected.T[:conditioning_length]
    controller.runConditionalSTAR_FC(fixation_history.astype(np.int), len(expected.T))
    actual = controller.getFixationHistory()
    np.testing.assert_allclose(actual, expected.T)

print(controller.getPriorityMap())

