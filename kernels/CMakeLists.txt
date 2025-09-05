include(../cmake/CPM.cmake)

CPMAddPackage(
    NAME NVTX
    GITHUB_REPOSITORY NVIDIA/NVTX
    GIT_TAG v3.3.0-c-cpp
    GIT_SHALLOW TRUE)


set(CMAKE_CUDA_FLAGS "${CMAKE_CUDA_FLAGS} -Wno-deprecated-gpu-targets")
# Add the CUDA library for kernels
add_library(kernels myKernel.cu)
target_link_libraries(kernels PRIVATE nvtx3-cpp)

# Enable separable compilation for the library (optional but often useful)
set_property(TARGET kernels PROPERTY CUDA_SEPARABLE_COMPILATION ON)