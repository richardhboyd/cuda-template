#include <stdio.h>
#include <cuda_runtime.h>
#include <nvtx3/nvtx3.hpp> // Include the NVTX3 header
#include "myKernel.cuh"

__device__ int cube (int x)
{
  int y;
  asm(".reg .u32 t1;\n\t"              // temp reg t1
      " mul.lo.u32 t1, %1, %1;\n\t"    // t1 = x * x
      " mul.lo.u32 %0, t1, %1;"        // y = t1 * x
      : "=r"(y) : "r" (x));
  return y;
}

__device__ int cpp_cube(int x)
{
  int y = x*x*x;
  return y;
}

__global__ void asm_kernel(int input, float *out) {
    int idx = blockIdx.x*blockDim.x + threadIdx.x;
    int x = cube(idx);
    out[idx] = x;
}

__global__ void simple_kernel(int input, float *out) {
    int idx = blockIdx.x*blockDim.x + threadIdx.x;
    int y = cpp_cube(idx);
    out[idx] = y;
}

void call_cuda_kernel(int input) {
    float *A, *B, *d_A, *d_B;
    int A_size = 32;
    int B_size = 32;
    A = (float*)malloc(A_size*sizeof(int));
    B = (float*)malloc(B_size*sizeof(int));
    cudaMalloc(&d_A, A_size*sizeof(int));
    cudaMalloc(&d_B, B_size*sizeof(int));

    nvtxRangePushA("asm cube"); 
    asm_kernel<<<2, 32>>>(input, d_A);
    cudaDeviceSynchronize();
    cudaMemcpy(A, d_A, A_size*sizeof(int), cudaMemcpyDeviceToHost);
    nvtxRangePop();

    nvtxRangePushA("cpp cube"); 
    simple_kernel<<<2, 32>>>(input, d_B);
    cudaDeviceSynchronize();
    cudaMemcpy(B, d_B, B_size*sizeof(int), cudaMemcpyDeviceToHost);
    nvtxRangePop();
}