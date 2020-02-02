# cython: language_level=3
# distutils: language = c++
# cython: c_string_type=unicode, c_string_encoding=ascii


from cpython cimport array
#from cpython.string cimport PyString_AsString
from libc.stdlib cimport malloc, free

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

    #@property
    #def maxNumFixations(self):
    #    return self.c_controller.maxNumFixations
