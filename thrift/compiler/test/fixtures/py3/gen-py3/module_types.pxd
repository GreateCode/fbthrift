from libcpp.string cimport string
from libcpp cimport bool as cbool
from cpython cimport bool as pbool
from libc.stdint cimport int8_t, int16_t, int32_t, int64_t
from libcpp.memory cimport shared_ptr, unique_ptr
from thrift.lib.py3.thrift_server cimport cTException, TException

cdef extern from "src/gen-cpp2/module_types.h" namespace "py3::simple":
    cdef cppclass cSimpleException "py3::simple::SimpleException"(cTException):
        cSimpleException() except +
        int16_t err_code

    cdef cppclass cSimpleStruct "py3::simple::SimpleStruct":
        cSimpleStruct() except +
        cbool is_on
        int8_t tiny_int
        int16_t small_int
        int32_t nice_sized_int
        int64_t big_int
        double real


cdef extern from "<utility>" namespace "std" nogil:
    cdef shared_ptr[cSimpleException] move(unique_ptr[cSimpleException])
    cdef shared_ptr[cSimpleStruct] move(unique_ptr[cSimpleStruct])

cdef class SimpleException(TException):
    cdef shared_ptr[cSimpleException] c_SimpleException

    @staticmethod
    cdef create(shared_ptr[cSimpleException] c_SimpleException)

cdef class SimpleStruct:
    cdef shared_ptr[cSimpleStruct] c_SimpleStruct

    @staticmethod
    cdef create(shared_ptr[cSimpleStruct] c_SimpleStruct)

