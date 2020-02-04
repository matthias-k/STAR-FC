#cython: language_level=3

from libcpp.string cimport string
from libcpp.vector cimport vector

from utils cimport Point


cdef extern from "Eye.hpp":
    cdef cppclass Eye:
        Point getGazeCoords()
