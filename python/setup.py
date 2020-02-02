import os

from distutils.core import setup, Extension

from Cython.Build import cythonize

STAR_FC_ROOT = os.environ['STAR_FC_ROOT']

setup(
    ext_modules=cythonize(Extension(
        "py_star_fc",
        ["star_fc.pyx"],
        language='c++',
        include_dirs=[
            STAR_FC_ROOT + '/src',
            STAR_FC_ROOT + '/contrib/inih/',
            STAR_FC_ROOT + '/contrib/inih/cpp',
            STAR_FC_ROOT + '/contrib/BMS_v2/mex/',
            STAR_FC_ROOT + '/contrib/VOCUS2/src/',
            '/opt/STAR_FC/contrib/caffe/include',
            '/usr/local/cuda-8.0/include',
            '/usr/include',
            '/usr/local/include/',
        ],
        library_dirs=[
            STAR_FC_ROOT,
            '/usr/lib/x86_64-linux-gnu',
            '/opt/STAR_FC/contrib/caffe/build/lib/',
            '/usr/local/lib/',  # protobuf
        ],
        libraries=['STAR_FC'],
        #libraries=[
            #'boost_system', 'boost_filesystem', 'boost_serialization', 'boost_program_options',
            #'opencv_calib3d', 'opencv_core', 'opencv_cudaarithm', 'opencv_cudabgsegm', 'opencv_cudacodec', 'opencv_cudafeatures2d',
            #'opencv_cudafilters', 'opencv_cudaimgproc', 'opencv_cudalegacy', 'opencv_cudaobjdetect', 'opencv_cudaoptflow', 'opencv_cudastereo', 'opencv_cudawarping',
            #'opencv_cudev', 'opencv_dnn', 'opencv_features2d', 'opencv_flann', 'opencv_highgui', 'opencv_imgcodecs', 'opencv_imgproc', 'opencv_ml', 'opencv_objdetect', 'opencv_photo',
            #'opencv_shape', 'opencv_stitching', 'opencv_superres', 'opencv_video', 'opencv_videoio', 'opencv_videostab',
            #'caffe',
            #'fftw3f', 'fftw3f_threads',
            #'matio',
            #'glog',
            #'protobuf',
        #],
        #extra_objects=[STAR_FC_ROOT + '/libSTAR_FC.a'],
        extra_compile_args=["-std=c++11", '-fopenmp'],
        extra_link_args=["-std=c++11", '-fopenmp']
    ))
)
