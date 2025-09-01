# Add the CUDA library for kernels
add_library(kernels myKernel.cu)

# Enable separable compilation for the library (optional but often useful)
set_property(TARGET kernels PROPERTY CUDA_SEPARABLE_COMPILATION ON)