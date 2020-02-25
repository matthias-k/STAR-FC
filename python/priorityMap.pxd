#cython: language_level=3

from libcpp.string cimport string
from libcpp.vector cimport vector

from utils cimport Point, Mat


cdef extern from "PriorityMap.hpp":
    cdef cppclass PriorityMap:
        Mat getPriorityMap()
