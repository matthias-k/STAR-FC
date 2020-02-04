#cython: language_level=3


cdef extern from "utils.hpp":
    # I have no idea where Point actually comes from. Maybe opencv. But it's imported in utils.hpp
    cdef cppclass Point:
        int x, y

        Point() except +
        Point(int x, int y) except +

    cdef cppclass Mat:
        T* ptr[T](int row, int col)
