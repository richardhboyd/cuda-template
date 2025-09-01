cmake_minimum_required(VERSION 3.8 FATAL_ERROR)
enable_language(CUDA)
project(cmake_and_cuda LANGUAGES CXX CUDA)

add_executable(main main.cpp)
add_subdirectory(kernels)

target_link_libraries(main kernels)