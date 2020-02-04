#cython: language_level=3

from libcpp.string cimport string
from libcpp.vector cimport vector

from utils cimport Point, Mat


cdef extern from "Environment.hpp":
    cdef cppclass Environment:
        int getHeight()
        int getWidth()

        int getFullHeight()
        int getFullWidth()
