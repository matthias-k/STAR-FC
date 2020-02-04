#cython: language_level=3

from libcpp.string cimport string
from libcpp.vector cimport vector

from utils cimport Point
from fixationHistoryMap cimport FixationHistoryMap
from priorityMap cimport PriorityMap
from environment cimport Environment
from eye cimport Eye


cdef extern from "Controller.hpp":
    cdef cppclass Controller:
        FixationHistoryMap* fixHistMap
        Eye* eye
        Environment* env
        PriorityMap* priorityMap

        Controller() except +
        #int maxNumFixations, numSubjects, curSubject, partNumFixations, blendingStrateg
        void parseCommandLineOptions(int argc, char *argv[])
        void run()
        void init(string imgFilename)
        void update(string imgFilename)
        void runSTAR_FC()
        void runConditionalSTAR_FC(vector[Point], int maxNumFixations)
