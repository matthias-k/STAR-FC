#cython: language_level=3

from libcpp.string cimport string
from libcpp.vector cimport vector

from utils cimport Point


cdef extern from "FixationHistoryMap.hpp":
    cdef cppclass FixationHistoryMap:
        vector[Point] fixationsList
