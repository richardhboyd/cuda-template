# Template

```
mkdir cmake
wget -O cmake/CPM.cmake https://github.com/cpm-cmake/CPM.cmake/releases/latest/download/get_cpm.cmake

mkdir build
cd build
cmake .. && cmake --build . && nsys profile --trace=cuda,nvtx,osrt --force-overwrite true -o my_profile ./main
```