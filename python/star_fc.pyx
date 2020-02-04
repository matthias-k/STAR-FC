# cython: language_level=3
# distutils: language = c++
# cython: c_string_type=unicode, c_string_encoding=ascii


from cpython cimport array
#from cpython.string cimport PyString_AsString
from libc.stdlib cimport malloc, free
from libcpp.string cimport string
from libcpp.vector cimport vector
from cython.operator cimport dereference

cimport numpy as np
import numpy as np

from utils cimport Point, Mat
from controller cimport Controller as CppController


import array   


# from https://stackoverflow.com/a/17511714
cdef char ** to_cstring_array(list_str):
    cdef char **ret = <char **>malloc(len(list_str) * sizeof(char *))
    for i in xrange(len(list_str)):
        #cdef char* s = list_str[i]
        ret[i] = list_str[i]
    return ret


cdef class Controller:
    cdef CppController c_controller

    def __cinit__(self):
        self.c_controller = CppController()

    def parseCommandLineOptions(self, list argv):
        cdef int c_argc = len(argv)
        cdef char** c_argv = to_cstring_array(argv)

        print("Parsing command line options")
        self.c_controller.parseCommandLineOptions(c_argc, c_argv)

        free(c_argv)

    def run(self):
        print("starting to run")
        self.c_controller.run()
        print("Done!")

    def init(self, imgFilename):
        cdef string c_imgFilename = imgFilename.encode('utf8')
        self.c_controller.init(c_imgFilename)

    def update(self, imgFilename):
        cdef string c_imgFilename = imgFilename.encode('utf8')
        self.c_controller.update(c_imgFilename)

    def runSTAR_FC(self):
        self.c_controller.runSTAR_FC()

    def runConditionalSTAR_FC(self, np.ndarray[np.int_t, ndim=2] fixationHistory, int maxNumFixations):
        cdef vector[Point] c_fixationHistory

        cdef Point point
        for _point in fixationHistory:
            point = Point(_point[0], _point[1])
            c_fixationHistory.push_back(point)

        self.c_controller.runConditionalSTAR_FC(c_fixationHistory, maxNumFixations)

    def getPriorityMap(self):
        cdef int height = dereference(self.c_controller.env).getHeight()
        cdef int width = dereference(self.c_controller.env).getWidth()
        cdef Mat mat = dereference(self.c_controller.priorityMap).getPriorityMap()

        cdef np.ndarray[np.double_t, ndim=2] priority_map = np.empty((height, width), dtype=np.double)

        for i in range(height):
            for j in range(width):
                priority_map[i, j] = dereference(mat.ptr[double](i, j))

        return priority_map

    def getFixationHistory(self):
        cdef list fixations = []
        cdef vector[Point] fixationsList = dereference(self.c_controller.fixHistMap).fixationsList
        
        for i in range(fixationsList.size()):
            fixations.append([
                fixationsList[i].x,
                fixationsList[i].y,
            ])
        
        return np.array(fixations)

    #@property
    #def maxNumFixations(self):
    #    return self.c_controller.maxNumFixations
