# PDHCG public repository validation — 2026-10-02

The public repository layout was built, installed and tested on Linux using
`CUDA_HOME=/usr/local/cuda-12.8 GPU_ARCH=89 bash build.sh` after following INSTALL.
Build and installation completed with exit status **0**. The numerical test used
the installed `.coinor-deps/pdhcg-install/bin/pdhcg`, not a build-tree executable.

Environment: Ubuntu 22.04.5 x86_64, GCC/G++ 11.4.0, CMake 3.30.5,
Python 3.10.12, NumPy 1.26.4, NVIDIA RTX 4090, NVIDIA driver 580.82.07,
CUDA Toolkit 12.8.93, compute capability 89. Optional PreFOS, MPI/NCCL,
shared library and Python bindings were disabled in this installation check.

| Check | Result |
|---|---|
| Configure, build and install | PASS |
| Installed solver termination | OPTIMAL |
| Analytic QP solution | (1.000000102, 2.000000052), expected (1, 2) |
| Objective | -8.999999999999986, expected -9 |
| Independent primal feasibility residual | 1.54e-7, required <= 1e-6 |
| Solver-reported absolute dual residual | 6.11e-9, required <= 1e-6 |
| Stale success files + no-op executable | Correctly rejected |
| Fresh incorrect solution | Correctly rejected |

The 121 source/build/test input files listed in
[SOURCE_MANIFEST.sha256](validation/2026-10-02/SOURCE_MANIFEST.sha256) were verified
by SHA-256 against the actual remote test directory and the local publication
candidate. The solver sources and CMake remain unchanged from upstream commit
`0ea26dab177e3b75190915a3aa083535fbfa935b`.

Evidence: [summary](validation/2026-10-02/SUMMARY.json) and
[build/test log](validation/2026-10-02/build-and-tests.log).
Private host paths in the published log have been replaced by descriptive paths;
commands, tool versions, numerical results and outcomes are otherwise retained.

This records installation correctness for the documented single-GPU CLI
configuration. It is not a performance benchmark and does not validate multi-GPU
execution, all supported cones, optional Python/CVXPY interfaces, or native Windows.
The GitHub-hosted checker job does not execute the GPU solver; the workflow's
self-hosted GPU job is opt-in. No GitHub GPU run or COIN-OR acceptance is claimed.
