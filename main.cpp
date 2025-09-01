#include <iostream>
#include "kernels/myKernel.cuh"

int main() {
    std::cout << "Calling CUDA kernel..." << std::endl;
    call_cuda_kernel(); // Function defined in kernel.cu/h
    std::cout << "CUDA kernel finished." << std::endl;
    return 0;
}