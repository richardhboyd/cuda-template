#include <stdio.h>
#include <cuda_runtime.h>
#include "myKernel.cuh"

__global__ void simple_kernel() {
    printf("Hello from CUDA kernel!\n");
}

void call_cuda_kernel() {
    simple_kernel<<<1, 32>>>();
    cudaDeviceSynchronize(); // Ensure kernel completes before returning
}