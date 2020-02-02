#cython: language_level=3


cdef extern from "Controller.hpp":
    cdef cppclass Controller:
        Controller() except +
        #int maxNumFixations, numSubjects, curSubject, partNumFixations, blendingStrateg
        void parseCommandLineOptions(int argc, char *argv[])
        void run()
